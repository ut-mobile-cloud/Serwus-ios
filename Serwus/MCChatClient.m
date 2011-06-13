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

@property (readwrite, retain) NSNetServiceBrowser *browser;
@property (readwrite, retain) NSMutableArray *services;
@property (readwrite, assign) BOOL isConnected;
@property (readwrite, retain) NSNetService *connectedService;
@property (readwrite, retain) MCMessageBroker *messageBroker;

@end

@implementation MCChatClient

@synthesize browser;
@synthesize services;
@synthesize isConnected;
@synthesize connectedService;
@synthesize socket;
@synthesize messageBroker;

-(void)awakeFromNib {
    services = [NSMutableArray new];
    self.browser = [[NSNetServiceBrowser new] autorelease];
    self.browser.delegate = self;
    self.isConnected = NO;
}

-(void)dealloc {
    self.connectedService = nil;
    self.browser = nil;
    self.socket = nil;
    self.messageBroker.delegate = nil;
    self.messageBroker = nil;
    [services release];
    [super dealloc];
}

-(IBAction)search:(id)sender {
    [self.browser searchForServicesOfType:MCChatServiceType inDomain:@""];
}

-(IBAction)connect:(id)sender {
    NSNetService *remoteService = self.services.lastObject;
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

#pragma mark Net Service Browser Delegate Methods
-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didFindService:(NSNetService *)aService moreComing:(BOOL)more {
    [self.services addObject:aService];
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didRemoveService:(NSNetService *)aService moreComing:(BOOL)more {
    [self.services removeObject:aService];
    if ( aService == self.connectedService ) {
		self.isConnected = NO;
	}
}

-(void)netServiceDidResolveAddress:(NSNetService *)service {
    NSError *error;
    self.connectedService = service;
    self.socket = [[[AsyncSocket alloc] initWithDelegate:self] autorelease];
    [self.socket connectToAddress:service.addresses.lastObject error:&error];
}

-(void)netService:(NSNetService *)service didNotResolve:(NSDictionary *)errorDict {
    NSLog(@"Could not resolve: %@", errorDict);
}

@end