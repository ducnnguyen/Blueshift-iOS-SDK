//
//  BlueShiftNotificationViewController.m
//  BlueShift-iOS-Extension-SDK
//
//  Created by shahas kp on 10/07/19.
//

#import "BlueShiftNotificationViewController.h"
#import "BlueShiftNotificationWindow.h"
#import "BlueShiftNotificationView.h"
#import <CoreText/CoreText.h>
#import "../BlueShiftInAppNotificationConstant.h"

@interface BlueShiftNotificationViewController ()

@property(nonatomic, assign) CGFloat initialHorizontalCenter;
@property(nonatomic, assign) CGFloat initialTouchPositionX;
@property(nonatomic, assign) CGFloat originalCenter;

@end

@implementation BlueShiftNotificationViewController

- (instancetype)initWithNotification:(BlueShiftInAppNotification *)notification {
    self = [super init];
    if (self) {
        _notification = notification;
    }
    return self;
}

- (void)setTouchesPassThroughWindow:(BOOL) can {
    self.canTouchesPassThroughWindow = can;
}

- (void)closeButtonDidTapped {
    [self hide:YES];
}

- (void)loadNotificationView {
    self.view = [[BlueShiftNotificationView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void)createWindow {
    Class windowClass = self.canTouchesPassThroughWindow ? BlueShiftNotificationWindow.class : UIWindow.class;
    self.window = [[windowClass alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.window.alpha = 0;
    self.window.backgroundColor = [UIColor clearColor];
    self.window.windowLevel = UIWindowLevelNormal;
    self.window.rootViewController = self;
    [self.window setHidden:NO];
}

-(void)show:(BOOL)animated {
    NSAssert(false, @"Override in sub-class");
}

-(void)hide:(BOOL)animated {
    NSAssert(false, @"Override in sub-class");
}

- (CGRect)positionNotificationView:(UIView *)notificationView {
    float width = (self.notification.templateStyle && self.notification.templateStyle.width > 0) ? self.notification.templateStyle.width : self.notification.width;
    float height = (self.notification.templateStyle && self.notification.templateStyle.height > 0) ? self.notification.templateStyle.height : self.notification.height;
    
    CGSize size = CGSizeZero;
    if ([self.notification.dimensionType  isEqual: kInAppNotificationModalResolutionPointsKeys]) {
        // Ignore Constants.INAPP_X_PERCENT
        size.width = width;
        size.height = height;
    } else if([self.notification.dimensionType  isEqual: kInAppNotificationModalResolutionPercntageKey]) {
        size.width = (CGFloat) ceil([[UIScreen mainScreen] bounds].size.width * (width / 100.0f));
        size.height = (CGFloat) ceil([[UIScreen mainScreen] bounds].size.height * (height / 100.0f));
    }else {
        
    }
    
    CGRect frame = notificationView.frame;
    frame.size = size;
    notificationView.autoresizingMask = UIViewAutoresizingNone;
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    NSString* position = (self.notification.templateStyle && self.notification.templateStyle.position) ? self.notification.templateStyle.position : self.notification.position;
    
    if([position  isEqual: kInAppNotificationModalPositionTopKey]) {
        frame.origin.x = (screenSize.width - size.width) / 2.0f;
        frame.origin.y = 0.0f + 20.0f;
        notificationView.autoresizingMask = notificationView.autoresizingMask | UIViewAutoresizingFlexibleBottomMargin;
    } else if([position  isEqual: kInAppNotificationModalPositionCenterKey]) {
        frame.origin.x = (screenSize.width - size.width) / 2.0f;
        frame.origin.y = (screenSize.height - size.height) / 2.0f;
    } else if([position  isEqual: kInAppNotificationModalPositionBottomKey]) {
        frame.origin.x = (screenSize.width - size.width) / 2.0f;
        frame.origin.y = screenSize.height - size.height;
        notificationView.autoresizingMask = notificationView.autoresizingMask | UIViewAutoresizingFlexibleTopMargin;
    } else {
        
    }
    
    frame.origin.x = frame.origin.x < 0.0f ? 0.0f : frame.origin.x;
    frame.origin.y = frame.origin.y < 0.0f ? 0.0f : frame.origin.y;
    notificationView.frame = frame;
    _originalCenter = frame.origin.x + frame.size.width / 2.0f;
    
    return frame;
}

- (void)configureBackground {
    self.view.backgroundColor = [UIColor clearColor];
}

- (UIColor *)colorWithHexString:(NSString *)str {
    unsigned char r, g, b;
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    b =  x & 0xFF;
    g = (x >> 8) & 0xFF;
    r = (x >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}

- (UIView *)fetchNotificationView{
    switch (self.notification.inAppType) {
        case BlueShiftInAppTypeModal:
            return [self renderCategorizedNotificationView];
        case BlueShiftNotificationSlideBanner:
            return [[[NSBundle mainBundle] loadNibNamed: kInAppNotificationSlideBannerXIBNameKey  owner:self options:nil] objectAtIndex:0];
        default:
            return [[[NSBundle mainBundle] loadNibNamed: kInAppNotificationModalXIBNameKey owner:self options:nil] objectAtIndex:0];
            break;
    }
}

- (UIView *)renderCategorizedNotificationView{
    if (self.notification) {
        if (self.notification.notificationContent && self.notification.notificationContent.icon) {
            return [[[NSBundle mainBundle] loadNibNamed: kInAppNotificationModalWithImageXIBNameKey owner:self options:nil] objectAtIndex:0];
        }else if ((self.notification.appOpen && !self.notification.dismiss && !self.notification.share)
                  || (!self.notification.appOpen && self.notification.dismiss && !self.notification.share)
                  || (!self.notification.appOpen && !self.notification.dismiss && self.notification.share)){
            return [[[NSBundle mainBundle] loadNibNamed: kInAppNotificationModalWithOneButtonXIBNameKey owner:self options:nil] objectAtIndex:0];
        }else{
            return [[[NSBundle mainBundle] loadNibNamed: kInAppNotificationModalXIBNameKey owner:self options:nil] objectAtIndex:0];
        }
    }
    
    return [[[NSBundle mainBundle] loadNibNamed: kInAppNotificationModalXIBNameKey owner:self options:nil] objectAtIndex:0];
}

- (void)loadImageFromURL:(UIImageView *)imageView andImageURL:(NSString *)imageURL{
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imageURL]];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    // resize image
    CGSize newSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContext( newSize );// a CGSize that has the size you want
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    //image is the original UIImage
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    imageView.image = newImage;
}

- (void)setLabelText:(UILabel *)label andString:(NSString *)value
          labelColor:(NSString *)labelColorCode
     backgroundColor:(NSString *)backgroundColorCode {
    if (value != (id)[NSNull null] && value.length > 0 ) {
        label.hidden = NO;
        label.text = value;
        
        if (labelColorCode != (id)[NSNull null] && labelColorCode.length > 0) {
            label.textColor = [self colorWithHexString:labelColorCode];
        }
        
        if (backgroundColorCode != (id)[NSNull null] && backgroundColorCode.length > 0) {
            label.backgroundColor = [self colorWithHexString:backgroundColorCode];
        }
    }else {
        label.hidden = YES;
    }
}

- (void)applyIconToLabelView:(UILabel *)iconLabelView {
    if (self.notification.notificationContent.icon) {
        if ([UIFont fontWithName:kInAppNotificationModalFontAwesomeNameKey size:30] == nil) {
            NSString *fontPath = [[NSBundle bundleForClass:[BlueShiftNotificationViewController class]]
                                  pathForResource: kInAppNotificationModalFontAwesomeFileNameKey
                                  ofType: kInAppNotificationModalFontExtensionKey];
            
            NSData *fontData = [NSData dataWithContentsOfFile:fontPath];
            CFErrorRef error;
            CGDataProviderRef provider = CGDataProviderCreateWithCFData(( CFDataRef)fontData);
            CGFontRef font = CGFontCreateWithDataProvider(provider);
            BOOL failedToRegisterFont = NO;
            if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
                CFStringRef errorDescription = CFErrorCopyDescription(error);
                NSLog(@"Error: Cannot load Font Awesome");
                CFBridgingRelease(errorDescription);
                failedToRegisterFont = YES;
            }
            
            CFRelease(font);
            CFRelease(provider);
        }
    
        iconLabelView.font = [UIFont fontWithName: kInAppNotificationModalFontAwesomeNameKey size: 22.0];
    
        [self setLabelText: iconLabelView andString: self.notification.notificationContent.icon labelColor:self.notification.contentStyle.iconColor backgroundColor:self.notification.contentStyle.iconBackgroundColor];
    
        iconLabelView.layer.cornerRadius = 10;
        iconLabelView.layer.masksToBounds = YES;
    }
}

@end
