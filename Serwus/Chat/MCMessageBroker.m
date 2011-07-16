//
//  MCMessageBroker.m
//  Serwus
//
//  Created by Madis Nõmme on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCMessageBroker.h"
#import "AsyncSocket.h"

const int MessageHeaderSize = 8; // Message header would be 8 bytes (size of 64 bit unsigned int)
const int SocketTimeout = -1;

@implementation MCMessageBroker

@synthesize delegate, socket;

-(void)setIsPaused:(BOOL)yn {
    if ( yn != isPaused ) {
        isPaused = yn;
        if ( !isPaused ) {
            [socket readDataToLength:MessageHeaderSize withTimeout:SocketTimeout tag:(long)0];
        }
    }
}

-(BOOL)isPaused {
    return isPaused;
}

#pragma mark Sending/Receiving Messages

-(void)sendMessage:(MCMessage *)message {
	DLog(@"MessageBroker sending message");
    [messageQueue addObject:message];
    NSData *messageData = [NSKeyedArchiver archivedDataWithRootObject:message];
    UInt64 header[1];
    header[0] = [messageData length]; 
    header[0] = CFSwapInt64HostToLittle(header[0]);  // Send header in little endian byte order
    [socket writeData:[NSData dataWithBytes:header length:MessageHeaderSize] withTimeout:SocketTimeout tag:(long)0];
    [socket writeData:messageData withTimeout:SocketTimeout tag:(long)1];
}


#pragma mark Socket Callbacks

-(void)onSocketDidDisconnect:(AsyncSocket *)sock {
    if ( connectionLostUnexpectedly ) {
        if ( delegate && [delegate respondsToSelector:@selector(messageBroker:didDisconnectUnexpectedly:)] ) {
            [delegate messageBrokerDidDisconnectUnexpectedly:self];
        }
    }
}

-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err {
    connectionLostUnexpectedly = YES;
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
	DLog(@"Socket did read some data");
    if ( tag == 0 ) {
        // Header
        UInt64 header = *((UInt64*)[data bytes]);
        header = CFSwapInt64LittleToHost(header);  // Convert from little endian to native
        [socket readDataToLength:(CFIndex)header withTimeout:SocketTimeout tag:(long)1];
    }
    else if ( tag == 1 ) { 
        // Message body. Pass to delegate
        if ( delegate && [delegate respondsToSelector:@selector(messageBroker:didReceiveMessage:)] ) {
            MCMessage *message = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [delegate messageBroker:self didReceiveMessage:message];
        }
        
        // Begin listening for next message
        if ( !isPaused ) [socket readDataToLength:MessageHeaderSize withTimeout:SocketTimeout tag:(long)0];
    }
    else {
        NSLog(@"Unknown tag in read of socket data %ld", tag);
    }
}

-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
    if ( tag == 1 ) {
        // If the message is now complete, remove from queue, and tell the delegate
        MCMessage *message = [[[messageQueue objectAtIndex:0] retain] autorelease];
        [messageQueue removeObjectAtIndex:0];
        if ( delegate && [delegate respondsToSelector:@selector(messageBroker:didSendMessage:)] ) {
            [delegate messageBroker:self didSendMessage:message];
        }
    }
}

#pragma mark NSObject

-(id)initWithAsyncSocket:(AsyncSocket *)newSocket {
	self = [super init];
    if (self != nil) {
        if ( [newSocket canSafelySetDelegate] ) {
            socket = [newSocket retain];
            [newSocket setDelegate:self];
            messageQueue = [NSMutableArray new];
            [socket readDataToLength:MessageHeaderSize withTimeout:SocketTimeout tag:0];
        }
        else {
            NSLog(@"Could not change delegate of socket");
            [self release];
            self = nil;
        }
    }
    return self;
}

-(void)dealloc {
    [socket setDelegate:nil];
    if ( [socket isConnected] ) [socket disconnect];
    [socket release];
    [messageQueue release];
    [super dealloc];
}


@end
