//
//  LocalUserData.h
//  MAC_APP
//
//  Created by Jony on 2020/12/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalUserData : NSObject
+(void)setValue:(id)value forKey:(NSString*)key;
+(id)getValueWithKey:(NSString*)key;
+(NSMutableArray *) getMutArrayWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
