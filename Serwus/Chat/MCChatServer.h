//
//  MCChatServer.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMessageBrokerDelegate.h"

extern const int MCChatServicePort;
extern NSString * const MCChatServiceBaseName;
extern NSString * const MCChatServiceType;

@class AsyncSocket;
@class MCMessageBroker;

@interface MCChatServer : NSObject<NSNetServiceDelegate, MCMessageBrokerDelegate> {
    NSNetService *netService;
    AsyncSocket *listeningSocket;
    MCMessageBroker *messageBroker;
	NSMutableArray *clientBrokers;
}

@property (readwrite, retain) AsyncSocket *listeningSocket;
@property (readwrite, retain) MCMessageBroker *messageBroker;
@property (nonatomic, retain) NSMutableArray *clientBrokers;

+ (MCChatServer *)sharedServer;
- (void)startService;
- (void)stopService;

@end
