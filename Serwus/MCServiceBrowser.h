//
//  MCServiceBrowser.h
//  Serwus
//
//  Created by Madis Nõmme on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const MCServicesUpdatedNotification;

typedef enum {
	kMCRestServiceType,
	kMCChatServiceType,
	kMCUnknownServiceType
} MCServiceType;

@interface MCServiceBrowser : NSObject<NSNetServiceBrowserDelegate> {
    @private
	NSNetServiceBrowser *chatServiceBrowser;
	NSNetServiceBrowser *restServiceBrowser;
	NSMutableArray *chatServices;
	NSMutableArray *restServices;
	
}

@property (nonatomic, readonly) NSNetServiceBrowser *chatServiceBrowser;
@property (nonatomic, readonly) NSNetServiceBrowser *restServiceBrowser;
@property (nonatomic, readonly) NSMutableArray *chatServices;
@property (nonatomic, readonly) NSMutableArray *restServices;

+ (MCServiceBrowser *)sharedBrowser;
- (void)search;
- (NSNetService *)serviceOfType:(MCServiceType)serviceType atIndex:(int)index;

@end
