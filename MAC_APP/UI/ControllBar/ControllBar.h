//
//  ControllBar.h
//  MAC_APP
//
//  Created by Jony on 2021/1/4.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ControllDelegate <NSObject>
//- (void)muteEvent:(id)sender;
//- (void)autioSwitchEvent:(id)sender;
//
//- (void)localVideoSwitchEvent:(id)sender;
//- (void)videoSelectorEvent:(id)sender;
//- (void)micSelectorEvent:(id)sender;
//- (void)shutRemoteVideoEvent:(id)sender;
//- (void)shutSingleRemoteVideoEvent:(id)sender
//                            userID:(NSString *)uID
//                            enable:(BOOL)enable;
//- (void)localVolumeEvent:(id)sender;
//- (void)shareScreenEvent:(id)sender;
//- (void)localLayoutEvent:(id)sender;
//- (void)finishClassEvent:(id)sender;
-(void)leaveClassRoom:(id)sender;
@end

@interface ControllBar : NSView
@property(weak,nonatomic)id<ControllDelegate> controllDelegate;
@end

NS_ASSUME_NONNULL_END
