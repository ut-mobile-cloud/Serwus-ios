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
	MCChatClient *chatClient;
}

@property (nonatomic, retain) MCChatClient *chatClient;
@property (nonatomic, retain) IBOutlet UITextField *inputTextField;

@end
