//
//  MCWebServer.m
//  Serwus
//
//  Created by Madis Nõmme on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCWebServer.h"
#import "HTTPServer.h"
#import "MCRestConnectionHandler.h"

const int MCHttpServerPort = 7766;

@interface MCWebServer ()

@end

@implementation MCWebServer

+ (MCWebServer *)sharedServer
{
	static MCWebServer *instance = nil;
	if (instance == nil) {
		instance = [[MCWebServer alloc] init];
	}
	return instance;
}

- (void)setUpAndLaunch
{
	[httpServer setPort:MCHttpServerPort];
	[httpServer setType:@"_http._tcp."];
	[httpServer setConnectionClass:MCRestConnectionHandler.class];
	NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
	[httpServer setDocumentRoot:webPath];
	NSError *error;
	[httpServer start:&error];
	if (error) {
		DLog(@"Error when starting HTTP server");
	}
}

- (id)init
{
	self = [super init];
	if (self != nil) {
		httpServer = [[HTTPServer alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[httpServer stop];
	[httpServer release];
	[super dealloc];
}
@end
