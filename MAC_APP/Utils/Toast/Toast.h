//
//  ToastUtils.h
//  DiscoverMelody
//
//  Created by xiaodw on 2018/9/14.
//  Copyright © 2018年 Beijing Discover Melody co., ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/CAAnimation.h>
 
#define DefaultMaxShowCount 1
#define DefaultShowTime     5
#define DefaultFont         16
#define DefaultMargin       5
#define DefaultMaxWidth     400
#define DefaultMaxHeight    400
#define DefaultBgColor      [UIColor darkGrayColor]
#define DefaultTextColor    [UIColor whiteColor]

@interface Toast : NSObject<CAAnimationDelegate>
+(void)showToastAndSetTime:(NSString*)message atTop:(BOOL)top timerInterval:(NSTimeInterval)ti;
+(void)showToast:(NSString*)message atTop:(BOOL)top;
+(void)removeAllToasts;
@end
