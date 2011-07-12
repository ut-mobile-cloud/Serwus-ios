//
//  MCChatRooms.h
//  Serwus
//
//  Created by Madis Nõmme on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCRestResource.h"

@interface MCChatRooms : NSObject<MCRestResource> {
    NSMutableArray *_chatRooms;
}

@property (nonatomic, readonly) NSMutableArray *rooms;


@end
