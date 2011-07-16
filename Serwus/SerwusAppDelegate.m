//
//  SerwusAppDelegate.m
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SerwusAppDelegate.h"
#import "MCServiceListController.h"
#import "MCChatServer.h"
#import "MCChatClientsManager.h"
#import "MCWebServer.h"
#import "MCServiceBrowser.h"
#import "UI/MCChatClientListController.h"

@implementation SerwusAppDelegate

@synthesize window=_window;
@synthesize tabBarController;
@synthesize chatListNavigationController;
@synthesize chatListController;

- (void)userSelectedChat:(NSNotification *)notification
{
	DLog(@"User selected chat with info : %@", [notification userInfo]);
	NSDictionary *userInfo = [notification userInfo];
	self.tabBarController.selectedViewController = self.chatListNavigationController;
	[self.chatListController userSelectedChatClient:[userInfo objectForKey:MCSelectedChatClientKey]];
	
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[MCWebServer sharedServer] setUpAndLaunch];
	[[MCChatServer sharedServer] startService];
	[[MCServiceBrowser sharedBrowser] search];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userSelectedChat:) name:MCUserSelectedChatNotification object:nil];
	
	[self.window addSubview:tabBarController.view];
	[self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[_window release];
	[tabBarController release];
	[chatListNavigationController release];
	[chatListController release];
    [super dealloc];
}

@end
