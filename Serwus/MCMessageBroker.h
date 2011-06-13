//
//  MCMessageBroker.h
//  Serwus
//
//  Created by Madis Nõmme on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AsyncSocket;
@class MCMessage;
@class MCMessageBroker;

@interface NSObject (MCMessageBrokerDelegateMethods)

-(void)messageBroker:(MCMessageBroker *)server didSendMessage:(MCMessage *)message;
-(void)messageBroker:(MCMessageBroker *)server didReceiveMessage:(MCMessage *)message;
-(void)messageBrokerDidDisconnectUnexpectedly:(MCMessageBroker *)server;

@end

@interface MCMessageBroker : NSObject {
    AsyncSocket *socket;
    BOOL connectionLostUnexpectedly;
    id delegate;
    NSMutableArray *messageQueue;
    BOOL isPaused;
}

-(id)initWithAsyncSocket:(AsyncSocket *)socket;

-(id)delegate;
-(void)setDelegate:(id)value;

-(AsyncSocket *)socket;

-(void)sendMessage:(MCMessage *)newMessage;

-(void)setIsPaused:(BOOL)yn;
-(BOOL)isPaused;

@end