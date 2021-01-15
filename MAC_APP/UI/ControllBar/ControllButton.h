//
//  ControllButton.h
//  MAC_APP
//
//  Created by Jony on 2021/1/4.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ControllButton : NSButton
@property (nonatomic, assign) BOOL customStatus;
@property (nonatomic, assign) BOOL ignoresClick;
@end

NS_ASSUME_NONNULL_END
