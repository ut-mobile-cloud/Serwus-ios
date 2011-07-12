//
//  MCChatController.m
//  Serwus
//
//  Created by Madis Nõmme on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatController.h"
#import "MCChatClient.h"

@implementation MCChatController
@synthesize inputTextField, chatClient;


#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	textField.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	DLog(@"Send to chat : %@", textField.text);
	// TODO: send text to chat
	textField.text = @"";
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	// By now (textFieldShouldReturn: is called before this) text field is already empty
}

#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	[self.inputTextField resignFirstResponder];
	return NO;
}
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	[self setInputTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark NSObject

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
	[chatClient release];
	[inputTextField release];
    [super dealloc];
}

@end
