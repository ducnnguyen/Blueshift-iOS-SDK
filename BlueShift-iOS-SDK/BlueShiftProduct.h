//
//  BlueShiftProduct.h
//  BlueShift-iOS-SDK
//
//  Copyright (c) Blueshift. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlueShiftProduct : NSObject

@property (nonatomic, strong) NSString *sku;
@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, assign) float price;

- (NSDictionary *)toDictionary;
+ (NSMutableArray *)productsDictionaryMutableArrayForProductsArray:(NSArray *)productsArray;

@end
