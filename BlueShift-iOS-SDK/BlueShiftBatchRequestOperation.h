//
//  BlueShiftBatchRequestOperation.h
//  BlueShift-iOS-SDK
//
//  Copyright (c) Blueshift. All rights reserved.
//

#import "BlueShiftHTTPMethod.h"
#import "BatchEventEntity.h"

@class BatchEventEntity;

@interface BlueShiftBatchRequestOperation : NSObject

// property to hold the request operation parameters list ...
@property (nonatomic, strong) NSArray *paramsArray;

// property to hold the retry count ...
@property (nonatomic, assign) NSInteger retryAttemptsCount;

// property to hold the timestamp for which next request to be send ...
@property (nonatomic, assign) NSInteger nextRetryTimeStamp;


// initialize BlueShiftBatchRequestOperation with request based details...

- (id)initParametersList:(NSArray *)parametersArray andRetryAttemptsCount:(NSInteger)retryAttemptsCount andNextRetryTimeStamp:(NSInteger)nextRetryTimeStamp;


// initialize BlueShiftRequestOperation instance with Core Data entity ...

- (id)initWithBatchRequestOperationEntity:(BatchEventEntity *)batchEventEntity;

@end
