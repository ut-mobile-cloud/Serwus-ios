//
//  MCChatServer.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

extern const int MCChatServicePort;
extern NSString * const MCChatServiceBaseName;
extern NSString * const MCChatServiceType;

@class AsyncSocket;

@interface MCChatServer : NSObject<NSNetServiceDelegate, AsyncSocketDelegate> {
    NSNetService *netService;
    AsyncSocket *listeningSocket;
	NSMutableArray *clients;
}

@property (readwrite, retain) AsyncSocket *listeningSocket;
@property (nonatomic, retain) NSMutableArray *clients;

+ (MCChatServer *)sharedServer;
- (void)startService;
- (void)stopService;

@end
