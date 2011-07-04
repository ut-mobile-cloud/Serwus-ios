//
//  MCChatClientsManager.h
//  Serwus
//
//  Created by Madis Nõmme on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MCChatClientsManager : NSObject<NSNetServiceBrowserDelegate> {
	@private
	NSNetServiceBrowser *browser;
	NSMutableArray *chatClients;
}

@property (nonatomic, readonly) NSMutableArray *chatClients;
@property (nonatomic, readonly) NSNetServiceBrowser *browser;

+ (MCChatClientsManager *)sharedManager;
- (void)search;

@end
