//
//  MCWebServer.h
//  Serwus
//
//  Created by Madis Nõmme on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTTPServer;
@interface MCWebServer : NSObject {
	@private
	HTTPServer *httpServer;
}

+ (MCWebServer *)sharedServer;
- (void)setUpAndLaunch;

@end
