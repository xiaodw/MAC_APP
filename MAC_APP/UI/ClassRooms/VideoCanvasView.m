//
//  VideoCanvasView.m
//  MAC_APP
//
//  Created by Jony on 2021/1/6.
//

#import "VideoCanvasView.h"

@implementation VideoCanvasView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSRect rectFill = NSInsetRect(self.bounds, 3, 3);
    NSBezierPath * bezier = [NSBezierPath bezierPathWithRoundedRect:rectFill xRadius:6 yRadius:6];
    [[NSColor blackColor] setFill];
    [bezier fill];
}

-(instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self setWantsLayer:YES];
        [[self layer]setBackgroundColor:[NSColor blackColor].CGColor];
    }
    return self;
}

@end
