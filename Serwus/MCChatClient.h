//
//  MCChatClient.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AsyncSocket;
@class MCMessageBroker;

@interface MCChatClient : NSObject<NSNetServiceDelegate> {
    BOOL isConnected;
    NSNetService *remoteService;
    AsyncSocket *socket;
    MCMessageBroker *messageBroker;	
}

@property (readonly, assign) BOOL isConnected;
@property (readwrite, retain) AsyncSocket *socket;
@property (readwrite, retain) NSNetService *remoteService;

-(void)connect;
-(void)send:(NSString *)text;

@end
