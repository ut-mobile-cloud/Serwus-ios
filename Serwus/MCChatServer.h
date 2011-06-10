//
//  MCChatServer.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const int MCChatServicePort;
extern NSString * const MCChatServiceType;

@interface MCChatServer : NSObject<NSNetServiceDelegate> {
    NSNetService *netService;
}

+ (MCChatServer *)sharedServer;
- (void)startService;
- (void)stopService;

@end
