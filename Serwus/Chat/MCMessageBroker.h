//
//  MCMessageBroker.h
//  Serwus
//
//  Created by Madis Nõmme on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMessageBrokerDelegate.h"

@class AsyncSocket;
@class MCMessage;
@class MCMessageBroker;

@interface MCMessageBroker : NSObject {
    AsyncSocket *socket;
    BOOL connectionLostUnexpectedly;
    id<MCMessageBrokerDelegate> delegate;
    NSMutableArray *messageQueue;
    BOOL isPaused;
}

@property (nonatomic, assign) id<MCMessageBrokerDelegate> delegate;
@property (nonatomic, readonly) AsyncSocket *socket;

-(id)initWithAsyncSocket:(AsyncSocket *)socket;

-(void)sendMessage:(MCMessage *)newMessage;

-(void)setIsPaused:(BOOL)yn;
-(BOOL)isPaused;

@end