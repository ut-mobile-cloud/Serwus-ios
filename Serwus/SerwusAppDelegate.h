//
//  SerwusAppDelegate.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCServiceListController;
@class MCChatClientListController;

@interface SerwusAppDelegate : NSObject <UIApplicationDelegate> {
	UITabBarController *tabBarController;
	UINavigationController *chatListNavigationController;
	MCChatClientListController *chatListController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *chatListNavigationController;
@property (nonatomic, retain) IBOutlet MCChatClientListController *chatListController;

@end
