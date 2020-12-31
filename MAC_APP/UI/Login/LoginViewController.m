//
//  LoginViewController.m
//  MAC_APP
//
//  Created by Jony on 2020/12/30.
//

#import "LoginViewController.h"
#import <Masonry.h>
#import <MJExtension.h>
#import "MacApp.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@property (strong,nonatomic)NSImageView* imageViewBackgroud;
@property (strong,nonatomic)NSImageView* imageViewLogo;
@property (strong,nonatomic)LessonCodeField* lessonCodeField;
@property (strong,nonatomic)NSProgressIndicator* loadingAnimater;
@property (strong,nonatomic)ColorButton* buttonJoin;
@property (strong,nonatomic)NSTextField* textFieldVersion;
@property (strong,nonatomic)NSView *infoView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self setupSubviews];
    [self layoutSubviews];
    [self setLoginStatus:LOGIN_STATUS_NOT_READY];
    [self requestPcConfig];
}

-(void)setupSubviews {
    _imageViewBackgroud = [[NSImageView alloc]initWithFrame:self.view.frame];
#if defined(PRODUCT_TYPE_WE_EDUCATION)
    [_imageViewBackgroud setImage:[NSImage imageNamed:@"Login_bg_edu_icon"]];
#elif defined(PRODUCT_TYPE_DISCOVER_MELODY)
    [_imageViewBackgroud setImage:[NSImage imageNamed:@"Login_bg_dm_icon"]];
#elif defined(PRODUCT_TYPE_WE_DESIGN)
    [_imageViewBackgroud setImage:[NSImage imageNamed:@"Login_bg_dm_icon"]];
#endif
    [_imageViewBackgroud setImageScaling:YES];
    [self.view addSubview:_imageViewBackgroud];
    
    self.infoView = [[NSView alloc] initWithFrame:CGRectZero];
    self.infoView.wantsLayer = YES;
    self.infoView.layer.backgroundColor = NSColor.clearColor.CGColor;
    [self.view addSubview:self.infoView];

    self.imageViewLogo = [[NSImageView alloc]initWithFrame:CGRectZero];
#if defined(PRODUCT_TYPE_WE_EDUCATION)
    [self.imageViewLogo setImage:[NSImage imageNamed:@"Login_logo_icon_edu"]];
#elif defined(PRODUCT_TYPE_DISCOVER_MELODY)
    [self.imageViewLogo setImage:[NSImage imageNamed:LSTR(@"LOGIN_VIEW_LOGO_IMG_NAME_DISCOVER_MELODY")]];
#elif defined(PRODUCT_TYPE_WE_DESIGN)
    [self.imageViewLogo setImage:[NSImage imageNamed:@"login_logo-we_design"]];
#endif
    [self.imageViewLogo setImageScaling:YES];
    [self.infoView addSubview:self.imageViewLogo];

    self.lessonCodeField = [[LessonCodeField alloc]initWithFrame:CGRectZero];
    [self.lessonCodeField.textFieldCode.window makeFirstResponder:nil];
    //[self.lessonCodeField.textFieldCode setStringValue:@"c9f2c8c81efddcf9"];
    [self.infoView addSubview:self.lessonCodeField];

    self.buttonJoin = [[ColorButton alloc]initWithFrame:CGRectZero];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary * attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                            Fonts_PingFang_Regular(18),
                            NSFontAttributeName,
                            [NSColor whiteColor], NSForegroundColorAttributeName,
                            paragraphStyle, NSParagraphStyleAttributeName,
                            nil];
    NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:LSTR(@"LOGIN_VIEW_BUTTON_JOIN") attributes:attrs];
    self.buttonJoin.displayString = attributedString;
    [self.buttonJoin setEnabled:NO];
    self.buttonJoin.target = self;
    [self.buttonJoin setAction:@selector(buttonLoginClicked:)];
    [self.infoView addSubview:self.buttonJoin];

    self.textFieldVersion = [[NSTextField alloc]initWithFrame:CGRectZero];
    [self.textFieldVersion setStringValue:[NSString stringWithFormat:LSTR(@"LOGIN_VIEW_VERSION_PREFIX"), [[Tools sharedInstance]getAppVersion]]];
    [self.textFieldVersion setEditable:NO];
    [self.textFieldVersion setSelectable:NO];
    [self.textFieldVersion setBordered:NO];
    [self.textFieldVersion setTextColor:Colors_FromRGB(0xcccccc)];
    [self.textFieldVersion setAlignment:NSTextAlignmentCenter];
    [self.textFieldVersion setBackgroundColor:[NSColor controlColor]];
    [self.textFieldVersion setFont:Fonts_PingFang_Light(14)];
    [self.view addSubview:self.textFieldVersion];
    
    self.loadingAnimater = [[NSProgressIndicator alloc]initWithFrame:CGRectZero];
    [self.loadingAnimater setDisplayedWhenStopped:NO];
    [self.loadingAnimater setUsesThreadedAnimation:YES];
    [self.loadingAnimater setStyle:NSProgressIndicatorStyleSpinning];
    [self.view addSubview:self.loadingAnimater];
}

