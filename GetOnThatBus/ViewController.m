//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Iván Mervich on 8/5/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"]];
	[NSURLConnection sendAsynchronousRequest:urlRequest
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
							   if (!connectionError) {
								   NSDictionary *decodedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
								   NSLog(@"loaded json %@", decodedJSON);
							   } else {
								   NSLog(@"Error loading json : %@", [connectionError localizedDescription]);
							   }
						   }];
}

@end
