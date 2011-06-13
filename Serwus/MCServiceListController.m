//
//  MCServiceListController.m
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCServiceListController.h"
#import "MCServiceDetailsController.h"

#define MCServiceListTableViewTag 1111
@interface MCServiceListController (BonjourDiscovery)
@end

@implementation MCServiceListController

- (void)refreshPressed:(id)sender
{
	DLog(@"Refresh pressed");
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = 100;
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

- (void)awakeFromNib
{
	DLog(@"I was woken");
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark UIViewController

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
