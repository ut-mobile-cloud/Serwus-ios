//
//  MCPicture.h
//  Serwus
//
//  Created by Madis Nõmme on 7/28/11.
//  Copyright 2011 University of Tartu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCRestResource.h"

@interface MCPicture : NSObject<MCRestResource> {
    NSData *imageData;
}

- (id)initWithImageName:(NSString *)imageName;

@end
