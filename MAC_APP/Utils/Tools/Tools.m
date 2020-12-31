//
//  Tools.m
//  MAC_APP
//
//  Created by Jony on 2020/12/30.
//

#import "Tools.h"
#import "MacApp.h"

@implementation Tools


+(Tools*)sharedInstance {
    static Tools* shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[Tools alloc]init];
    });
    return shared;
}

-(NSString*)getAppLanguage {
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSString *string = [[userDefault valueForKey:@"AppleLanguages"]objectAtIndex:0];
    if ([string containsString:@"zh-Hans"]) {
        return @"cn";
    }
    return @"en";
}

-(NSString*)getAppVersion {
    return [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

-(NSString*)getAppType {
    return @"mac";
}

-(NSString*)getPlantform {
#if defined(PRODUCT_TYPE_WE_EDUCATION)
    return @"weedu";
#elif defined(PRODUCT_TYPE_DISCOVER_MELODY)
    return @"discovermelody";
#elif defined(PRODUCT_TYPE_WE_DESIGN)
    return @"wedesign";
#endif
    return @"";
}

-(NSString*)getAppToken {
    NSString* token = [LocalUserData getValueWithKey:@"token"];
    return IS_STR_NIL(token) ? @"" : token;
}

+ (void)alertMsg:(NSString*)msg title:(NSString*)title buttonOk:(NSString*)ok view:(NSView *)view buttonCancel:(NSString*)cancel onOk:(void(^)(void))okHandler onCancel:(void(^)(void))cancelHandler {
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:ok];
    [alert addButtonWithTitle:IS_STR_NIL(cancel)?nil:cancel];
    [alert setMessageText:title];
    [alert setInformativeText:msg];
    alert.icon = nil;//[NSImage imageNamed:@"redClock"];
    [alert.window setStyleMask:NSWindowStyleMaskBorderless];
    [alert beginSheetModalForWindow:view.window completionHandler:^(NSModalResponse returnCode) {
        if (1000 == returnCode) {
            okHandler();
        } else {
            cancelHandler();
        }
    }];
}

@end
