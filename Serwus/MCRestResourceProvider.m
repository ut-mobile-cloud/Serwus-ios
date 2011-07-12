//
//  MCRestResourceProvider.m
//  Serwus
//
//  Created by Madis Nõmme on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCRestResourceProvider.h"
#import "MCRootResources.h"
#import "MCUsers.h"
#import "MCUser.h"
#import "MCChatRooms.h"

@implementation MCRestResourceProvider
@synthesize users = _users;

@dynamic rooms;
- (MCChatRooms *)rooms
{
	return nil;
}

+ (MCRestResourceProvider *)sharedProvider
{
	static MCRestResourceProvider *instance = nil;
	if (instance == nil) {
		instance = [[MCRestResourceProvider alloc] init];
	}
	return instance;
}

- (MCRootResources *)getRootResources
{
	return [[[MCRootResources alloc] init] autorelease];
}

- (MCUsers *)getAllUsers
{
	
	return self.users;
}

- (MCUser *)getUserForName:(NSString *)username
{
	for (MCUser *user in self.users.users) {
		if ([user.username isEqualToString:username]) {
			return user;
		}
	}
	return nil;
}

- (MCChatRooms *)getAllRooms
{
	return nil;
}

- (MCChatRoom *)getRoomForName:(NSString *)roomName
{
	return nil;
}
- (BOOL)hasResourceAtPath:(NSString *)path forMethod:(NSString *)method
{
	if ([path isEqualToString:@"/users"]) {
		return YES;
	}
	return NO;
}

- (id)init
{
	self = [super init];
	if (self != nil) {
		_users = [[MCUsers alloc] init];
		MCUser *userA = [[[MCUser alloc] initWithFullName:@"Madis Nõmme" username:@"madis" picture:@"none" status:@"online"] autorelease];
		MCUser *userB = [[[MCUser alloc] initWithFullName:@"Toomas Peet" username:@"toomas" picture:@"none" status:@"offline"] autorelease];
		[_users addUser:userA];
		[_users addUser:userB];
	}
	return self;
}

- (void)dealloc
{
	[_users release];
	[super dealloc];
}
@end
