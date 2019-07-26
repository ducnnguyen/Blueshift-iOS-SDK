//
//  HttpRequestOperationEntity.h
//  BlueShift-iOS-SDK
//
//  Copyright (c) Blueshift. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSNumber+BlueShiftHelpers.h"
#import "BlueShiftHTTPMethod.h"
#import "BlueShiftAppDelegate.h"
#import "NSDate+BlueShiftDateHelpers.h"

@interface HttpRequestOperationEntity : NSManagedObject



// property to hold the type of httpMethod as NSNumber in Core Data ...
@property (nonatomic, strong) NSNumber * httpMethodNumber;



// property to hold the parameter as encrypted NSData ...

@property (nonatomic, strong) NSData * parameters;

// Batch event or real time event
@property (nonatomic) BOOL isBatchEvent;

// property to hold the request url ...

@property (nonatomic, strong) NSString * url;

@property (nonatomic, strong) NSNumber *retryAttemptsCount;

@property (nonatomic, strong) NSNumber *nextRetryTimeStamp;

// Method to insert Entry for a particular request operation in core data ...

- (void)insertEntryWithMethod:(BlueShiftHTTPMethod)httpMethod andParameters:(NSDictionary *)parameters andURL:(NSString *)url andNextRetryTimeStamp:(NSInteger)nextRetryTimeStamp andRetryAttemptsCount:(NSInteger)retryAttemptsCount andIsBatchEvent:(BOOL) isBatchEvent;



// Method to return the httpMethod type as BlueShiftHTTPMethod enum ...

- (BlueShiftHTTPMethod)httpMethod;

// Method to return the first record from Core Data ...
+ (void *)fetchFirstRecordFromCoreDataWithCompletetionHandler:(void (^)(BOOL, HttpRequestOperationEntity *))handler;

// Method to return the batch records from Core Data ...
+ (void *)fetchBatchWiseRecordFromCoreDataWithCompletetionHandler:(void (^)(BOOL, NSArray *))handler;
@end
