//
//  MCChatClient.m
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatClient.h"
#import "MCChatServer.h"
#import "MCMessageBroker.h"
#import "AsyncSocket.h"
#import "MCMessage.h"


@interface MCChatClient () // We want these properties to be writable for the class itself

@property (readwrite, assign) BOOL isConnected;
@property (readwrite, retain) MCMessageBroker *messageBroker;

@end

@implementation MCChatClient

@synthesize isConnected;
@synthesize remoteService;
@synthesize socket;
@synthesize messageBroker;



-(void)connect {
    remoteService.delegate = self;
    [remoteService resolveWithTimeout:30];
}

-(IBAction)send:(NSString *)text {
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    MCMessage *newMessage = [[[MCMessage alloc] init] autorelease];
    newMessage.tag = 100;
    newMessage.dataContent = data;
    [self.messageBroker sendMessage:newMessage];
}

#pragma mark AsyncSocket Delegate Methods
-(void)onSocketDidDisconnect:(AsyncSocket *)sock {
    NSLog(@"Socket disconnected");
}

-(BOOL)onSocketWillConnect:(AsyncSocket *)sock {
    if ( messageBroker == nil ) {
        [sock retain];
        return YES;
    }
    return NO;
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {      
    MCMessageBroker *newBroker = [[[MCMessageBroker alloc] initWithAsyncSocket:socket] autorelease];
    [sock release];
    newBroker.delegate = self;
    self.messageBroker = newBroker;
    self.isConnected = YES;
}


#pragma mark NSObject

- (id)init
{
	self = [super init];
	if (self != nil) {
		self.isConnected = NO;
	}
	return self;
}

-(void)dealloc {
	[self.remoteService release];
    [self.socket release];
    self.messageBroker.delegate = nil;
    [self.messageBroker release];
    [super dealloc];
}

@end