//
//  MCServiceListController.m
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCServiceListController.h"


@interface MCServiceListController (BonjourDiscovery)
@end

@implementation MCServiceListController

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
// - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

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
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
