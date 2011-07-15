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

NSString * const MCChatClientResolvedAddressNotification = @"MCChatClientResolvedAddressNotification";

@interface MCChatClient () // We want these properties to be writable for the class itself

@property (readwrite, assign) BOOL isConnected;
@property (readwrite, retain) MCMessageBroker *messageBroker;

@end

@implementation MCChatClient

@synthesize isConnected;
@synthesize remoteService;
@synthesize messageBroker;
@synthesize socket;


@dynamic name;

- (NSString *)name
{
	return @"Just a name";
}

#pragma mark MCMessageBroker

- (void)messageBroker:(MCMessageBroker *)server didSendMessage:(MCMessage *)message
{
	DLog(@"Message broker SENT message");
}

- (void)messageBroker:(MCMessageBroker *)server didReceiveMessage:(MCMessage *)message
{
	DLog(@"Message broker RECEIVED message : %@", [NSString stringWithUTF8String:[[message dataContent]bytes]]);
}

-(void)connect {
    remoteService.delegate = self;
    [remoteService resolveWithTimeout:30];
}

-(IBAction)send:(NSString *)text {
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    MCMessage *newMessage = [[[MCMessage alloc] init] autorelease];
    newMessage.tag = 100;
    newMessage.dataContent = data;
	DLog(@"ChatClient sending message: %@", text);
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
    MCMessageBroker *newBroker = [[[MCMessageBroker alloc] initWithAsyncSocket:sock] autorelease];
    [sock release];
    newBroker.delegate = self;
    self.messageBroker = newBroker;
    self.isConnected = YES;
}

#pragma mark NSNetServiceDelegate

- (void)netServiceDidResolveAddress:(NSNetService *)resolvedService
{
	DLog(@"ChatClient resolved address. Will create a socket");
	self.socket = [[[AsyncSocket alloc] initWithDelegate:self] autorelease];
	[socket connectToAddress:resolvedService.addresses.lastObject error:nil];
}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict
{
	DDLog(@"ERROR");
}

#pragma mark NSObject

- (id)initWithNetService:(NSNetService *)netService
{
	self = [super init];
	if (self != nil) {
		self.remoteService = netService;
		netService.delegate = self;
		[netService resolveWithTimeout:10];
		self.isConnected = NO;
	}
	return self;
}

-(void)dealloc {
	[self.socket disconnect];
	[self.socket release];
	[self.remoteService release];
	[self.messageBroker release];
	self.messageBroker.delegate = nil;
	[super dealloc];
}

@end