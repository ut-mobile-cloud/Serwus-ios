//
//  MCUser.h
//  Serwus
//
//  Created by Madis Nõmme on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCRestResource.h"

@interface MCUser : NSObject<MCRestResource> {
	@private
    NSString *_fullName;
	NSString *_username;
	NSString *_picture;
	NSString *_status;
}

@property (nonatomic, retain) NSString *fullName;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *picture;
@property (nonatomic, retain) NSString *status;

- (id)initWithFullName:(NSString *)fullName username:(NSString *)username picture:(NSString *)picture status:(NSString *)status;

@end
