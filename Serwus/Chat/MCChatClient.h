//
//  MCChatClient.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const MCChatClientResolvedAddressNotification;

@class MCMessageBroker;

@interface MCChatClient : NSObject<NSNetServiceDelegate> {
    BOOL isConnected;
    NSNetService *remoteService;
    MCMessageBroker *messageBroker;	
}

@property (readonly, assign) BOOL isConnected;
@property (readwrite, retain) NSNetService *remoteService;

- (id)initWithNetService:(NSNetService *)netService;
-(void)connect;
-(void)send:(NSString *)text;

@end
