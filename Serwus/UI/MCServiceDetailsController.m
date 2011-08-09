//
//  MCServiceDetailsController.m
//  Serwus
//
//  Created by Madis Nõmme on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCServiceDetailsController.h"
#import "ASIHTTPRequest.h"

#import <sys/types.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@implementation MCServiceDetailsController

@synthesize logoImageView;
@synthesize netService;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
	[netService release];
	[logoImageView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	DLog(@"Service details controller starting to resolve");
	[self.netService setDelegate:self];
	[self.netService resolveWithTimeout:10];
}

- (void)viewDidUnload
{
	[self setLogoImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.logoImageView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)netServiceDidStop:(NSNetService *)sender
{
	DLog(@"ServiceDetailsController DID STOP");
}

- (void)netServiceDidResolveAddress:(NSNetService *)sender
{
//	DLog(@"RESOLVED service w/ name : %@", [sender name]);
//	NSData *addressData = [[sender addresses] lastObject];
//	struct sockaddr_in *addressStruct = (struct sockaddr_in *)[addressData bytes];
//	int port = ntohs(addressStruct->sin_port);
//	NSString *addressIP = [NSString stringWithCString:(char *)inet_ntoa(addressStruct->sin_addr) encoding:NSUTF8StringEncoding];
//	DLog(@"ServiceDetailsController RESOLVED TO : %@ : %d", addressIP, port);
//	
//	NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%d/logo", addressIP, port]];
	
	NSArray *addresses = [sender addresses];
	if (0 == [addresses count]) {
		DLog(@"Did not find any addresses from service");
		return;
	}
	
	NSData *address = [addresses objectAtIndex:0];
	struct sockaddr_in *address_sin = (struct sockaddr_in *)[address bytes];
	struct sockaddr_in6 *address_sin6 = (struct sockaddr_in6 *)[address bytes];
	const char *formatted;
	char buffer[1024];
	in_port_t port = 0;
	NSString *urlString = nil;
	if (AF_INET == address_sin->sin_family) {
		formatted = inet_ntop(AF_INET, &(address_sin->sin_addr), buffer, sizeof(buffer));
		port = ntohs(address_sin->sin_port);
		urlString = [NSString stringWithFormat:@"http://%s:%d", formatted, port];
	} else if (AF_INET6 == address_sin6->sin6_family) {
		formatted = inet_ntop(AF_INET6, &(address_sin6->sin6_addr), buffer, sizeof(buffer));
		port = ntohs(address_sin6->sin6_port);
		urlString = [NSString stringWithFormat:@"http://[%s]:%d", (0 ? formatted : "::1"), port];
	}
	DLog(@"urlString : %@", urlString);
	NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", urlString, @"logo", nil]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestURL];
	[request startSynchronous];
	NSData *responseData = [request responseData];
	self.logoImageView.image = [UIImage imageWithData:responseData];
}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict
{
	DLog(@"ServiceDetailsController DID NOT RESOLVE");
}
@end
