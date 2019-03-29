// ======================================================================
// Project Name    : ios_plugin
//
// Copyright © 2019 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <FirebaseInstanceID/FirebaseInstanceID.h>
#import <FirebaseCore/FirebaseCore.h>
#import <FirebaseMessaging/FirebaseMessaging.h>
#import "FCMNotifierPlugin.h"
@interface FCMNotifierPlugin ()<UNUserNotificationCenterDelegate, FIRMessagingDelegate>
@end
@implementation FCMNotifierPlugin
+ (FCMNotifierPlugin*)getInstance {
    static FCMNotifierPlugin* instance = nil;
    if (nil == instance) {
        instance = [[FCMNotifierPlugin alloc] init];
    }
    return instance;
}
- (void)regist {
    [FIRApp configure];
    FIRMessaging* messaging = [FIRMessaging messaging];
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    messaging.delegate = self;
    [notificationCenter addObserver:self selector:@selector(tokenRefreshNotification) name:kFIRInstanceIDTokenRefreshNotification object:nil];
    typedef void (^cb_t)(BOOL granted, NSError * __nullable error);
    cb_t cb = ^(BOOL granted, NSError * __nullable error) {
        if (NO == granted) {
            return;
        }
        if (nil != error) {
            NSLog(@"%@", error.debugDescription);
        } else {
            FIRInstanceID* firInstance = [FIRInstanceID instanceID];
            NSString* fcmToken = [firInstance token];
            UIApplication* app = [UIApplication sharedApplication];
            [app registerForRemoteNotifications];
            NSLog(@"fcmToken::%@", fcmToken);
        }
        return;
    };
    UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
    UNUserNotificationCenter* userNotoficationCenter = UNUserNotificationCenter.currentNotificationCenter;
    userNotoficationCenter.delegate = self;
    [userNotoficationCenter requestAuthorizationWithOptions:options completionHandler:cb];
    return;
}
- (void)notify:(NSString*)title body:(NSString*)body interval:(NSTimeInterval)interval {
    return;
}
- (void)notify:(NSDictionary*)userInfo {
    return;
}
- (void)reset {
    UIApplication* app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = 0;
    return;
}
- (void)tokenRefreshNotification {
    FIRInstanceID* firInstance = [FIRInstanceID instanceID];
    FIRMessaging* messaging = [FIRMessaging messaging];
    NSString* fcmToken = [firInstance token];
    if (nil == fcmToken) {
        NSLog(@"fcmToken is null");
        return;
    }
    typedef void (^cb_t)(NSError * __nullable error);
    cb_t cb = ^(NSError * __nullable error) {
        if (nil != error) {
            NSLog(@"%@", error.debugDescription);
        } else {
            NSLog(@"success connect to fcm");
        }
        return;
    };
    [messaging disconnect];
    [messaging connectWithCompletion:cb];
    NSLog(@"fcmToken::%@", fcmToken);
    return;
}
- (void)applicationReceivedRemoteMessage:(nonnull FIRMessagingRemoteMessage*)remoteMessage {
    NSLog(@"Received data message:%@", remoteMessage.appData);
    return;
}
- (void)userNotificationCenter:(UNUserNotificationCenter*)center willPresentNotification:(UNNotification*)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler __IOS_AVAILABLE(10.0)__TVOS_AVAILABLE(10.0)__WATCHOS_AVAILABLE(3.0) {
    NSDictionary* userInfo = notification.request.content.userInfo;
    [self notify:userInfo];
    UNNotificationPresentationOptions options = UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionAlert;
    completionHandler(options);
    return;
}
- (void)userNotificationCenter:(UNUserNotificationCenter*)center didReceiveNotificationResponse:(UNNotificationResponse*)response withCompletionHandler:(void (^)(void))completionHandler __IOS_AVAILABLE(10.0)__WATCHOS_AVAILABLE(3.0)__TVOS_PROHIBITED {
    NSDictionary* userInfo = response.notification.request.content.userInfo;
    [self notify:userInfo];
    completionHandler();
    return;
}
@end
