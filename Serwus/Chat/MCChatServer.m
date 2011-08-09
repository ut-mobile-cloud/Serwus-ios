//
//  MCChatServer.m
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatServer.h"
#import "MCMessage.h"

const int MCChatServicePort = 54321;
NSString * const MCChatServiceBaseName = @"Mobile cloud chat";
NSString * const MCChatServiceType = @"_mcchat1._tcp."; // Must be less than 14 characters. Leading underscores and periods are important!


@implementation MCChatServer

@synthesize listeningSocket;
@synthesize clients;

+ (MCChatServer *)sharedServer
{
	static MCChatServer *instance = nil;
	if (instance == nil) {
		instance = [[MCChatServer alloc] init];
	}
	return instance;
}

-(void)startService {
    // Start listening socket
    NSError *error = nil;
    if ( ![self.listeningSocket acceptOnPort:54321 error:&error] ) {
        NSLog(@"Failed to create listening socket");
        return;
    }
    // Advertise service with bonjour
    NSString *uniqueServiceName = [NSString stringWithFormat:@"%@::%@", MCChatServiceBaseName, [[NSProcessInfo processInfo] hostName]];
    netService = [[NSNetService alloc] initWithDomain:@"local." type:MCChatServiceType name:uniqueServiceName port:self.listeningSocket.localPort];
    netService.delegate = self;
    [netService publish];
	DLog(@"ChatServer published bonjour service");
}

-(void)stopService {
    self.listeningSocket = nil;
    [netService stop]; 
    [netService release];    
    [super dealloc];
}

#pragma mark AsyncSocket
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
	DLog(@"didAcceptNewSocket : SERVER got new client");
	[self.clients addObject:newSocket];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	DLog(@"Server wrote something to socket");
	for (AsyncSocket *client in self.clients) {
		[client readDataToData:[AsyncSocket LFData] withTimeout:-1 tag:1];
	}
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	NSString *dataString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	
	DLog(@"SERVER something was sent to server : %@", dataString);
	for (AsyncSocket *client in self.clients) {
		if (client != sock) {
			[client writeData:data withTimeout:-1 tag:1];
		}
	}
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
	DLog(@"SERVER connected to host");
	[sock writeData:[@"Oioi" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:2];
}
#pragma mark Net Service Delegate Methods

-(void)netService:(NSNetService *)aNetService didNotPublish:(NSDictionary *)dict {
    NSLog(@"Failed to publish: %@", dict);
}

#pragma mark NSObject

- (id)init
{
	self = [super init];
	if (self != nil) {
		listeningSocket = [[AsyncSocket alloc] initWithDelegate:self];
		clients = [[NSMutableArray alloc] initWithCapacity:0];
	}
	
	return self;
}

-(void)dealloc {
    [self stopService];
	[clients release];
    [super dealloc];
}
@end
