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

@implementation SerwusAppDelegate

@synthesize window=_window;
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[MCWebServer sharedServer] setUpAndLaunch];
	[[MCChatServer sharedServer] startService];
	[[MCServiceBrowser sharedBrowser] search];
//	[[MCChatClientsManager sharedManager] search];
	
	[self.window addSubview:tabBarController.view];
	[self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
	[_window release];
	[tabBarController release];
    [super dealloc];
}

@end
