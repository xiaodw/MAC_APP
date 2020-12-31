//
//  AppData.m
//  MAC_APP
//
//  Created by Jony on 2020/12/30.
//

#import "AppData.h"

@implementation AppData

+(AppData*)sharedInstance {
    static AppData* shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[AppData alloc]init];
    });
    return shared;
}


@end
