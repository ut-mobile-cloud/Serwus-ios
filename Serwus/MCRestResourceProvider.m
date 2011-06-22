//
//  MCRestResourceProvider.m
//  Serwus
//
//  Created by Madis Nõmme on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCRestResourceProvider.h"
#import "MCUsers.h"
#import "MCUser.h"

@implementation MCRestResourceProvider

+ (MCRestResourceProvider *)sharedProvider
{
	static MCRestResourceProvider *instance = nil;
	if (instance == nil) {
		instance = [[MCRestResourceProvider alloc] init];
	}
	return instance;
}

- (id<MCRestResource>)resourceForMethod:(NSString *)method atPath:(NSString *)path withData:(NSData *)data
{
	MCUsers *users = [[MCUsers alloc] init];
	MCUser *userA = [[MCUser alloc] initWithFullName:@"Madis Nõmme" username:@"madis" picture:@"none" status:@"online"];
	MCUser *userB = [[MCUser alloc] initWithFullName:@"Toomas Peet" username:@"toomas" picture:@"none" status:@"offline"];
	[users addUser:userA];
	[users addUser:userB];
	return users;
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
	
	}
	return self;
}

- (void)dealloc
{
	[_users release];
	[super dealloc];
}
@end
