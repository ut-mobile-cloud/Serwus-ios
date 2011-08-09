//
//  MCPicture.m
//  Serwus
//
//  Created by Madis Nõmme on 7/28/11.
//  Copyright 2011 University of Tartu. All rights reserved.
//

#import "MCPicture.h"


@implementation MCPicture

- (NSData *)doPostWithInfo:(NSDictionary *)info
{
	[NSException raise:@"Not implemented yet" format:@"", nil];
	return nil;
}

- (NSData *)doGetWithInfo:(NSDictionary *)info
{
	return imageData;
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

- (id)initWithImageName:(NSString *)imageName
{
	self = [super init];
	if (self != nil) {
		DLog(@"Image name: %@", imageName);
		NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
		DLog(@"File path: %@", filePath);
		imageData = [[NSData dataWithContentsOfFile:filePath] retain];
		DLog(@"Got data of size: %d", [imageData length]);
	}
	return self;
}

- (void)dealloc
{
	[imageData release];
	[super dealloc];
}

@end
