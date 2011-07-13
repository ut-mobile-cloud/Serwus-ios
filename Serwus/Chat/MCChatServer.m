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
@synthesize connectionSocket;
@synthesize messageBroker;

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
	DLog(@"I published my service");
}

-(void)stopService {
    self.listeningSocket = nil;
    self.connectionSocket = nil;
    self.messageBroker.delegate = nil;
    self.messageBroker = nil;
    [netService stop]; 
    [netService release];    
    [super dealloc];
}

-(void)dealloc {
    [self stopService];
    [super dealloc];
}

#pragma mark Socket Callbacks
-(BOOL)onSocketWillConnect:(AsyncSocket *)sock {
    if ( self.connectionSocket == nil ) {
        self.connectionSocket = sock;
        return YES;
    }
    return NO;
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock {
    if ( sock == self.connectionSocket ) {
        self.connectionSocket = nil;
        self.messageBroker = nil;
    }
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    MCMessageBroker *newBroker = [[[MCMessageBroker alloc] initWithAsyncSocket:sock] autorelease];
    newBroker.delegate = self;
    self.messageBroker = newBroker;
}

#pragma mark MTMessageBroker Delegate Methods

-(void)messageBroker:(MCMessageBroker *)server didReceiveMessage:(MCMessage *)message {
	DLog(@"Message Broker got a message : %@", [message dataContent]);
    if ( message.tag == 100 ) {
        lastMessage = [[[NSString alloc] initWithData:message.dataContent encoding:NSUTF8StringEncoding] autorelease];
		DLog(@"LastMessage : %@", lastMessage);
    }
}

#pragma mark Net Service Delegate Methods
-(void)netService:(NSNetService *)aNetService didNotPublish:(NSDictionary *)dict {
    NSLog(@"Failed to publish: %@", dict);
}


@end
