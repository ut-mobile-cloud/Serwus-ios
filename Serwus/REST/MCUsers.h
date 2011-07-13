//
//  MCUsers.h
//  Serwus
//
//  Created by Madis Nõmme on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCRestResource.h"

@class MCUser;
@interface MCUsers : NSObject<MCRestResource>{
    NSMutableArray *_users;
}

@property (nonatomic, retain) NSMutableArray *users;

- (id)initWithUsers:(NSArray *)users;
- (id)init;
- (void)addUsers:(NSArray *)users;
- (void)addUser:(MCUser *)user;
- (NSString *)jsonRepresentation;

@end
