//
//  MCServiceListController.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const MCUserSelectedChatNotification;
extern NSString * const MCSelectedChatClientKey;

@interface MCServiceListController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    
	UITableViewCell *customServiceListCell;
}

@property (nonatomic, readonly) UITableView *servicesTable;
@property (nonatomic, retain) IBOutlet UITableViewCell *customServiceListCell;

@end
