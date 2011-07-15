//
//  MCChatClientListController.m
//  Serwus
//
//  Created by Madis Nõmme on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatClientListController.h"
#import "MCChatClientsManager.h"
#import "MCChatClient.h"
#import "MCChatController.h"

@implementation MCChatClientListController

@synthesize chatClientsTable;
@synthesize navigationController;

- (void)userSelectedChatClient:(MCChatClient *)client
{
	MCChatController *chatController = [[MCChatController alloc] initWithNibName:@"MCChatController" bundle:nil];
	[self.navigationController pushViewController:chatController animated:YES];
	[chatController release];
}
- (void)chatClientsChanged
{
	[self.chatClientsTable reloadData];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = [MCChatClientsManager sharedManager].chatClients.count;
	return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger sections = 1;
	return sections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MCChatClientsListCellIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell 	alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
    }
	
    MCChatClient *client = [[MCChatClientsManager sharedManager].chatClients objectAtIndex:indexPath.row];
	cell.textLabel.text = client.name;
	
    return cell;
}


#pragma mark UITableViewDelegate
// All method optional
// - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
// - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
// - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
// - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)awakeFromNib
{
	DLog(@"ChatClientListController AWAKE FROM NIB");
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	DLog(@"ChatClientListController INIT WITH NIB");
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.chatClientsTable reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	[self setChatClientsTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark NSObject

- (void)dealloc
{
	[navigationController release];
	[chatClientsTable release];
    [super dealloc];
}

@end
