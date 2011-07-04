//
//  MCServiceBrowser.m
//  Serwus
//
//  Created by Madis Nõmme on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCServiceBrowser.h"
#import "MCChatServer.h"
#import "MCWebServer.h"

NSString * const MCServicesUpdatedNotification = @"MCServicesUpdatedNotification";

MCServiceType ServiceTypeFromString(NSString *serviceName)
{
	NSRange chatRange = [serviceName rangeOfString:MCChatServiceBaseName];
	if (chatRange.location != NSNotFound) {
		return kMCChatServiceType;
	}
	
	NSRange restRange = [serviceName rangeOfString:MCWebServerServiceBaseName];
	if (restRange.location != NSNotFound) {
		return kMCRestServiceType;
	}
	
	return kMCUnknownServiceType;
}

@implementation MCServiceBrowser
@synthesize chatServiceBrowser, restServiceBrowser, chatServices, restServices;

+ (MCServiceBrowser *)sharedBrowser
{
	static MCServiceBrowser *instance = nil;
	if (instance == nil) {
		instance = [[MCServiceBrowser alloc] init];
	}
	return instance;
}

- (void)search
{
	DLog(@"Service Browser starting to search");
	DLog(@"Searching for : %@ AND %@", MCChatServiceType, MCWebServerServiceType);
	[self.chatServiceBrowser searchForServicesOfType:MCChatServiceType inDomain:@""];
	[self.restServiceBrowser searchForServicesOfType:MCWebServerServiceType inDomain:@""];
}

- (NSNetService *)serviceOfType:(MCServiceType)serviceType atIndex:(int)index
{
	NSNetService *chosenService = nil;
	switch (serviceType) {
		case kMCChatServiceType:
			chosenService = [self.chatServices objectAtIndex:index];
			break;
		case kMCRestServiceType:
			chosenService = [self.restServices objectAtIndex:index];
		default:
			break;
	}
	return chosenService;
}

#pragma NSNetServiceBrowserDelegate

-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didFindService:(NSNetService *)aService moreComing:(BOOL)moreComing {
	DLog(@"Found a service, more ? [%@]", moreComing ? @"YES" : @"NO");
	
	NSString *serviceName = [aService name];
	DLog(@"Found service has name : %@", serviceName);
	
	switch (ServiceTypeFromString(serviceName)) {
		case kMCRestServiceType:
			DLog(@"Got a REST service");
			[self.restServices addObject:aService];
			break;
		case kMCChatServiceType:
			DLog(@"Got a Chat service");
			[self.chatServices addObject:aService];
			break;
		case kMCUnknownServiceType:
			DLog(@"Got Unknown service type");
			break;
		default:
			DLog(@"Something went wrong w/ ServiceTypeFromString(...)");
			break;
	}
	if (moreComing == NO) {
		[[NSNotificationCenter defaultCenter] postNotificationName:MCServicesUpdatedNotification object:self];
	}
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
	NSString *serviceName = [aNetService name];
	switch (ServiceTypeFromString(serviceName)) {
		case kMCRestServiceType:
			DLog(@"Removing rest service");
			[self.restServices removeObject:aNetService];
			break;
		case kMCChatServiceType:
			DLog(@"Removing chat service");
			[self.chatServices removeObject:aNetService];
			break;
		case kMCUnknownServiceType:
			DLog(@"Should remove unknown service, but won't");
			break;
		default:
			DLog(@"Something went wrong w/ ServiceTypeFromString(...)");
			break;
	}
	
	if (moreComing == NO) {
		[[NSNotificationCenter defaultCenter] postNotificationName:MCServicesUpdatedNotification object:self];
	}
}
#pragma mark NSObject

- (id)init
{
	self = [super init];
	if (self != nil) {
		chatServiceBrowser = [NSNetServiceBrowser new];
		chatServiceBrowser.delegate = self;
		restServiceBrowser = [NSNetServiceBrowser new];
		restServiceBrowser.delegate = self;
		
		chatServices = [NSMutableArray new];
		restServices = [NSMutableArray new];
	}
	return self;
}

- (void)dealloc
{
	[self.chatServiceBrowser release];
	[self.restServiceBrowser release];
	[self.chatServices release];
	[self.restServices release];
	[super dealloc];
}

@end
