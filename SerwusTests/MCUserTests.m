//
//  MCUserTests.m
//  Serwus
//
//  Created by Madis Nõmme on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "SBJson.h"

@interface MCUserTests : SenTestCase {
@private
}
@end


@implementation MCUserTests

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void)testAppDelegate {
    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
    
}

#else                           // all code under test must be linked into the Unit Test bundle

- (void)testSomething {
	STAssertTrue(YES, @"Midagi siin", nil);
}

#endif

@end
