//
//  SerwusAppDelegate.h
//  Serwus
//
//  Created by Madis Nõmme on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCServiceListController;
@interface SerwusAppDelegate : NSObject <UIApplicationDelegate> {
	MCServiceListController *serviceListController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
