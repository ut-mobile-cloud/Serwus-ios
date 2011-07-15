//
//  MCChatClientListController.h
//  Serwus
//
//  Created by Madis Nõmme on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCChatController;
@class MCChatClient;

@interface MCChatClientListController : UIViewController<UITableViewDataSource, UITableViewDelegate> {

	UITableView *chatClientsTable;
	UINavigationController *navigationController;
	
}

@property (nonatomic, retain) IBOutlet UITableView *chatClientsTable;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (void)userSelectedChatClient:(MCChatClient *)client;
@end
