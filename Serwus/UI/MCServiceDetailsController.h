//
//  MCServiceDetailsController.h
//  Serwus
//
//  Created by Madis Nõmme on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCServiceDetailsController : UIViewController <NSNetServiceDelegate>{
	NSNetService *netService;
	UIImageView *logoImageView;
}

@property (nonatomic, retain) IBOutlet UIImageView *logoImageView;
@property (nonatomic, retain) NSNetService *netService;

@end
