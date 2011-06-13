//
//  MCChatServiceManager.m
//  Serwus
//
//  Created by Madis Nõmme on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatServiceManager.h"


@implementation MCChatServiceManager


+ (MCChatServiceManager *)sharedManager
{
	static MCChatServiceManager *instance = nil;

	if (instance == nil) {
		instance = [[MCChatServiceManager alloc] init];
	}
	return instance;
}

- (void)startChatServer
{
	
}

- (void)startLookingForOthers
{
	
}

#pragma mark NSObject


@end
