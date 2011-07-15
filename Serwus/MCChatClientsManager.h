//
//  MCChatClientsManager.h
//  Serwus
//
//  Created by Madis Nõmme on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCChatClient;
@interface MCChatClientsManager : NSObject {
	@private
	NSMutableArray *chatClients;
}

@property (nonatomic, readonly) NSMutableArray *chatClients;

+ (MCChatClientsManager *)sharedManager;
- (void)addClient: (MCChatClient *)client;
- (void)removeClient: (MCChatClient *)client;

@end
