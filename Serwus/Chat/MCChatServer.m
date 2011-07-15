//
//  MCChatServer.m
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatServer.h"
#import "AsyncSocket.h"
#import "MCMessageBroker.h"
#import "MCMessage.h"

const int MCChatServicePort = 54321;
NSString * const MCChatServiceBaseName = @"Mobile cloud chat";
NSString * const MCChatServiceType = @"_mcchat1._tcp."; // Must be less than 14 characters. Leading underscores and periods are important!


@implementation MCChatServer

@synthesize listeningSocket;
@synthesize messageBroker;
@synthesize clientBrokers;

+ (MCChatServer *)sharedServer
{
	static MCChatServer *instance = nil;
	if (instance == nil) {
		instance = [[MCChatServer alloc] init];
	}
	return instance;
}

- (MCMessageBroker *)findBrokerWithSocket:(AsyncSocket *)socket
{
	MCMessageBroker *foundBroker = nil;
	for (MCMessageBroker *broker in self.clientBrokers) {
		if (broker.socket == socket) {
			foundBroker = broker;
		}
	}
	return foundBroker;
}

-(void)startService {
    // Start listening socket
    NSError *error;
    self.listeningSocket = [[[AsyncSocket alloc] initWithDelegate:self] autorelease];
    if ( ![self.listeningSocket acceptOnPort:0 error:&error] ) {
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
    self.messageBroker.delegate = nil;
    self.messageBroker = nil;
    [netService stop]; 
    [netService release];    
    [super dealloc];
}

#pragma mark Socket Callbacks
//! 
-(BOOL)onSocketWillConnect:(AsyncSocket *)sock {
	if ([self findBrokerWithSocket:sock] == nil) {
		return YES;
	}
    return NO;
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock {
	MCMessageBroker *brokerToBeDisconnected = [self findBrokerWithSocket:sock];
	if (brokerToBeDisconnected == nil) {
		return;
	}
	[self.clientBrokers removeObject:brokerToBeDisconnected];
	// TODO: send out notification to possible view controllers that might be interested that a socket has been closed
	
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
	DLog(@"Server accepted new connection on host %@ port: %i", host, port);
	MCMessageBroker *newBroker = [[[MCMessageBroker alloc] initWithAsyncSocket:sock] autorelease];
    newBroker.delegate = self;
    [self.clientBrokers addObject:newBroker];
}

#pragma mark MCMessageBrokerDelegate

-(void)messageBroker:(MCMessageBroker *)server didReceiveMessage:(MCMessage *)message {
	NSString *aMessage = [[[NSString alloc] initWithData:message.dataContent encoding:NSUTF8StringEncoding] autorelease];
	DLog(@"Will send message: %@ to all clients", aMessage);
	
	// Send this message to all connected clients. We're echoing.
	int counter = 0;
	for (MCMessageBroker *broker in self.clientBrokers) {
		DLog(@"Server sending message : %d'th time", counter++);
		[broker sendMessage:message];
	}
}

#pragma mark Net Service Delegate Methods

-(void)netService:(NSNetService *)aNetService didNotPublish:(NSDictionary *)dict {
    NSLog(@"Failed to publish: %@", dict);
}

#pragma mark NSObject

-(void)dealloc {
    [self stopService];
	[clientBrokers release];
    [super dealloc];
}
@end
