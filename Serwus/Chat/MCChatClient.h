//
//  MCChatClient.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
extern NSString * const MCChatClientResolvedAddressNotification;

@class AsyncSocket;

@interface MCChatClient : NSObject<NSNetServiceDelegate, AsyncSocketDelegate> {
	@private
	BOOL isConnected;
	NSNetService *remoteService;
	AsyncSocket *socket;
	
}

@property (readonly, assign) BOOL isConnected;
@property (readwrite, retain) NSNetService *remoteService;
@property (nonatomic, retain) AsyncSocket *socket;
@property (nonatomic, readonly) NSString *name;

- (id)initWithNetService:(NSNetService *)netService;
- (void)connect;

- (void)send:(NSString *)text;

@end
