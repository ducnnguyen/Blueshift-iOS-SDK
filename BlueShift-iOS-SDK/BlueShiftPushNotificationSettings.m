//
//  BlueShiftPushNotificationSettings.m
//  BlueShift-iOS-Extension-SDK
//
//  Created by shahas kp on 05/11/17.
//

#import "BlueShiftPushNotificationSettings.h"
#import "BlueShiftNotificationConstants.h"

@implementation BlueShiftPushNotificationSettings

- (UIMutableUserNotificationCategory *)buyCategory {
    UIMutableUserNotificationAction *buyAction;
    buyAction = [[UIMutableUserNotificationAction alloc] init];
    [buyAction setActivationMode:UIUserNotificationActivationModeForeground];
    [buyAction setTitle:@"Buy"];
    [buyAction setIdentifier:kNotificationActionBuyIdentifier];
    [buyAction setDestructive:NO];
    [buyAction setAuthenticationRequired:NO];
    
    UIMutableUserNotificationAction *viewAction;
    viewAction = [[UIMutableUserNotificationAction alloc] init];
    [viewAction setActivationMode:UIUserNotificationActivationModeForeground];
    [viewAction setTitle:@"View"];
    [viewAction setIdentifier:kNotificationActionViewIdentifier];
    [viewAction setDestructive:NO];
    [viewAction setAuthenticationRequired:NO];
    
    UIMutableUserNotificationCategory *buyCategory;
    buyCategory = [[UIMutableUserNotificationCategory alloc] init];
    [buyCategory setIdentifier:kNotificationCategoryBuyIdentifier];
    [buyCategory setActions:@[buyAction, viewAction]
                 forContext:UIUserNotificationActionContextDefault];
    
    return buyCategory;
}

- (UIMutableUserNotificationCategory *)viewCartCategory {
    UIMutableUserNotificationAction *openCartAction;
    openCartAction = [[UIMutableUserNotificationAction alloc] init];
    [openCartAction setActivationMode:UIUserNotificationActivationModeForeground];
    [openCartAction setTitle:@"Open Cart"];
    [openCartAction setIdentifier:kNotificationActionOpenCartIdentifier];
    [openCartAction setDestructive:NO];
    [openCartAction setAuthenticationRequired:NO];
    
    UIMutableUserNotificationCategory *viewCartCategory;
    viewCartCategory = [[UIMutableUserNotificationCategory alloc] init];
    [viewCartCategory setIdentifier:kNotificationCategoryViewCartIdentifier];
    [viewCartCategory setActions:@[openCartAction]
                      forContext:UIUserNotificationActionContextDefault];
    
    return viewCartCategory;
}

- (UIMutableUserNotificationCategory *)oneButtonAlertCategory {
    UIMutableUserNotificationCategory *oneButtonAlertCategory;
    oneButtonAlertCategory = [[UIMutableUserNotificationCategory alloc] init];
    [oneButtonAlertCategory setIdentifier:kNotificationOneButtonAlertIdentifier];
    [oneButtonAlertCategory setActions:@[]
                            forContext:UIUserNotificationActionContextDefault];
    
    return oneButtonAlertCategory;
}

- (UIMutableUserNotificationCategory *)twoButtonAlertCategory {
    UIMutableUserNotificationAction *viewAction;
    viewAction = [[UIMutableUserNotificationAction alloc] init];
    [viewAction setActivationMode:UIUserNotificationActivationModeForeground];
    [viewAction setTitle:@"View"];
    [viewAction setIdentifier:kNotificationActionViewIdentifier];
    [viewAction setDestructive:NO];
    [viewAction setAuthenticationRequired:NO];
    
    UIMutableUserNotificationCategory *twoButtonAlertCategory;
    twoButtonAlertCategory = [[UIMutableUserNotificationCategory alloc] init];
    [twoButtonAlertCategory setIdentifier:kNotificationTwoButtonAlertIdentifier];
    [twoButtonAlertCategory setActions:@[viewAction]
                            forContext:UIUserNotificationActionContextDefault];
    
    return twoButtonAlertCategory;
}

- (NSSet *)notificationCategories {
    return [NSSet setWithObjects:self.buyCategory, self.viewCartCategory, self.oneButtonAlertCategory, self.twoButtonAlertCategory, nil];
}

- (UIUserNotificationType)notificationTypes {
    return (UIUserNotificationTypeAlert|
            UIUserNotificationTypeSound|
            UIUserNotificationTypeBadge);
}

- (UIUserNotificationSettings *)notificationSettings {
    return [UIUserNotificationSettings settingsForTypes:self.notificationTypes categories:self.notificationCategories];
}

@end
