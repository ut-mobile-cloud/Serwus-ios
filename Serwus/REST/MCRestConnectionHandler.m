//
//  MCRestConnectionHandler.m
//  Serwus
//
//  Created by Madis Nõmme on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCRestConnectionHandler.h"
#import "HTTPMessage.h"
#import "HTTPDataResponse.h"
#import "MCRestResourceProvider.h"
#import "MCRestResource.h"
#import "MCRootResources.h"
#import "MCChatRooms.h"
#import "MCChatRoom.h"
#import "MCUsers.h"
#import "MCUser.h"
#import "MCPicture.h"

@implementation MCRestConnectionHandler

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
	// TODO: return YES for paths that have some resource to offer (in a RESTful way)
	return YES;
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path
{
	// Inform HTTP server that we expect a body to accompany a POST request
	if([method isEqualToString:@"POST"])
		return YES;
	
	return [super expectsRequestBodyFromMethod:method atPath:path];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
	NSData *responseData = nil;
	id<MCRestResource> restResource = nil;
	DLog(@"path : %@", path);
	/**
	 Path components will be separated and referred as follows:
	 URL: www.example.com/users/Madis
	 path variable will be /users/Madis
	 After componentsSeparatedByString: pathComponents array contains:
		0 level is ""
		1 level is users
		2 level is Madis
	 */
	NSArray *pathComponents = [path componentsSeparatedByString:@"/"];
	if (pathComponents != nil && [path isEqualToString:@"/"]) {
		// It's a root resource. Give the list
		restResource = [[MCRestResourceProvider sharedProvider] getRootResources];
	} else if (pathComponents != nil && pathComponents.count == 2) {
		// Request is for top level resource /users /rooms
		NSString *topLevelResourceName = [pathComponents objectAtIndex:1];
		if ([topLevelResourceName isEqualToString:@"users"]) { // Handle users
			restResource = [[MCRestResourceProvider sharedProvider] getAllUsers];
		} else if ([topLevelResourceName isEqualToString:@"rooms"]) { // Handle rooms
			restResource = [[MCRestResourceProvider sharedProvider] getAllRooms];
		} else if ([topLevelResourceName isEqualToString:@"logo"]) { // To demo sending a picture
			DLog(@"Sending logo");
			restResource = [[MCPicture alloc] initWithImageName:@"logo2"];
		}
	} else if (pathComponents.count == 3) {
		// Request is for second level objects
		NSString *selectedResourceName = [pathComponents objectAtIndex:2];
		NSString *parentResourceName = [pathComponents objectAtIndex:1];
		if ([parentResourceName isEqualToString:@"users"]) {
			restResource = [[MCRestResourceProvider sharedProvider] getUserForName:selectedResourceName];
		} else if ([parentResourceName isEqualToString:@"rooms"]) {
			restResource = [[MCRestResourceProvider sharedProvider] getRoomForName:selectedResourceName];
		}
	} else {
		DLog(@"Did not know how to handle");
		// TODO: handle error - resource not found
	}
	responseData = [restResource doGetWithInfo:nil];
	HTTPDataResponse *response = [[[HTTPDataResponse alloc] initWithData:responseData] autorelease];
	return response;
}
@end
