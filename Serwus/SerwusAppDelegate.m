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

@implementation SerwusAppDelegate


@synthesize window=_window;
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self.window addSubview:tabBarController.view];
	[[MCChatServer sharedServer] startService];
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
