//
//  BusStopAnnotation.m
//  GetOnThatBus
//
//  Created by Iván Mervich on 8/5/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "BusStopAnnotation.h"

@interface BusStopAnnotation ()

@end

@implementation BusStopAnnotation

- (instancetype)initWithBusStopInfo:(NSDictionary *)busStopInfo
{
	self = [super init];
	self.busStopInfo = busStopInfo;

	// set pin image based on transfer
	if ([self.busStopInfo[@"inter_modal"] isEqualToString:@"Pace"]) {
		self.pinImage = [UIImage imageNamed:@"pace"];
	} else if ([self.busStopInfo[@"inter_modal"] isEqualToString:@"Metra"]) {
		self.pinImage = [UIImage imageNamed:@"metra"];
	}

	return self;
}


@end
