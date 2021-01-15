//
//  ControllButton.m
//  MAC_APP
//
//  Created by Jony on 2021/1/4.
//

#import "ControllButton.h"
#import "MacApp.h"

@interface ControllButton()
@property (nonatomic, assign) BOOL mouseIn;
@end

@implementation ControllButton

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        self.mouseIn = NO;
        [self updateTrackingAreas];
    }
    return self;
}

+ (instancetype)buttonWithTitle:(NSString *)title image:(NSImage *)image target:(id)target action:(SEL)action {
    id ctlButton = [super buttonWithTitle:title image:image target:target action:action];
    
    if (ctlButton) {
        [ctlButton setImagePosition:NSImageAbove];
        [ctlButton setImageHugsTitle:YES];
       // [[ctlButton layer]setBackgroundColor:[NSColor redColor].CGColor];
        [ctlButton setButtonType:NSMomentaryChangeButton];
        [ctlButton setBezelStyle:NSDisclosureBezelStyle];
        [ctlButton setBordered:NO];
        [ctlButton setFont:Fonts_PingFang_Medium(11)];
        //ctlButton.bordered = NO;
        //ctlButton.font = Fonts_PingFang_Medium(11);
        //_buttonAudioSwitch.customStatus = YES;
        //_buttonAudioSwitch.ignoresClick = NO;
        //[WLTools setButtonTitleColor:_buttonMute title:self.muteButtonTitle color:WLColorFromRGB(0xdddddd)];

        NSMutableParagraphStyle *pghStyle = [[NSMutableParagraphStyle alloc] init];
        pghStyle.alignment = NSTextAlignmentCenter;
        // 创建Attributes，设置颜色和段落样式
        NSDictionary *dicAtt = @{NSForegroundColorAttributeName: [NSColor whiteColor], NSParagraphStyleAttributeName: pghStyle};
        // 创建NSAttributedString赋值给NSButton的attributedTitle属性；必需从NSButton.attributedTitle创建，否则会有内存泄漏；
        // 用NSButton.attributedTitle属性创建一个NSMutableAttributedString对象
        
        NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithAttributedString:[ctlButton attributedTitle]];
        [attTitle replaceCharactersInRange:NSMakeRange(0, title.length) withString:title]; // 替换文字
        // 添加属性
        [attTitle addAttributes:dicAtt range:NSMakeRange(0, title.length)];
        // 赋值给NSButton.attributedTitle属性，不会再有内存泄漏
        [ctlButton setAttributedTitle:attTitle];
//        ctlButton.attributedTitle = attTitle;
    }
    
    return ctlButton;
}

- (void)updateTrackingAreas {
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                                options:NSTrackingMouseEnteredAndExited | NSTrackingActiveInKeyWindow
                                                                  owner:self
                                                               userInfo:nil];
    [self addTrackingArea:trackingArea];
}

- (void)mouseEntered:(NSEvent *)event {
    NSLog(@"BaseButton Entered");
    self.mouseIn = YES;
    //[WLVideoOperationManager shareManager].eventMouseClick = event;
    //更新图片
    [self updateBackgroundForOwner];
}

- (void)mouseExited:(NSEvent *)event {
    NSLog(@"BaseButton Exited");
    self.mouseIn = NO;
    //更新图片
    [self updateBackgroundForOwner];
}

- (void)updateBackgroundForOwner {
    self.wantsLayer = YES;
    if (self.mouseIn) {
        self.layer.backgroundColor = [NSColor blackColor].CGColor;
    } else {
        self.layer.backgroundColor = [NSColor clearColor].CGColor;
    }
}

@end
