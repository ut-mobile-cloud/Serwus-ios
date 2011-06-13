//
//  MCChatClient.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AsyncSocket;
@class MCMessageBroker;

@interface MCChatClient : NSObject<NSNetServiceBrowserDelegate, NSNetServiceDelegate> {
    BOOL isConnected;
    NSNetServiceBrowser *browser;
    NSNetService *connectedService;
    NSMutableArray *services;
    AsyncSocket *socket;
    MCMessageBroker *messageBroker;	
}

@property (readonly, retain) NSMutableArray *services;
@property (readonly, assign) BOOL isConnected;
@property (readwrite, retain) AsyncSocket *socket;

-(IBAction)search:(id)sender;
-(IBAction)connect:(id)sender;
-(IBAction)send:(NSString *)text;

@end
