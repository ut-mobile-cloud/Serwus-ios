//
//  MCRestServiceController.m
//  Serwus
//
//  Created by Madis Nõmme on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCRestServiceController.h"


@implementation MCRestServiceController

@synthesize restResource;


#pragma mark NSObject

- (void)dealloc
{
	[restResource release];
	[super dealloc];
}

@end
