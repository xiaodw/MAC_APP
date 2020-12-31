//
//  LessonCodeField.m
//  DiscoverMelody
//
//  Created by xiaodw on 2018/1/31.
//  Copyright © 2018年 Beijing Discover Melody co., ltd. All rights reserved.
//

#import "LessonCodeField.h"
#import <Masonry.h>
#import "Fonts.h"
#import "Colors.h"

@implementation LessonCodeField

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
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
    self.layer.cornerRadius = 4.f;
    self.layer.masksToBounds = YES;
    [self.layer setBackgroundColor:[NSColor whiteColor].CGColor];

    self.textFieldCode = [[NSTextField alloc]initWithFrame:CGRectZero];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"LOGIN_VIEW_TEXT_FIELD_CODE_PLACEHOLDER", nil) attributes:
                                      @{NSForegroundColorAttributeName:Colors_FromRGB(0xcccccc),
                                        NSFontAttributeName:Fonts_PingFang_Light(20),
                                            NSParagraphStyleAttributeName:paragraphStyle
                                        }];//[NSColor colorWithRed:204/255.f green:204/255.f blue:204/255.f alpha:1.f]
    [self.textFieldCode setPlaceholderAttributedString:attrString];
    //[self.textFieldCode setTextColor:[NSColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.f]];
    [self.textFieldCode setTextColor:Colors_FromRGB(0x333333)];
    [self.textFieldCode setStringValue:@""]; // bf3a0d4d7d4c566b
    [self.textFieldCode setAlignment:NSTextAlignmentCenter];
    [self.textFieldCode setFont:Fonts_PingFang_Light(20)];
    [self.textFieldCode setBordered:NO];
    [[self.textFieldCode cell]setBordered:NO];
    [[self.textFieldCode cell]setLineBreakMode:NSLineBreakByTruncatingTail];
    self.textFieldCode.backgroundColor = [NSColor whiteColor];
    [self.textFieldCode setFocusRingType:NSFocusRingTypeNone];
    self.textFieldCode.refusesFirstResponder = YES;
    [self addSubview:self.textFieldCode];
}

-(void)layoutSubViews {
    [self.textFieldCode mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.mas_equalTo(self);
//        make.top.mas_equalTo(self.mas_centerY).with.offset(-19);
//        make.left.mas_equalTo(self).with.offset(24);
//        make.right.mas_equalTo(self).with.offset(-24);
//        make.bottom.mas_equalTo(self.mas_centerY).with.offset(19);
        make.top.mas_equalTo(self).with.offset(5);
        make.left.mas_equalTo(self).with.offset(14);
        make.right.mas_equalTo(self).with.offset(-14);
        make.bottom.mas_equalTo(self).with.offset(-5);
    }];
}


@end
