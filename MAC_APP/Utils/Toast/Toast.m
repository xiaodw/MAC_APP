//
//  ToastUtils.m
//  DiscoverMelody
//
//  Created by xiaodw on 2018/9/14.
//  Copyright © 2018年 Beijing Discover Melody co., ltd. All rights reserved.
//  Reference https://www.jianshu.com/p/f1d83eb6a679

#import "Toast.h"

@implementation Toast

static NSMutableArray* toastArray = nil;
static Toast* sharedToastUtils = nil;
static dispatch_once_t onceToken;

+(void)showToastAndSetTime:(NSString*)message atTop:(BOOL)top timerInterval:(NSTimeInterval)ti {
    if (![[NSThread currentThread]isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showToast:message atTop:YES];
        });
        return;
    }
    
    dispatch_once(&onceToken, ^{
        sharedToastUtils = [[self alloc] init];
        toastArray = [NSMutableArray array];
    });
    
    NSTextField* tfToast = [self getNewToastView];
    CGRect frame = [self getToastViewFrameWithMessage:message atTop:top];
    [tfToast setStringValue:message];
    [tfToast setFrame:frame];
    NSTimeInterval i = ti;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((i - 1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sharedToastUtils setOpacityAnimationForToastLabel:tfToast WithDuration:1];
    });
    
    NSInteger arrCount = toastArray.count;
    
    [toastArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSTextField* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((NSInteger)idx <= arrCount - DefaultMaxShowCount) {
            [obj removeFromSuperview];
            return;
        }
        
        CGRect newFrame = obj.frame;
        newFrame.origin.y += top ? -(NSHeight(frame) + DefaultMargin) : (NSHeight(frame) + DefaultMargin);
        obj.frame = newFrame;
    }];
    
    [toastArray addObject:tfToast];
}


+(void)showToast:(NSString*)message atTop:(BOOL)top {
    if (![[NSThread currentThread]isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showToast:message atTop:YES];
        });
        return;
    }
    
    dispatch_once(&onceToken, ^{
        sharedToastUtils = [[self alloc] init];
        toastArray = [NSMutableArray array];
    });

    NSTextField* tfToast = [self getNewToastView];
    CGRect frame = [self getToastViewFrameWithMessage:message atTop:top];
    [tfToast setStringValue:message];
    [tfToast setFrame:frame];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((DefaultShowTime - 1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sharedToastUtils setOpacityAnimationForToastLabel:tfToast WithDuration:1];
    });
    
    NSInteger arrCount = toastArray.count;
    
    [toastArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSTextField* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((NSInteger)idx <= arrCount - DefaultMaxShowCount) {
            [obj removeFromSuperview];
            return;
        }
        
        CGRect newFrame = obj.frame;
        newFrame.origin.y += top ? -(NSHeight(frame) + DefaultMargin) : (NSHeight(frame) + DefaultMargin);
        obj.frame = newFrame;
    }];
    
    [toastArray addObject:tfToast];
}

+(void)removeAllToasts {
    [toastArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSTextField* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.layer removeAllAnimations];
        [obj removeFromSuperview];
    }];
    [toastArray removeAllObjects];
}

+(NSTextField*)getNewToastView {
    NSTextField* tfToast = [[NSTextField alloc]init];
    [tfToast setBordered:NO];
    [tfToast setEditable:NO];
    [tfToast setSelectable:NO];
    [tfToast setAlignment:NSTextAlignmentCenter];
    [tfToast setWantsLayer:YES];
    [tfToast.layer setCornerRadius:4.f];
    [tfToast setTextColor:[NSColor whiteColor]];
    [tfToast setBackgroundColor:[NSColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:0.3f]];
    [[[self getHostWindow]contentView] addSubview:tfToast];
    return tfToast;
}

+(NSRect)getToastViewFrameWithMessage:(NSString*)text atTop:(BOOL)top {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSFont systemFontOfSize:DefaultFont],
                                NSFontAttributeName,
                                [NSColor whiteColor],
                                NSForegroundColorAttributeName,
                                nil];
    NSRect rectToastView = [text boundingRectWithSize:NSMakeSize(DefaultMaxWidth, DefaultMaxHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes];
    
    NSRect rectMainWindow = [self getHostWindow].contentView.frame;
    rectToastView.origin.x = (NSWidth(rectMainWindow) - NSWidth(rectToastView)) / 2;
    rectToastView.origin.y = top ? NSHeight(rectMainWindow) - NSHeight(rectToastView) - DefaultMargin : DefaultMargin;
    
    return rectToastView;
}

+(NSWindow*)getHostWindow {
    static NSWindow* hostWindow = nil;
    
    [[[NSApplication sharedApplication]windows]enumerateObjectsUsingBlock:^(NSWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (nil == hostWindow) hostWindow = obj;
        if (NSHeight(obj.frame) > NSHeight(hostWindow.frame)) {
            hostWindow = obj;
        }
    }];
    
    return hostWindow;
}

- (void)setOpacityAnimationForToastLabel:(NSTextField *)toastLabel WithDuration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(1);
    animation.toValue = @(0);
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = sharedToastUtils;
    [toastLabel.layer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [toastArray.firstObject removeFromSuperview];
    [toastArray removeObject:toastArray.firstObject];
}

@end
