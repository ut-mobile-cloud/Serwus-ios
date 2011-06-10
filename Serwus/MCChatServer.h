//
//  MCChatServer.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

const int MCChatServicePort = 54321;
NSString * const MCChatServiceType = @"_mcchat._tcp."; // Must be less than 14 characters. Leading underscores and periods are important!

@interface MCChatServer : NSObject<NSNetServiceDelegate> {
    NSNetService *netService;
}

+ (MCChatServer *)sharedServer;
- (void)startService;
- (void)stopService;

@end
