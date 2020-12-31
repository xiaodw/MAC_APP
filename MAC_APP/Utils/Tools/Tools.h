//
//  Tools.h
//  MAC_APP
//
//  Created by Jony on 2020/12/30.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject
+(Tools*)sharedInstance;
-(NSString*)getAppLanguage;
-(NSString*)getAppVersion;
-(NSString*)getAppType;
-(NSString*)getPlantform;
-(NSString*)getAppToken;

+ (void)alertMsg:(NSString*)msg title:(NSString*)title buttonOk:(NSString*)ok view:(NSView *)view buttonCancel:(NSString*)cancel onOk:(void(^)(void))okHandler onCancel:(void(^)(void))cancelHandler;

@end

NS_ASSUME_NONNULL_END