-(void)layoutSubviews {
    [_imageViewBackgroud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY).with.offset(-20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(338);
    }];
    [_imageViewLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoView).with.offset(0);
        make.centerX.mas_equalTo(self.infoView.mas_centerX);
        make.width.mas_equalTo(154);
        make.height.mas_equalTo(127);
    }];
    [_lessonCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageViewLogo.mas_bottom).with.offset(71);
        make.height.mas_equalTo(50);
        make.left.right.mas_equalTo(self.infoView);
    }];
    [_buttonJoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.infoView).with.offset(0);
        make.centerX.mas_equalTo(self.infoView.mas_centerX);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(55);
    }];
    [_textFieldVersion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_bottom).with.offset(-45);
        make.left.mas_equalTo(self.view.mas_centerX).with.offset(-80);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(25);
    }];
    [_loadingAnimater mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buttonJoin.mas_centerY).with.offset(-28);
        make.left.mas_equalTo(self.buttonJoin.mas_centerX).with.offset(-28);
        make.width.mas_equalTo(56);
        make.height.mas_equalTo(56);
    }];
}

- (void)buttonLoginClicked:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(joinClass:)]) {
//        NSString *condeStr = self.lessonCodeField.textFieldCode.stringValue;
//        [self.delegate joinClass:condeStr];
//    }
    
    //NSApplication* app =[NSApplication sharedApplication];
    //AppDelegate* delegate = (AppDelegate*)app.delegate;
    //[delegate showSmallClassView];
    
    NSString* lessonCode = [_lessonCodeField.textFieldCode stringValue];
    LOG(lessonCode);
    
    [self requestLoginCode:lessonCode];
    
//    NSApplication* app = [NSApplication sharedApplication];
//    AppDelegate* delegate = (AppDelegate*)app.delegate;
//    [delegate showSmallClassView];
}

