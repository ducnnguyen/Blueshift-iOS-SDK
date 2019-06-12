//
//  BlueShiftDeviceData.h
//  BlueShift-iOS-SDK
//
//  Copyright (c) Blueshift. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreLocation/CoreLocation.h>
#import <AdSupport/AdSupport.h>
#import "BlueShiftMacros.h"

@class BlueShift;

@interface BlueShiftDeviceData : NSObject

@property (nonatomic, readonly) NSString *deviceUUID;
@property (nonatomic, readonly) NSString *deviceToken;
@property (nonatomic, readonly) NSString *deviceIDFA;
@property (nonatomic, readonly) NSString *deviceIDFV;
@property  CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, readonly) NSString *deviceManufacturer;
@property (nonatomic, readonly) NSString *deviceType;
@property (nonatomic, readonly) NSString *operatingSystem;
@property (nonatomic, readonly) NSString *networkCarrierName;

+ (instancetype) currentDeviceData;

- (NSDictionary *)toDictionary;

@end
