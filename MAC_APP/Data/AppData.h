//
//  AppData.h
//  MAC_APP
//
//  Created by Jony on 2020/12/30.
//

#import <Foundation/Foundation.h>
#import "MacApp.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppData : NSObject
+(AppData*)sharedInstance;

@property(strong,nonatomic)AppConfig* appConfig;
@property(strong,nonatomic)LoginResult* loginResult;
@property(strong,nonatomic)MeetingConfig* meetingConfig;

@property(strong,nonatomic)AgoraRtcEngineKit* agoraKit;
@end

NS_ASSUME_NONNULL_END
