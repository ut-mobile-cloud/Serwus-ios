//
//  MCMessage.m
//  Serwus
//
//  Created by Madis Nõmme on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCMessage.h"


@implementation MCMessage

-(id)initWithCoder:(NSCoder *)coder {
	self = [super init];
    if (self != nil) {
        tag = [coder decodeIntForKey:@"tag"];
        dataContent = [[coder decodeObjectForKey:@"dataContent"] retain];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInt:tag forKey:@"tag"];
    [coder encodeObject:dataContent forKey:@"dataContent"];
}

-(void)dealloc {
    [dataContent release];
    [super dealloc];
}

-(int)tag {
    return tag;
}

-(void)setTag:(int)value {
    tag = value;
}

-(NSData *)dataContent {
    return [[dataContent retain] autorelease];
}

-(void)setDataContent:(NSData *)value {
    if (dataContent != value) {
        [dataContent release];
        dataContent = [value copy];
    }
}

@end
