//
//  MCChatClientsManager.m
//  Serwus
//
//  Created by Madis Nõmme on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatClientsManager.h"
#import "MCChatClient.h"

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

- (void)addClient: (MCChatClient *)client
{
	[self.chatClients addObject:client];
}

- (void)removeClient: (MCChatClient *)client
{
	if ([self.chatClients containsObject:client]) {
		[self.chatClients removeObject:client];
	}
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
