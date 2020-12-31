//
//  Macros.h
//  MAC_APP
//
//  Created by Jony on 2020/12/28.
//

#ifndef Macros_h
#define Macros_h

#define LSTR(key) NSLocalizedString(key, nil)
#define IS_OBJ_NIL(obj) (obj==nil || [obj isKindOfClass:[NSNull class]])
#define IS_STR_NIL(key) (([@"<null>" isEqualToString:(key)] || [@"" isEqualToString:(key)] || key == nil || [key isKindOfClass:[NSNull class]]) ? 1: 0)
#define APP_DELEGATE ((AppDelegate*)[[NSApplication sharedApplication] delegate])


#define LOG(msg) (NSLog(@"--> %@", msg));
#define LOG2(m1,m2) (NSLog(@"--> %@ %@", m1, m2));
#define LOG3(m1,m2,m3) (NSLog(@"--> %@ %@ %@", m1, m2, m3));
#define LOG4(m1,m2,m3,m4) (NSLog(@"--> %@ %@ %@ %@", m1, m2, m3, m4));


#define DeLog(format, ...) do {                                                                          \
    printf("<%s : %d> %s\n",                                           \
    [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
    __LINE__, __func__);                                                        \
    NSLog(format, ##__VA_ARGS__);                                           \
} while (0)

#endif /* Macros_h */
