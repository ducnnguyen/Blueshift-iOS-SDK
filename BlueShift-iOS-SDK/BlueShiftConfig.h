//
//  BlueShiftConfig.h
//  BlueShiftiOSSDK
//
//  Copyright (c) Blueshift. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
#import "BlueShiftDeepLink.h"
#import "BlueShiftUserInfo.h"
#import "BlueShiftPushDelegate.h"

@interface BlueShiftConfig : NSObject

@property (nonatomic, strong) NSString * _Nonnull apiKey;
@property (nonatomic, strong) NSDictionary * _Nonnull applicationLaunchOptions;

@property (nonatomic, strong) NSURL * _Nullable productPageURL;
@property (nonatomic, strong) NSURL * _Nullable cartPageURL;
@property (nonatomic, strong) NSURL * _Nullable offerPageURL;

@property (nonatomic, assign) BOOL enablePushNotification;
@property (nonatomic, assign) BOOL enableLocationAccess;
@property (nonatomic, assign) BOOL enableAnalytics;
@property (nonatomic, assign) BOOL enableAppOpenTrackEvent;

@property (nonatomic, strong) NSSet * _Nullable customCategories;

@property (nonatomic, strong) NSString * _Nullable appGroupID;

@property (nonatomic, strong) NSObject<UNUserNotificationCenterDelegate> * _Nonnull userNotificationDelegate;
@property (nonatomic, weak) id<BlueShiftPushDelegate> _Nullable blueShiftPushDelegate;

@property (nonatomic, strong) NSString * _Nonnull blueShiftNotificationName;
@property (nonatomic, strong) NSString * _Nonnull isEnabledPushNotificationKey;

- (BOOL)validateConfigDetails;

+ (BlueShiftConfig * _Nonnull )config;
@end
