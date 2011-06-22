//
//  MCRestResourceProvider.h
//  Serwus
//
//  Created by Madis Nõmme on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MCRestResource;
@class MCUsers;
@interface MCRestResourceProvider : NSObject {
	MCUsers *_users;
}

+ (MCRestResourceProvider *)sharedProvider;

- (id<MCRestResource>)resourceForMethod:(NSString *)method atPath:(NSString *)path withData:(NSData *)data;
- (BOOL)hasResourceAtPath:(NSString *)path forMethod:(NSString *)method;

@end
