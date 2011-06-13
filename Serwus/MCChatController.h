//
//  MCChatController.h
//  Serwus
//
//  Created by Madis Nõmme on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MCChatController : UIViewController<UITextFieldDelegate, UITextViewDelegate> {
    
	UITextField *inputTextField;
}

@property (nonatomic, retain) IBOutlet UITextField *inputTextField;
@end
