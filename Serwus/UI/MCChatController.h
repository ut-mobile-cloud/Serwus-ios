//
//  MCChatController.h
//  Serwus
//
//  Created by Madis Nõmme on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCChatClient;

@interface MCChatController : UIViewController<UITextFieldDelegate, UITextViewDelegate> {
    
	UITextField *inputTextField;
	UIView *activityArea;
	UIActivityIndicatorView *activityIndicator;
	MCChatClient *chatClient;
}

@property (nonatomic, retain) MCChatClient *chatClient;
@property (nonatomic, retain) IBOutlet UITextField *inputTextField;
@property (nonatomic, retain) IBOutlet UIView *activityArea;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
