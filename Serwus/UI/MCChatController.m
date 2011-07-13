//
//  MCChatController.m
//  Serwus
//
//  Created by Madis Nõmme on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCChatController.h"
#import "MCChatClient.h"
#import "MCServiceBrowser.h"

@implementation MCChatController
@synthesize activityArea;
@synthesize activityIndicator;
@synthesize inputTextField, chatClient;


- (void)startAnimating
{
	DLog(@"ChatController starting animating");
	self.activityArea.hidden = NO;
	[self.activityIndicator startAnimating];
	[self performSelector:@selector(stopAnimating) withObject:nil afterDelay:5];
}

- (void)stopAnimating
{
	self.activityArea.hidden = YES;
	[self.activityIndicator stopAnimating];
}

#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	textField.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	DLog(@"Send to chat : %@", textField.text);
	// TODO: send text to chat
	[self.chatClient send:textField.text];
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

- (void)awakeFromNib
{
	DLog(@"ChatController was awaken from nib");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	DLog(@"ChatController was started using initWithNibName:bundle:");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	DLog(@"viewDidLoad was called");
	[self startAnimating];
}

- (void)viewDidUnload
{
	DLog(@"viewDidUnload was called");
	[self setInputTextField:nil];
	[self.chatClient release];
	self.chatClient = nil;
	[self setActivityArea:nil];
	[self setActivityIndicator:nil];
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
	[activityArea release];
	[activityIndicator release];
    [super dealloc];
}

@end
