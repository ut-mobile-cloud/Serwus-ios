//
//  MCRestResourceProvider.h
//  Serwus
//
//  Created by Madis Nõmme on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MCRestResource;

@class MCUsers;
@class MCChatRooms;
@class MCUser;
@class MCChatRoom;

@interface MCRestResourceProvider : NSObject {
	MCUsers *_users;
	
}

@property (nonatomic, readonly) MCUsers *users;
@property (nonatomic, readonly) MCChatRooms *rooms; // A dynamic property, information will be gathered from 'live' data. Reflects chat rooms (including chats that are running on other devices that user has joined to.

+ (MCRestResourceProvider *)sharedProvider;

// DAO Methods
- (MCUsers *)getAllUsers;
- (MCUser *)getUserForName:(NSString *)username;
- (MCChatRooms *)getAllRooms;
- (MCChatRoom *)getRoomForName:(NSString *)roomName;

// Methods for requesting resources
- (BOOL)hasResourceAtPath:(NSString *)path forMethod:(NSString *)method;

@end
