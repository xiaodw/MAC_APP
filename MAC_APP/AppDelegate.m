//
//  AppDelegate.m
//  MAC_APP
//
//  Created by Jony on 2020/12/28.
//

#import "AppDelegate.h"
#import "Macros.h"
#import "LoginViewController.h"
#import "SmallClassViewController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSApplication* app =[NSApplication sharedApplication];
    _window = [app keyWindow];
    if (IS_OBJ_NIL(_window)) {
        _window = [app keyWindow];
    }
    
#if defined(PRODUCT_TYPE_WE_EDUCATION)
    [_window setTitle:LSTR(@"WINDOW_TITLE_EDU")];
#elif defined(PRODUCT_TYPE_DISCOVER_MELODY)
    [_window setTitle:LSTR(@"WINDOW_TITLE_DISCOVER_MELODY")];
#elif defined(PRODUCT_TYPE_WE_DESIGN)
    [_window setTitle:LSTR(@"WINDOW_TITLE_DESIGN")];
#endif
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


-(void)showSmallClassView {
//    NSLog(@"showSmallClassView");
//    SmallClassWindowController* smallClass = [[SmallClassWindowController alloc]init];
//    [smallClass.window orderFront:nil];
//    [_window orderOut:nil];
//    _window = smallClass.window;
    
    //[_window setContentViewController:[[SmallClassViewController alloc]initCustom] ];
    
//    NSWindow* newWindow = [[NSWindow alloc]init];
//    newWindow.title = @"新窗口";
//    [newWindow setFrame:_window.frame display:YES];
//
//    NSWindow* oldWindow = _window;
//
//    _window = newWindow;
//    [_window makeKeyAndOrderFront:nil];
//
//    [oldWindow orderOut:nil];
    
    //NSView* newView = [[NSView alloc]initWithFrame:_window.frame];
    //_window.contentViewController.view = newView;
    
    
    SmallClassViewController* smallClassVC = [[SmallClassViewController alloc]init];
    [smallClassVC.view setFrame:_window.frame];
    _window.contentViewController = smallClassVC;
}

@end
