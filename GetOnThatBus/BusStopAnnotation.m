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
	return self;
}


@end
