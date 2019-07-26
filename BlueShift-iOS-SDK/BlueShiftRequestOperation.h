//
//  BlueShiftRequestOperation.h
//  BlueShift-iOS-SDK
//
//  Copyright (c) Blueshift. All rights reserved.
//

#import "BlueShiftHTTPMethod.h"
#import "HttpRequestOperationEntity.h"

@class HttpRequestOperationEntity;

@interface BlueShiftRequestOperation : NSObject



// property to hold the request operation URL ...

@property (nonatomic, strong) NSString *url;


// property to hold the request operation http Method ...

@property (nonatomic, assign) BlueShiftHTTPMethod httpMethod;



// property to hold the request operation parameters ...

@property (nonatomic, strong) NSDictionary *parameters;

// property to hold the retry count ...
@property (nonatomic, assign) NSInteger retryAttemptsCount;

// property to hold the timestamp for which next request to be send ...
@property (nonatomic, assign) NSInteger nextRetryTimeStamp;

// property to check batch event or real time event
@property (nonatomic, assign) BOOL isBatchEvent;

// initialize BlueShiftRequestOperation instance with url and other request based details...

- (id)initWithRequestURL:(NSString *)url andHttpMethod:(BlueShiftHTTPMethod)httpMethod andParameters:(NSDictionary *)parameters andRetryAttemptsCount:(NSInteger)retryAttemptsCount andNextRetryTimeStamp:(NSInteger)nextRetryTimeStamp andIsBatchEvent:(BOOL)isBatchEvent;



// initialize BlueShiftRequestOperation instance with Core Data entity ...

- (id)initWithHttpRequestOperationEntity:(HttpRequestOperationEntity *)httpRequestionOperationEntity;


@end
