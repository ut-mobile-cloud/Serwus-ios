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
	NSData *response = nil;
	if ([method isEqualToString:@"GET"]) {
		response = [@"Nothing here" dataUsingEncoding:NSUTF8StringEncoding];
	}
	return [[[HTTPDataResponse alloc] initWithData:response] autorelease];
}
@end
