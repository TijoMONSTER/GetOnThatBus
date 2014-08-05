//
//  BusStopAnnotation.h
//  GetOnThatBus
//
//  Created by Iván Mervich on 8/5/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface BusStopAnnotation : MKPointAnnotation

@property NSDictionary *busStopInfo;


- (instancetype)initWithBusStopInfo:(NSDictionary *)busStopInfo;

@end
