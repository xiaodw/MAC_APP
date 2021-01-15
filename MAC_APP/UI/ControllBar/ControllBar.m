//
//  ControllBar.m
//  MAC_APP
//
//  Created by Jony on 2021/1/4.
//

#import "ControllBar.h"
#import "MacApp.h"
#import "ControllButton.h"
#import "VcLabel.h"
#import <Masonry.h>

@interface ControllBar()
@property(strong,nonatomic)ControllButton* buttonAudioSwitch;
@property(strong,nonatomic)ControllButton* buttonAudioSetting;
@property(strong,nonatomic)ControllButton* buttonVideoSwitch;
@property(strong,nonatomic)ControllButton* buttonVideoSetting;
@property(strong,nonatomic)ControllButton* buttonAudioMuteAll;
@property(strong,nonatomic)ControllButton* buttonAudioUnmuteAll;
@property(strong,nonatomic)ControllButton* buttonLayoutSwitch;
@property(strong,nonatomic)ControllButton* buttonScreenShareSwitch;
@property(strong,nonatomic)ControllButton* buttonVolumSetting;
@property(strong,nonatomic)ControllButton* buttonRemoteVideoSwitch;
@property(strong,nonatomic)ControllButton* buttonScreenNoteSwitch;
@property(strong,nonatomic)VcLabel* vcLabelTipInfo;
@property(strong,nonatomic)NSImageView* imageViewRecordStatus;
@property(strong,nonatomic)ControllButton* buttonLeaveClassRoom;

@end

@implementation ControllBar

-(void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

-(instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self setupSubViews];
        [self layoutSubViews];
    }
    return self;
}

