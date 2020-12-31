//
//  Models.h
//  MAC_APP
//
//  Created by Jony on 2020/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppUpdate : NSObject
@property (assign, nonatomic)int update;
@property (copy, nonatomic)NSString* verNew;
@property (copy, nonatomic)NSString* updateMsg;
@property (copy, nonatomic)NSString* updateUrl;
@end

@interface AppConfig : NSObject
@property (copy, nonatomic)NSString* agoraAppId;
@property (strong,nonatomic)AppUpdate* app;
@end

@interface AVConfig : NSObject
@property(assign,nonatomic)int agora_video_profile;
@property(assign,nonatomic)int screen_sharing;
@property(assign,nonatomic)int recording;
@property(assign,nonatomic)int play_volume;
@property(assign,nonatomic)int record_volume;
@property(assign,nonatomic)int audio_scenario;
@property(assign,nonatomic)int audio_profile;
@end

@interface LoginResult : NSObject
@property (copy, nonatomic)NSString* meeting_id;
@property (copy, nonatomic)NSString* user_id;
@property (copy, nonatomic)NSString* user_type;
@property (copy, nonatomic)NSString* token;
@property (strong,nonatomic)AVConfig* config;
@end

@interface MeetingConfig : NSObject
@property (copy, nonatomic)NSString* channel_key;
@property (copy, nonatomic)NSString* channel_name;
@property (copy, nonatomic)NSString* signaling_key;
@property (assign, nonatomic)int uid;
@property (assign, nonatomic)int student_id;
@property (assign, nonatomic)int teacher_id;
@property (assign, nonatomic)int assistant_id;
@property (assign, nonatomic)int start_time;
@property (assign, nonatomic)int duration;
@property (assign, nonatomic)int countdown;
@property (assign, nonatomic)int forceclose;
@property (assign, nonatomic)int play_volume;
@property (assign, nonatomic)int record_volume;
@property (assign, nonatomic)int audio_scenario;
@property (assign, nonatomic)int audio_profile;
@property (copy, nonatomic)NSString* easemob_app_key;
@property (copy, nonatomic)NSString* im_group_id;
@end

NS_ASSUME_NONNULL_END
