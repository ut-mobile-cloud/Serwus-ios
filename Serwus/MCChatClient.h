//
//  MCChatClient.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MCChatClient : NSObject<NSNetServiceBrowserDelegate, NSNetServiceDelegate> {
    BOOL isConnected;
	NSNetServiceBrowser *browser;
	NSNetService *connectedService;
	NSMutableArray *services;
	
}

@property (readonly, retain) NSMutableArray *services;
@property (readonly, assign) BOOL isConnected;


- (void)search;
- (void)connect;

@end
