// ======================================================================
// Project Name    : ios_plugin
//
// Copyright © 2019 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
#import <Foundation/Foundation.h>
@interface FCMNotifierPlugin : NSObject
+ (FCMNotifierPlugin*)getInstance;
- (void)regist;
- (void)notify:(NSString*)title body:(NSString*)body interval:(NSTimeInterval)interval;
- (void)notify:(NSDictionary*)userInfo;
- (void)reset;
@end
