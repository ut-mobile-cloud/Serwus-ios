//
//  MCUser.m
//  Serwus
//
//  Created by Madis Nõmme on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCUser.h"
#import "JSON.h"

@implementation MCUser

@synthesize fullName=_fullName;
@synthesize username=_username;
@synthesize picture=_picture;
@synthesize status=_status;

- (id)initWithFullName:(NSString *)fullName username:(NSString *)username picture:(NSString *)picture status:(NSString *)status
{
	self = [super init];
	if (self != nil) {
		self.fullName = fullName;
		self.username = username;
		self.picture = picture;
		self.status = status;
	}
	return self;
}

- (NSData *)doPostWithInfo:(NSDictionary *)info
{
	[NSException raise:@"Not implemented yet" format:@"", nil];
	return nil;
}

- (NSData *)doGetWithInfo:(NSDictionary *)info
{
	[NSException raise:@"Not implemented yet" format:@"", nil];
	return nil;
}

- (NSData *)doPutWithInfo:(NSDictionary *)info
{
	[NSException raise:@"Not implemented yet" format:@"", nil];
	return nil;
}

- (NSData *)doDeleteWithInfo:(NSDictionary *)info
{
	[NSException raise:@"Not implemented yet" format:@"", nil];
	return nil;
}

#pragma mark NSObject

- (void)dealloc
{
	[_fullName release];
	[_username release];
	[_picture release];
	[_status release];
	[super dealloc];
}

@end
