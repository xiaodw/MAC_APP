//
//  ClassRoomViewController.m
//  MAC_APP
//
//  Created by Jony on 2021/1/4.
//

#import "ClassRoomViewController.h"
#import "MacApp.h"
#import "ControllBar.h"
#import "VideoCanvasView.h"
#import <Masonry.h>

@interface ClassRoomViewController () <AgoraRtcEngineDelegate, ControllDelegate>
@property(strong,nonatomic)ControllBar* controllBar;
@property(strong,nonatomic)NSMutableDictionary* dicVideoCanvas;
@end

@implementation ClassRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    [APP_DELEGATE.window setTitle:@"ClassRoomViewController"];
   
    [self.view setWantsLayer:YES];
    [[self.view layer]setBackgroundColor:[NSColor grayColor].CGColor];
    _dicVideoCanvas = [[NSMutableDictionary alloc]init];
    
    [self setupSubviews];
    [self layoutSubviews];
    
    [[AppData sharedInstance].agoraKit setDelegate:self];
    [self joinClass];
}

-(VideoCanvasView*)videoCanvasFromTag:(NSString*)tag {
    VideoCanvasView* videoCanvas = [_dicVideoCanvas objectForKey:tag];
    if (IS_OBJ_NIL(videoCanvas)) {
        videoCanvas = [[VideoCanvasView alloc]initWithFrame:NSZeroRect];
        [_dicVideoCanvas setObject:videoCanvas forKey:tag];
        [self.view addSubview:videoCanvas];
    }
    return videoCanvas;
}

-(void)setupSubviews {
    NSSize szViewFrame = self.view.frame.size;
    NSRect reControllBar = NSMakeRect(0, 0, szViewFrame.width, 56);
    _controllBar = [[ControllBar alloc]initWithFrame:(NSRect)reControllBar];
    _controllBar.controllDelegate = self;
    [self.view addSubview:_controllBar];
}

-(void)layoutSubviews {
    [_controllBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_bottom).offset(-56);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    id view = [self videoCanvasFromTag:@"teacher"];
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
    }];
    
    [[self videoCanvasFromTag:@"student"]mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
    }];
}

-(void)joinClass {
    [[AppData sharedInstance].agoraKit enableVideo];
    
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = [AppData sharedInstance].meetingConfig.uid;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = [self videoCanvasFromTag:@"teacher"];
    // 设置本地视图
    [[AppData sharedInstance].agoraKit setupLocalVideo:videoCanvas];
    
    [[AppData sharedInstance].agoraKit joinChannelByToken:[AppData sharedInstance].meetingConfig.channel_key
                                                channelId:[AppData sharedInstance].meetingConfig.channel_name
                                                     info:nil uid:[AppData sharedInstance].meetingConfig.uid
                                              joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
        LOG(@"join success");
    }];
    if (0 != [[AppData sharedInstance].agoraKit enableLoopbackRecording:YES deviceName:@"BlackHole 2ch"]) {
        LOG(@"开启声卡采集失败");
    }
}

// SDK 接收到第一帧远端视频并成功解码时，会触发该回调
- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoDecodedOfUid:(NSUInteger)uid size: (CGSize)size elapsed:(NSInteger)elapsed {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = [self videoCanvasFromTag:@"student"];
    
    [[AppData sharedInstance].agoraKit setupRemoteVideo:videoCanvas];
}


#pragma mark Controllbar Responser
-(void)leaveClassRoom:(id)sender {
    LOG(@"leaveClassRoom");
    [[AppData sharedInstance].agoraKit leaveChannel:^(AgoraChannelStats * _Nonnull stat) {
        [APP_DELEGATE showLoginView];
    }];
}

@end
