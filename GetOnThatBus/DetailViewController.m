//
//  DetailViewController.m
//  GetOnThatBus
//
//  Created by Iván Mervich on 8/5/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *routesLabel;
@property (weak, nonatomic) IBOutlet UILabel *intermodalTransfersLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.title = self.busStopInfo[@"cta_stop_name"];
	self.addressLabel.text = self.busStopInfo[@"_address"];
	self.routesLabel.text = self.busStopInfo[@"routes"];
	if (self.busStopInfo[@"inter_modal"]) {
		self.intermodalTransfersLabel.text = self.busStopInfo[@"inter_modal"];
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}

@end