- (void)textDidChange:(NSNotification *)notification {
    if ([notification.object isEqual:self.lessonCodeField.textFieldCode]) {
        if (0 == self.lessonCodeField.textFieldCode.stringValue.length) {
            if (YES == self.buttonJoin.isEnabled) {
                [self.buttonJoin setEnabled:NO];
            }
        } else {
            NSString* lessonCode = self.lessonCodeField.textFieldCode.stringValue;
            NSString* ripeCode = [lessonCode stringByReplacingOccurrencesOfString:@" " withString:@""];
            ripeCode = [ripeCode stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            ripeCode = [ripeCode stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            if (![ripeCode isEqualToString:lessonCode]) {
                self.lessonCodeField.textFieldCode.stringValue = ripeCode;
            }
            
            if ([ripeCode length] > 0) {
                if (NO == self.buttonJoin.isEnabled) {
                    [self.buttonJoin setEnabled:YES];
                }
            } else {
                if (YES == self.buttonJoin.isEnabled) {
                    [self.buttonJoin setEnabled:NO];
                }
            }
        }
    }
}

-(void)setLatestLessonCode:(NSString*)code {
    [self.lessonCodeField.textFieldCode setStringValue:code];
}

-(void)setLoginAction:(SEL)action withTarget:(id)target{
    [self.buttonJoin setAction:action];
}

-(void)setLoginStatus:(enum LOGIN_STATUS)status {
    if (LOGIN_STATUS_NOT_READY == status) {
        [self.loadingAnimater startAnimation:self];
        [self.buttonJoin setEnabled:NO];
        [self.lessonCodeField.textFieldCode setEnabled:NO];
    } else if (LOGIN_STATUS_WAIT_LESSON_CODE == status) {
        [self.loadingAnimater stopAnimation:self];
        [self.buttonJoin setEnabled:YES];
        [self.lessonCodeField.textFieldCode setEnabled:YES];
    } else if (LOGIN_STATUS_DOING == status) {
        [self.loadingAnimater startAnimation:self];
        [self.buttonJoin setEnabled:NO];
        [self.lessonCodeField.textFieldCode setEnabled:NO];
    } else if (LOGIN_STATUS_DONE == status) {
        [self.loadingAnimater stopAnimation:self];
        [self.buttonJoin setEnabled:YES];
        [self.lessonCodeField.textFieldCode setEnabled:YES];
    } else {
        [self.loadingAnimater stopAnimation:self];
        [self.buttonJoin setEnabled:YES];
        [self.lessonCodeField.textFieldCode setEnabled:YES];
        [self.lessonCodeField.textFieldCode resetCursorRects ];
    }
}

#pragma mark -- API request --
-(void)requestPcConfig {
    NSMutableDictionary* dicParams = [NSMutableDictionary dictionary];
    [[HttpClient sharedInstance]postWithUrl:URL_GET_APP_CONFIG parameters:dicParams success:^(id  _Nonnull responseObject) {
        [AppData sharedInstance].appConfig = [AppConfig mj_objectWithKeyValues:responseObject];
        [Toast showToastAndSetTime:[AppData sharedInstance].appConfig.app.updateMsg atTop:YES timerInterval:3];
        [self setLoginStatus:LOGIN_STATUS_WAIT_LESSON_CODE];
        if (1 == [AppData sharedInstance].appConfig.app.update || 2 == [AppData sharedInstance].appConfig.app.update) {
            [self updateApp];
        }
    } failure:^(NSError * _Nonnull error) {
        LOG(error.localizedDescription);
        [Toast showToastAndSetTime:error.localizedDescription atTop:YES timerInterval:3];
    }];
}

-(void)requestLoginCode:(NSString*)code {
    [self setLoginStatus:LOGIN_STATUS_DOING];
    
    NSMutableDictionary* dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setObject:code forKey:@"code"];
    
    [[HttpClient sharedInstance]postWithUrl:URL_GET_USER_INFO parameters:dicParams success:^(id  _Nonnull responseObject) {
        [AppData sharedInstance].loginResult = [LoginResult mj_objectWithKeyValues:responseObject];
        
        LOG([AppData sharedInstance].loginResult.meeting_id);
        LOG([AppData sharedInstance].loginResult.token);
        LOG([AppData sharedInstance].loginResult.user_id);
        LOG([AppData sharedInstance].loginResult.user_type);
        NSLog(@"%d", [AppData sharedInstance].loginResult.config.agora_video_profile);
        NSLog(@"%d", [AppData sharedInstance].loginResult.config.audio_profile);
        NSLog(@"%d", [AppData sharedInstance].loginResult.config.audio_scenario);
        NSLog(@"%d", [AppData sharedInstance].loginResult.config.play_volume);
        NSLog(@"%d", [AppData sharedInstance].loginResult.config.record_volume);
        
        [self requestAccess:[AppData sharedInstance].loginResult.meeting_id
                      Token:[AppData sharedInstance].loginResult.token]; //[self setLoginStatus:LOGIN_STATUS_DONE];
    } failure:^(NSError * _Nonnull error) {
        LOG(error.localizedDescription);
        [self setLoginStatus:LOGIN_STATUS_DONE];
        [Toast showToastAndSetTime:error.localizedDescription atTop:YES timerInterval:3];
    }];
}

-(void)requestAccess:(NSString*)meetingId Token:(NSString*)token{
    [self setLoginStatus:LOGIN_STATUS_DOING];
    
    NSMutableDictionary* dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setObject:meetingId forKey:@"meeting_id"];
    [dicParams setObject:token forKey:@"token"];
    
    NSString* url = URL_GET_LESSON_INFO_STUDENT; // URL_GET_LESSON_INFO_TEACHER // URL_GET_LESSON_INFO_ASSISTANT
    
    // user_type 用户类型（0-学生，1-老师，2-管理员，3助教）
    if (0 == [AppData sharedInstance].loginResult.user_type.intValue) {
        url = URL_GET_LESSON_INFO_STUDENT;
    } else if (1 == [AppData sharedInstance].loginResult.user_type.intValue) {
        url = URL_GET_LESSON_INFO_TEACHER;
    } else if (2 == [AppData sharedInstance].loginResult.user_type.intValue){
        url = URL_GET_LESSON_INFO_ASSISTANT; // 应该有管理员接口
    } else {
        url = URL_GET_LESSON_INFO_ASSISTANT;
    }
    
    [[HttpClient sharedInstance]postWithUrl:url parameters:dicParams success:^(id  _Nonnull responseObject) {
        [AppData sharedInstance].meetingConfig = [MeetingConfig mj_objectWithKeyValues:responseObject];
        
        NSLog(@"%d", [AppData sharedInstance].meetingConfig.assistant_id);
        LOG([AppData sharedInstance].meetingConfig.channel_name);
        LOG([AppData sharedInstance].meetingConfig.easemob_app_key);
//        NSLog(@"%d", [AppData sharedInstance].loginResult.config.audio_profile);
//        NSLog(@"%d", [AppData sharedInstance].loginResult.config.audio_scenario);
//        NSLog(@"%d", [AppData sharedInstance].loginResult.config.play_volume);
//        NSLog(@"%d", [AppData sharedInstance].loginResult.config.record_volume);
        
        //[self reportAction:[AppData sharedInstance].loginResult.meeting_id Action:@"enter" TargetUId:[AppData sharedInstance].meetingConfig.teacher_id UploadUId:TargetUId:[AppData sharedInstance].meetingConfig.teacher_id];
        [self reportAction:[AppData sharedInstance].loginResult.meeting_id
                    Action:@"enter"
                 TargetUId:[AppData sharedInstance].meetingConfig.teacher_id
                 UploadUId:[AppData sharedInstance].meetingConfig.teacher_id];
        
        [self setLoginStatus:LOGIN_STATUS_DONE];
    } failure:^(NSError * _Nonnull error) {
        LOG(error.localizedDescription);
        [self setLoginStatus:LOGIN_STATUS_DONE];
        [Toast showToastAndSetTime:error.localizedDescription atTop:YES timerInterval:3];
    }];
}

