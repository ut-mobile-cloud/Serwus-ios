//
//  MCRestResource.h
//  Serwus
//
//  Created by Madis Nõmme on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MCRestResource <NSObject>

- (NSData *)doPostWithInfo:(NSDictionary *)info;
- (NSData *)doGetWithInfo:(NSDictionary *)info;
- (NSData *)doPutWithInfo:(NSDictionary *)info;
- (NSData *)doDeleteWithInfo:(NSDictionary *)info;

@end
