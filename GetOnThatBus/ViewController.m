//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Iván Mervich on 8/5/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSArray *busStops;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadBusStopsJSON];
}

#pragma mark Helper methods

- (void)loadBusStopsJSON
{
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"]];
	[NSURLConnection sendAsynchronousRequest:urlRequest
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
							   if (!connectionError) {

								   NSDictionary *decodedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
								   self.busStops = decodedJSON[@"row"];
								   [self addBusStopsPins];

							   } else {
								   NSLog(@"Error loading json : %@", [connectionError localizedDescription]);
							   }
						   }];
}

- (void)addBusStopsPins
{
	for (NSDictionary *busStop in self.busStops) {
		MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];

		CLLocationCoordinate2D coordinate;

		if (![busStop[@"_id"] isEqualToString:@"153"]) {
			coordinate = CLLocationCoordinate2DMake([busStop[@"latitude"] doubleValue],
													[busStop[@"longitude"] doubleValue]);
		} else {
			coordinate = CLLocationCoordinate2DMake([busStop[@"latitude"] doubleValue],
													[busStop[@"longitude"] doubleValue] * -1);
		}
		annotation.coordinate = coordinate;
		annotation.title = busStop[@"cta_stop_name"];
		annotation.subtitle = [NSString stringWithFormat:@"Routes: %@", busStop[@"routes"]];
		[self.mapView addAnnotation:annotation];
	}
}

@end