-(void)reportAction:(NSString*)meetingId Action:(NSString*)ac TargetUId:(int)tUId UploadUId:(int)uUId {
    [self setLoginStatus:LOGIN_STATUS_DOING];
    
    NSMutableDictionary* dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setObject:meetingId forKey:@"meeting_id"];
    [dicParams setObject:ac forKey:@"action"];
    [dicParams setObject:[NSString stringWithFormat:@"%d", tUId] forKey:@"target_uid"];
    [dicParams setObject:[NSString stringWithFormat:@"%d", uUId] forKey:@"upload_uid"];

    
    [[HttpClient sharedInstance]postWithUrl:URL_REPORT_AGORA_LOG parameters:dicParams success:^(id  _Nonnull responseObject) {
        id resp = responseObject;
        NSLog(@"--> resp = %@", resp);
    } failure:^(NSError * _Nonnull error) {
        LOG(error.localizedDescription);
    }];
}

-(void)updateApp {
    __weak __typeof(&*self)weakSelf = self;

    if (1 == [AppData sharedInstance].appConfig.app.update) {
        [Tools alertMsg:[AppData sharedInstance].appConfig.app.updateMsg title:LSTR(@"ALERT_UPDATE_TITLE")
               buttonOk:LSTR(@"ALERT_BUTTON_OK")
                   view:weakSelf.view
           buttonCancel:LSTR(@"ALERT_BUTTON_CANCEL")
                   onOk:^{
            [[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:[AppData sharedInstance].appConfig.app.updateUrl]];
        }
               onCancel:^{ }];
    } else if (2 == [AppData sharedInstance].appConfig.app.update) {
        [Tools alertMsg:[AppData sharedInstance].appConfig.app.updateMsg
                  title:LSTR(@"ALERT_UPDATE_TITLE")
               buttonOk:LSTR(@"ALERT_BUTTON_OK")
                   view:weakSelf.view buttonCancel:@""
                   onOk:^{
            [[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:[AppData sharedInstance].appConfig.app.updateUrl]];
            exit(0);
        }
               onCancel:^{ }];
    }
}


@end
