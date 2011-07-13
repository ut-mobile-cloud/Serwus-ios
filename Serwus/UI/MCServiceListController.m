//
//  MCServiceListController.m
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCServiceListController.h"
#import "MCServiceDetailsController.h"
#import "MCServiceBrowser.h"
#import "MCChatController.h"
#import "MCChatClient.h"

#define MCServiceListTableViewTag 1111
#define MCServiceCellServiceNameTag 5000
#define MCServiceCellServiceTypeImageTag 5001

static NSString * const MCServiceCellReuseIdentifier = @"MCServiceCellReuseIdentifier";

@interface MCServiceListController (PrivateMethods)
- (void)handleUserSelectedChatService:(NSNetService *)service;
- (void)handleUserSelectedRestService:(NSNetService *)service;
@end

@implementation MCServiceListController

@dynamic servicesTable;
@synthesize customServiceListCell;

- (void)handleUserSelectedChatService:(NSNetService *)service
{
	MCChatController *chatController = [[MCChatController alloc] initWithNibName:@"MCChatController" bundle:nil];
	
	chatController.chatClient = [[MCChatClient alloc] initWithNetService:service];
	[self.navigationController pushViewController:chatController animated:YES];
	[chatController release];
}

- (void)handleUserSelectedRestService:(NSNetService *)service
{
	MCServiceDetailsController *serviceDetailsController = [[MCServiceDetailsController alloc] initWithNibName:@"MCServiceDetailsController" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:serviceDetailsController animated:YES];
	[serviceDetailsController release];
}

- (UITableViewCell *)loadCell
{
	[[NSBundle mainBundle] loadNibNamed:@"MCServiceCell" owner:self options:nil];
	return self.customServiceListCell;
}
- (void)refreshPressed:(id)sender
{
	DLog(@"Requesting search of clients");
	[[MCServiceBrowser sharedBrowser] search];
}

- (void)servicesUpdated:(id)sender
{
	DLog(@"Services updated notification received. Updating table view");
	[self.servicesTable reloadData];
}

- (UITableView *)servicesTable
{
	return (UITableView *)[self.view viewWithTag:MCServiceListTableViewTag];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = 0;
	if (section == 0) {
		rows = [[MCServiceBrowser sharedBrowser].chatServices count];
	} else if(section == 1) {
		rows = [[MCServiceBrowser sharedBrowser].restServices count];
	}
	DLog(@"TableView will have %d rows", rows);
	return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger sections = 2;
	return sections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MCServiceCellReuseIdentifier];
    if (cell == nil) {
        cell = [self loadCell];
    }
	
	int serviceType = indexPath.section == 0 ? kMCChatServiceType : kMCRestServiceType;
	NSNetService *service = [[MCServiceBrowser sharedBrowser] serviceOfType:serviceType atIndex:indexPath.row];
	UILabel *serviceName = (UILabel *)[cell viewWithTag:MCServiceCellServiceNameTag];
	serviceName.text = [service name];
    return cell;
}


#pragma mark UITableViewDelegate
// All method optional
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 88;
}
// - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
// - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *headerTitle = nil;
	if (section == 0) {
		headerTitle = @"Chat";
	} else if (section == 1) {
		headerTitle = @"REST services";
	}
	return headerTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	MCServiceType serviceType = indexPath.section == 0 ? kMCChatServiceType : kMCRestServiceType;
	
	NSNetService *service = [[MCServiceBrowser sharedBrowser] serviceOfType:serviceType atIndex:indexPath.row];
	
	if (serviceType == kMCChatServiceType) {
		[self handleUserSelectedChatService:service];
	} else if(serviceType == kMCRestServiceType) {
		[self handleUserSelectedRestService:service];
	}
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark UIViewController

- (void)awakeFromNib
{
	DLog(@"I was woken");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reload"] style:UIBarButtonSystemItemRefresh target:self action:@selector(refreshPressed:)];
	[self navigationItem].rightBarButtonItem = refreshButton;
	[refreshButton release];
	self.navigationController.navigationBar.topItem.title = @"Services";
}

- (void)viewDidUnload
{
	[self setCustomServiceListCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	UITableView *serviceListTable = (UITableView *)[self.view viewWithTag:MCServiceListTableViewTag];
	[serviceListTable deselectRowAtIndexPath:[serviceListTable indexPathForSelectedRow] animated:YES];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(servicesUpdated:) name:MCServicesUpdatedNotification object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark NSObject

- (void)dealloc
{
	[customServiceListCell release];
    [super dealloc];
}

@end
