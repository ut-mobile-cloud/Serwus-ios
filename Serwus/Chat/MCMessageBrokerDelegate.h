//
//  MCMessageBrokerDelegate.h
//  Serwus
//
//  Created by Madis Nõmme on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCMessageBroker;
@class MCMessage;

@protocol MCMessageBrokerDelegate <NSObject>

- (void)messageBroker:(MCMessageBroker *)broker didSendMessage:(MCMessage *)message;
- (void)messageBroker:(MCMessageBroker *)broker didReceiveMessage:(MCMessage *)message;
- (void)messageBrokerDidDisconnectUnexpectedly:(MCMessageBroker *)broker;
- (void)messageBrokerWillDisconnect:(MCMessageBroker *)broker;
- (void)messageBrokerDidDisconnect:(MCMessageBroker *)broker;

@end
