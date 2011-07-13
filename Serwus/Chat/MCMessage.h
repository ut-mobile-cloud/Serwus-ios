//
//  MCMessage.h
//  Serwus
//
//  Created by Madis Nõmme on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MCMessage : NSObject<NSCoding> {
    int tag;
	NSData *dataContent;
}

-(int)tag;
-(void)setTag:(int)value;

-(NSData *)dataContent;
-(void)setDataContent:(NSData *)value;

@end
