//
//  Models.m
//  MAC_APP
//
//  Created by Jony on 2020/12/31.
//

#import "Models.h"

@implementation AppUpdate

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"verNew" : @"newVer"
    };
}

@end

@implementation AppConfig

@end

@implementation AVConfig

@end

@implementation LoginResult

@end

@implementation MeetingConfig

@end

