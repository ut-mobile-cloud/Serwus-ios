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
