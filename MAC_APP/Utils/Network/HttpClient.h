//
//  HttpClient.h
//  MAC_APP
//
//  Created by Jony on 2020/12/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpClient : NSObject
+(HttpClient*)sharedInstance;
-(void)getWithUrl:(NSString*)url
       parameters:(NSMutableDictionary*)parameters
          success:(void (^)(id responseObject))success
          failure:(void (^)( NSError *error))failure;
-(void)postWithUrl:(NSString*)url
        parameters:(NSMutableDictionary*)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)( NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
