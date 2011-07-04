//
//  MCRestServiceController.h
//  Serwus
//
//  Created by Madis Nõmme on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCRestResource.h"

@interface MCRestServiceController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
	@private
	id<MCRestResource> restResource;
}

@property (nonatomic, retain) id<MCRestResource> restResource;

@end
