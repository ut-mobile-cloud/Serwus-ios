//
//  MCChatServer.m
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatServer.h"

@implementation MCChatServer

+ (MCChatServer *)sharedServer
{
	static MCChatServer *instance = nil;
	if (instance == nil) {
		instance = [[MCChatServer alloc] init];
	}
	return instance;
}

- (void)startService
{
	netService = [[NSNetService alloc] initWithDomain:@"" type:MCChatServiceType name:@"" port:MCChatServicePort];
	netService.delegate = self;
}

- (void)stopService
{
	[netService stop];
	[netService release];
	netService = nil;
}

#pragma mark NSNetServiceDelegate

@end
