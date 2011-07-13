//
//  MCChatClientsManager.m
//  Serwus
//
//  Created by Madis Nõmme on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatClientsManager.h"
#import "MCServiceBrowser.h"
#import "MCChatServer.h"
#import "MCChatClient.h"
#import "AsyncSocket.h"

@implementation MCChatClientsManager

@synthesize chatClients;

+ (MCChatClientsManager *)sharedManager
{
	static MCChatClientsManager *instance = nil;
	
	if (instance == nil) {
		instance = [[MCChatClientsManager alloc] init];
	}
	return instance;
}

#pragma mark NSObject

- (id)init
{
	self = [super init];
	if (self != nil) {
		chatClients = [NSMutableArray new];
	}
	return self;
}

- (void)dealloc
{
	[self.chatClients release]; // Should some other things with clients before releasing them?
	[super dealloc];
}
@end
