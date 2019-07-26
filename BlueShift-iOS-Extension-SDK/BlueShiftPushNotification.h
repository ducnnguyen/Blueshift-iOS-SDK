//
//  BlueShiftPushNotification.h
////  BlueShift-iOS-SDK
//
//  Copyright (c) Blueshift. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface BlueShiftPushNotification : NSObject

@property (nonatomic, strong) NSArray <UNNotificationAttachment *>* attachments;
@property (nonatomic, strong) NSString *apiKey;

+ (instancetype) sharedInstance;
- (NSArray *)integratePushNotificationWithMediaAttachementsForRequest:(UNNotificationRequest *)request;
- (BOOL)isBlueShiftPushNotification:(UNNotificationRequest *)request;
- (BOOL)hasBlueShiftAttachments;
- (void)trackPushViewedWithRequest:(UNNotificationRequest *)request;

@end
