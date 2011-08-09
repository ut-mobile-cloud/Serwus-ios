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

NSString * const MCChatClientResolvedAddressNotification = @"MCChatClientResolvedAddressNotification";

@interface MCChatClient () 

@property (readwrite, assign) BOOL isConnected;

@end

@implementation MCChatClient

@synthesize isConnected;
@synthesize remoteService;
@synthesize socket;


@dynamic name;

- (NSString *)name
{
	return @"Just a name";
}

-(void)connect {
    remoteService.delegate = self;
    [remoteService resolveWithTimeout:30];
}

-(IBAction)send:(NSString *)text {
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
	[self.socket writeData:data withTimeout:-1 tag:1];
	DLog(@"ChatClient sent message: %@", text);
}

#pragma mark AsyncSocket Delegate Methods

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
	DLog(@"Socket did CONNECT");
	[sock readDataToData:[AsyncSocket LFData] withTimeout:-1 tag:1];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	DLog(@"Socket did WRITE");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	NSString *dataString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	DLog(@"Socket read some data : %@", dataString);
	
	[sock readDataToData:[AsyncSocket LFData] withTimeout:-1 tag:1];
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
	DDLog(@"ERROR : %@", errorDict);
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
	[super dealloc];
}

@end