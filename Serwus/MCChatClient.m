//
//  MCChatClient.m
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatClient.h"
#import "MCChatServer.h"

@interface MCChatClient () // We want these properties to be writable for the class itself

@property (readwrite, retain) NSNetServiceBrowser *browser;
@property (readwrite, retain) NSMutableArray *services;
@property (readwrite, assign) BOOL isConnected;
@property (readwrite, retain) NSNetService *connectedService;

@end

@implementation MCChatClient

@synthesize browser, connectedService, isConnected, services;


- (void)search
{
	[self.browser searchForServicesOfType:MCChatServiceType inDomain:@""];
}

// Currently will connect to last object in the list of services
// TODO: Add an 
- (void)connectTo:(NSNetService *)selectedService;
{
	
	if (selectedService == nil) {
		selectedService = [self.services lastObject];
	}
	selectedService.delegate = self;
	[selectedService resolveWithTimeout:0];
	
}

- (void)connect
{
	
}
#pragma mark NSNetServiceBrowserDelegate

-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didFindService:(NSNetService *)aService moreComing:(BOOL)more {
    [self.services addObject:aService];
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didRemoveService:(NSNetService *)aService moreComing:(BOOL)more {
    [self.services removeObject:aService];
    if ( aService == self.connectedService ) self.isConnected = NO;
}

-(void)netServiceDidResolveAddress:(NSNetService *)service {
    self.isConnected = YES;
    self.connectedService = service;
}

-(void)netService:(NSNetService *)service didNotResolve:(NSDictionary *)errorDict {
    NSLog(@"Could not resolve: %@", errorDict);
}

#pragma mark NSNetServiceDelegate

#pragma mark NSObject

- (id)init
{
	self = [super init];
	if (self != nil) {
		services = [NSMutableArray new];
		self.browser = [[NSNetServiceBrowser new] autorelease];
		self.browser.delegate = self;
		self.isConnected = NO;
	}
	return self;
}

-(void)dealloc {
    self.connectedService = nil;
    self.browser = nil;
    [services release];
    [super dealloc];
}

@end
