//
//  MCChatClientsManager.m
//  Serwus
//
//  Created by Madis Nõmme on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatClientsManager.h"
#import "MCChatServer.h"
#import "MCChatClient.h"
#import "AsyncSocket.h"

@implementation MCChatClientsManager

@synthesize browser;
@synthesize chatClients;

+ (MCChatClientsManager *)sharedManager
{
	static MCChatClientsManager *instance = nil;
	
	if (instance == nil) {
		instance = [[MCChatClientsManager alloc] init];
	}
	return instance;
}

- (void)search {
	DLog(@"Manager will now search for services");
//	[self.browser stop];
//	[self.chatClients removeAllObjects];
	[self.browser searchForServicesOfType:MCChatServiceType inDomain:@""]; // Empty domain results to searching from local.
	
}

#pragma NSNetServiceBrowserDelegate

-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didFindService:(NSNetService *)aService moreComing:(BOOL)more {
	DLog(@"Found a service, more ? [%@]", more ? @"YES" : @"NO");
	MCChatClient *newClient = [[MCChatClient alloc] init];
	newClient.remoteService = aService;
    [self.chatClients addObject:newClient];
	if (more == NO) {
		[[NSNotificationCenter defaultCenter] postNotificationName:MCServicesUpdatedNotification object:self];
	}
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didRemoveService:(NSNetService *)aService moreComing:(BOOL)more {
	DLog(@"Will remove a service");
	for (MCChatClient *client in self.chatClients) {
		if (client.remoteService == aService) {
			DLog(@"found a client to remove. %d clients before removing", [self.chatClients count]);
			[self.chatClients removeObject:client];
			DLog(@"%d clients after removing", [self.chatClients count]);
			[[NSNotificationCenter defaultCenter] postNotificationName:MCServicesUpdatedNotification object:self];
		}
	}
}

-(void)netServiceDidResolveAddress:(NSNetService *)service {
    NSError *error;
	DLog(@"Resolved a service");
	for (MCChatClient *client in self.chatClients) {
		if (client.remoteService == service) {
			DLog(@"Found a service to remove");
			client.socket = [[[AsyncSocket alloc] initWithDelegate:self] autorelease];
			[client.socket connectToAddress:service.addresses.lastObject error:&error];
		}
	}
}

-(void)netService:(NSNetService *)service didNotResolve:(NSDictionary *)errorDict {
    NSLog(@"Could not resolve: %@", errorDict);
}


#pragma mark NSObject

- (id)init
{
	self = [super init];
	if (self != nil) {
		browser = [NSNetServiceBrowser new];
		browser.delegate = self;
		chatClients = [NSMutableArray new];
	}
	return self;
}

- (void)dealloc
{
	[self.browser release];
	[self.chatClients release]; // Should some other things with clients before releasing them?
	
	[super dealloc];
}
@end
