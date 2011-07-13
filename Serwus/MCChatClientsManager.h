//
//  MCChatClientsManager.h
//  Serwus
//
//  Created by Madis Nõmme on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MCChatClientsManager : NSObject {
	@private
	NSMutableArray *chatClients;
}

@property (nonatomic, readonly) NSMutableArray *chatClients;

+ (MCChatClientsManager *)sharedManager;

@end
