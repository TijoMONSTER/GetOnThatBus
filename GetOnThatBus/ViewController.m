//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Iván Mervich on 8/5/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import "BusStopAnnotation.h"
#import "DetailViewController.h"
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

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
	pin.canShowCallout = YES;
	pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

	BusStopAnnotation *busAnnotation = (BusStopAnnotation *)annotation;
	if (busAnnotation.pinImage) {
		pin.image = busAnnotation.pinImage;
	}

	return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	[self performSegueWithIdentifier:@"showDetailsForBusStopSegue" sender:view.annotation];
}

#pragma mark Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"showDetailsForBusStopSegue"]) {
		BusStopAnnotation *annotation = (BusStopAnnotation *)sender;
		DetailViewController *detailVC = (DetailViewController *)segue.destinationViewController;
		detailVC.busStopInfo = annotation.busStopInfo;
	}
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
								   [self zoomMapToChicago];

							   } else {
								   NSLog(@"Error loading json : %@", [connectionError localizedDescription]);
							   }
						   }];
}

- (void)addBusStopsPins
{
	for (NSDictionary *busStop in self.busStops) {
		BusStopAnnotation *annotation = [[BusStopAnnotation alloc] initWithBusStopInfo:busStop];

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

- (void)zoomMapToChicago
{
	CLGeocoder *geocoder = [[CLGeocoder alloc] init];
	[geocoder geocodeAddressString:@"Chicago" completionHandler:^(NSArray *placemarks, NSError *error) {
		CLPlacemark *placemark = placemarks[0];
		CLCircularRegion *region = (CLCircularRegion *)placemark.region;

		[self.mapView setRegion:MKCoordinateRegionMakeWithDistance(placemark.location.coordinate,
																   region.radius,
																   region.radius)
					   animated:YES];
	}];
}

@end