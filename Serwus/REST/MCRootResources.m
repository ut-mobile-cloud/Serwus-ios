//
//  MCRootResources.m
//  Serwus
//
//  Created by Madis Nõmme on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCRootResources.h"
#import "SBJson.h"

@interface MCRootResources(PrivateMethods)

@property (nonatomic, retain, readwrite) NSMutableArray *resources;

@end

@implementation MCRootResources

@synthesize resources;

- (NSData *)doPostWithInfo:(NSDictionary *)info
{
	[NSException raise:@"Not implemented yet" format:@"", nil];
	return nil;
}

- (NSData *)doGetWithInfo:(NSDictionary *)info
{
		
	return [[resources JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding];
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

- (id)init
{
	self = [super init];
	if (self != nil) {
		resources = [[NSMutableArray arrayWithCapacity:0] retain];
		NSMutableDictionary *users = [NSMutableDictionary dictionary];
		[users setValue:@"List of all users" forKey:@"description"];
		[users setValue:@"Users" forKey:@"resource"];
		[users setValue:@"/users" forKey:@"url"];
		
		NSMutableDictionary *rooms = [NSMutableDictionary dictionary];
		[rooms setValue:@"Rooms available in server" forKey:@"description"];
		[rooms setValue:@"Rooms" forKey:@"resource"];
		[rooms setValue:@"/rooms" forKey:@"url"];
		
		[resources addObject:users];
		[resources addObject:rooms];

	}
	return self;
}

- (void)dealloc
{
	[resources release];
	[super dealloc];
}
@end