-(void)setupSubViews {
    
    [self setWantsLayer:YES];
    [[self layer]setBackgroundColor:[NSColor blackColor].CGColor];
    
    _buttonAudioSwitch = [ControllButton buttonWithTitle:LSTR(@"CB_LOCAL_AUDIO_DISABLE")
                                             image:[NSImage imageNamed:@"CB_LocalAudioEnabled"]
                                            target:_controllDelegate
                                            action:@selector(autioSwitchEvent:)];
    [self addSubview:_buttonAudioSwitch];
    
    _buttonAudioSetting= [ControllButton buttonWithTitle:@""
                                                   image:[NSImage imageNamed:@"CB_UpArrow"]
                                                  target:_controllDelegate
                                                  action:@selector(autioSwitchEvent:)];
    [self addSubview:_buttonAudioSetting];
    
    _buttonVideoSwitch = [ControllButton buttonWithTitle:LSTR(@"CB_LOCAL_VIDEO_DISABLE")
                                             image:[NSImage imageNamed:@"CB_LocalVideoEnabled"]
                                            target:_controllDelegate
                                            action:@selector(autioSwitchEvent:)];
    [self addSubview:_buttonVideoSwitch];
    
    _buttonVideoSetting= [ControllButton buttonWithTitle:@""
                                                   image:[NSImage imageNamed:@"CB_UpArrow"]
                                                  target:_controllDelegate
                                                  action:@selector(autioSwitchEvent:)];
    [self addSubview:_buttonVideoSetting];
    
    
    _buttonAudioMuteAll = [ControllButton buttonWithTitle:LSTR(@"CB_ALL_AUDIO_DISABLE")
                                                image:[NSImage imageNamed:@"CB_AllAudioDisabled"]
                                               target:_controllDelegate
                                               action:@selector(autioSwitchEvent:)];
    [self addSubview:_buttonAudioMuteAll];
    
    _buttonAudioUnmuteAll = [ControllButton buttonWithTitle:LSTR(@"CB_ALL_AUDIO_ENABLE")
                                                      image:[NSImage imageNamed:@"CB_AllAudioEnabled"]
                                                     target:_controllDelegate
                                                     action:@selector(autioSwitchEvent:)];
    [self addSubview:_buttonAudioUnmuteAll];
    
    _buttonVolumSetting = [ControllButton buttonWithTitle:LSTR(@"CB_VOLUME")
                                                   image:[NSImage imageNamed:@"CB_Volume"]
                                                  target:_controllDelegate
                                                  action:@selector(autioSwitchEvent:)];
    [self addSubview:_buttonVolumSetting];
    
    _buttonScreenShareSwitch = [ControllButton buttonWithTitle:LSTR(@"CB_SCREEN_SHARE_DISABLE")
                                                        image:[NSImage imageNamed:@"CB_ScreenShareDisabled"]
                                                       target:_controllDelegate
                                                       action:@selector(autioSwitchEvent:)];
    [self addSubview:_buttonScreenShareSwitch];
    
    _buttonLayoutSwitch = [ControllButton buttonWithTitle:LSTR(@"CB_LAYOUT")
                                                        image:[NSImage imageNamed:@"CB_Layout"]
                                                       target:_controllDelegate
                                                       action:@selector(autioSwitchEvent:)];
    [self addSubview:_buttonLayoutSwitch];
    
    _buttonRemoteVideoSwitch = [ControllButton buttonWithTitle:LSTR(@"CB_REMOTE_VIDEO_ENABLE")
                                                        image:[NSImage imageNamed:@"CB_RemoteVideoDisabled"]
                                                       target:_controllDelegate
                                                       action:@selector(autioSwitchEvent:)];
    [self addSubview:_buttonRemoteVideoSwitch];
    
    _buttonScreenNoteSwitch = [ControllButton buttonWithTitle:LSTR(@"CB_SCREEN_NOTE")
                                                        image:[NSImage imageNamed:@"CB_ScreenNoteDisabled"]
                                                       target:_controllDelegate
                                                       action:@selector(autioSwitchEvent:)];
    [self addSubview:_buttonScreenNoteSwitch];
    
    
    _buttonLeaveClassRoom = [ControllButton buttonWithTitle:LSTR(@"CB_LEAVE_CLASS")
                                                      image:[NSImage imageNamed:@"CB_ScreenNoteDisabled"]
                                                     target:_controllDelegate
                                                     action:@selector(leaveClassRoom:)];
    [self addSubview:_buttonLeaveClassRoom];
    
    _imageViewRecordStatus = [[NSImageView alloc]initWithFrame:NSZeroRect];
    [_imageViewRecordStatus setImage:[NSImage imageNamed:@"CB_RecordStatusEnabled"]];
    [self addSubview:_imageViewRecordStatus];
    
    _vcLabelTipInfo = [[VcLabel alloc]initWithFrame:NSZeroRect];
    [_vcLabelTipInfo setTextString:@"asdf"];
    [_vcLabelTipInfo setFont:Fonts_PingFang_Medium(24)];
    [_vcLabelTipInfo setBackgroudColor:[NSColor clearColor]];
    [self addSubview:_vcLabelTipInfo];
    
//    _textFieldTipInfo = [[NSTextField alloc]initWithFrame:NSZeroRect];
//    //[_textFieldTipInfo setWantsLayer:YES];
//    //[[_textFieldTipInfo layer]setBackgroundColor:[NSColor clearColor].CGColor];
//    [_textFieldTipInfo setBackgroundColor:[NSColor clearColor]];
//    [_textFieldTipInfo setTextColor:[NSColor whiteColor]];
//    [_textFieldTipInfo setBordered:NO];
//    [_textFieldTipInfo setDrawsBackground:NO];
//    [_textFieldTipInfo setSelectable:NO];
//    [_textFieldTipInfo setEnabled:NO];
//    [_textFieldTipInfo setAlignment:NSTextAlignmentCenter];
//    _textFieldTipInfo.stringValue = @"asdf";
//    [self addSubview:_textFieldTipInfo];
}

-(void)layoutSubViews {
    [_buttonAudioSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(70);
    }];
    
    [_buttonAudioSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_buttonAudioSwitch.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(30);
    }];
    
    [_buttonVideoSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_buttonAudioSetting.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(70);
    }];
    
    [_buttonVideoSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_buttonVideoSwitch.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(30);
    }];
    
    [_buttonAudioMuteAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_buttonVideoSetting.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(70);
    }];
    
    [_buttonAudioUnmuteAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_buttonAudioMuteAll.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(70);
    }];
    
    // --
    
    [_buttonVolumSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(74);
    }];
    
    [_buttonScreenShareSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_buttonVolumSetting.mas_left);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(88);
    }];
    
    [_buttonLayoutSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_buttonScreenShareSwitch.mas_left);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(78);
    }];
    
    [_buttonRemoteVideoSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_buttonVolumSetting.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(88);
    }];
    
    [_buttonScreenNoteSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_buttonRemoteVideoSwitch.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(90);
    }];
    
    [_buttonLeaveClassRoom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(90);
    }];
    
    [_imageViewRecordStatus mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_buttonLeaveClassRoom.mas_left);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(7);
    }];
    
    [_vcLabelTipInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_imageViewRecordStatus.mas_left);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.height.mas_equalTo(70);
    }];
}

@end
