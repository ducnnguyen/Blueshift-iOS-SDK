//
//  BlueShiftSubscription.h
//  BlueShift-iOS-SDK
//
//  Copyright (c) Blueshift. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlueShiftSubscriptionState.h"

@interface BlueShiftSubscription : NSObject


@property (nonatomic, assign) BlueShiftSubscriptionState subscriptionState;
@property (nonatomic, strong) NSString *cycleType;
@property (nonatomic, assign) NSInteger cycleLength;
@property (nonatomic, strong) NSString *subscriptionType;
@property (nonatomic, assign) float price;
@property (nonatomic, assign) NSTimeInterval startDate;


- (id)initWithSubscriptionState:(BlueShiftSubscriptionState)subscriptionState andCycleType:(NSString *)cycleType andCycleLength:(NSInteger)cycleLength andSubscriptionType:(NSString *)subscriptionType andPrice:(float)price andStartDate:(NSTimeInterval)startDate;

- (NSDictionary *)toDictionary;
+ (BlueShiftSubscription *)currentSubscription;
- (void)save;
+ (void)removeCurrentSubscription;



@end
