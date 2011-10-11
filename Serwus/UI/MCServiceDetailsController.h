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
	UILabel *locationLabel;
	UIImageView *logoImageView;
}

@property (nonatomic, retain) IBOutlet UIImageView *logoImageView;
@property (nonatomic, assign) NSNetService *netService;
@property (nonatomic, retain) IBOutlet UILabel *locationLabel;

@end
