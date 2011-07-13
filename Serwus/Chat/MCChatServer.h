//
//  MCChatServer.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const int MCChatServicePort;
extern NSString * const MCChatServiceBaseName;
extern NSString * const MCChatServiceType;

@class AsyncSocket;
@class MCMessageBroker;

@interface MCChatServer : NSObject<NSNetServiceDelegate> {
    NSNetService *netService;
    AsyncSocket *listeningSocket;
    AsyncSocket *connectionSocket;
    MCMessageBroker *messageBroker;
	NSString *lastMessage;
}

@property (readwrite, retain) AsyncSocket *listeningSocket;
@property (readwrite, retain) AsyncSocket *connectionSocket;
@property (readwrite, retain) MCMessageBroker *messageBroker;

+ (MCChatServer *)sharedServer;
- (void)startService;
- (void)stopService;

@end
