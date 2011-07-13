//
//  MCRootResources.h
//  Serwus
//
//  Created by Madis Nõmme on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCRestResource.h"

@interface MCRootResources : NSObject<MCRestResource> {
	@private
	NSMutableArray *resources;
}
@property (nonatomic, readonly) NSArray *resources;
@end
