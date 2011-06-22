//
//  MCServiceListController.m
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCServiceListController.h"
#import "MCServiceDetailsController.h"
#import "MCChatServer.h"
#import "MCChatClient.h"
#import "MCChatClientsManager.h"

#define MCServiceListTableViewTag 1111
@interface MCServiceListController (BonjourDiscovery)
@end

@implementation MCServiceListController

- (void)refreshPressed:(id)sender
{
	DLog(@"Requesting search of clients");
	MCChatClientsManager *manager = [MCChatClientsManager sharedManager];
	[manager search];
}

- (void)servicesUpdated:(id)sender
{
	DLog(@"Services updated notification received. Updating table view");
	[self.servicesTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
}

@dynamic servicesTable;
- (UITableView *)servicesTable
{
	return (UITableView *)[self.view viewWithTag:MCServiceListTableViewTag];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = [MCChatClientsManager sharedManager].chatClients.count;
	DLog(@"TableView will have %d rows", rows);
	return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger sections = 1;
	return sections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MCSerwusTableViewCellIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
    }
	MCChatClient *chatClient = [[MCChatClientsManager sharedManager].chatClients objectAtIndex:indexPath.row];
	cell.textLabel.numberOfLines = 0;
	cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@", [chatClient.remoteService name], [chatClient.remoteService hostName]];
    return cell;
}


#pragma mark UITableViewDelegate
// All method optional
// - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
// - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
// - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MCServiceDetailsController *serviceDetailsController = [[MCServiceDetailsController alloc] initWithNibName:@"MCServiceDetailsController" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:serviceDetailsController animated:YES];
	[serviceDetailsController release];
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
    [super dealloc];
}

@end
