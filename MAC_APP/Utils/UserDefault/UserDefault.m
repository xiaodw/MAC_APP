//
//  LocalUserData.m
//  MAC_APP
//
//  Created by Jony on 2020/12/28.
//

#import "UserDefault.h"
#import "MacApp.h"

@implementation LocalUserData

+(void)setValue:(id)value forKey:(NSString*)key{
    NSUserDefaults* userDef = [NSUserDefaults standardUserDefaults];
    if ([value isKindOfClass:[NSArray class]])
    {
        if (@available(macOS 10.11, *)) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
            value = data;
        } else {
            // Fallback on earlier versions
            NSData *data = [NSArchiver archivedDataWithRootObject:value];
            value = data;
        }
    }
    [userDef setValue:value forKey:[NSString stringWithFormat:@"%@",key]];
    [userDef synchronize];
}

+(id)getValueWithKey:(NSString*)key{
    NSUserDefaults* userDef = [NSUserDefaults standardUserDefaults];
    id value = [userDef valueForKey:[NSString stringWithFormat:@"%@",key]];
    if(IS_STR_NIL(value) && [value isKindOfClass:[NSString class]]){
        value = @"";
    }
    return value;
}

+(NSMutableArray *)getMutArrayWithKey:(NSString *)key
{
    NSUserDefaults* userDef = [NSUserDefaults standardUserDefaults];
    NSData *value = [userDef valueForKey:[NSString stringWithFormat:@"%@",key]];
    
    if (nil == value) {
        return nil;
    }
    NSMutableArray *valueArray = [NSKeyedUnarchiver unarchiveObjectWithData:value];
    if (valueArray.count <= 0)
    {
        valueArray = [NSMutableArray array];
    }
    return valueArray;
}

@end
