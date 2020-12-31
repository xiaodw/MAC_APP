//
//  HttpClient.m
//  MAC_APP
//
//  Created by Jony on 2020/12/28.
//

#import "HttpClient.h"
#import <AFNetworking.h>
#import "MacApp.h"

@interface HttpClient()
@property (copy, nonatomic)NSDictionary* commonFields;
@property (strong, nonatomic)AFHTTPSessionManager* manager;
@end

@implementation HttpClient

+(HttpClient*)sharedInstance {
    static HttpClient* shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[HttpClient alloc]init];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.securityPolicy.allowInvalidCertificates = YES;
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 15;
    }
    return self;
}


-(NSDictionary*)getCommonFields {
    if (IS_OBJ_NIL(_commonFields)) {
        NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
        [params setObject:[[Tools sharedInstance] getAppLanguage] forKey:@"lan"];
        [params setObject:[[Tools sharedInstance] getPlantform] forKey:@"business"];
        [params setObject:[[Tools sharedInstance] getAppType] forKey:@"app"];
        [params setObject:[[Tools sharedInstance] getAppToken] forKey:@"token"];
        [params setObject:[[Tools sharedInstance] getAppVersion] forKey:@"ver"];
        _commonFields = params;
    }
    return _commonFields;
}

-(NSDictionary*)roundParams:(NSDictionary*)params {
    if (IS_OBJ_NIL(params)) {
        return [self getCommonFields];
    }

    NSMutableDictionary* roundParams = [[NSMutableDictionary alloc]initWithDictionary:[self getCommonFields]];
    [roundParams addEntriesFromDictionary:params];
    return  roundParams;
}

-(void)getWithUrl:(NSString*)url
       parameters:(NSMutableDictionary*)parameters
          success:(void (^)(id responseObject))success
          failure:(void (^)( NSError *error))failure {
    [_manager GET:url parameters:[self roundParams:parameters] headers:NULL progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id resp = responseObject;
        if (![resp isKindOfClass:[NSDictionary class]]) {
            resp = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        }
        if (0 != [[resp objectForKey:@"code"]intValue]) {
            failure([NSError errorWithDomain:NSURLErrorDomain code:200 userInfo:@{NSLocalizedDescriptionKey:[resp objectForKey:@"msg"]}]);
        } else {
            success([resp objectForKey:@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

-(void)postWithUrl:(NSString*)url
        parameters:(NSMutableDictionary*)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)( NSError *error))failure {
    
    LOG(url);
    LOG([self roundParams:parameters]);
    
    [_manager POST:url parameters:[self roundParams:parameters] headers:NULL progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id resp = responseObject;
        if (![resp isKindOfClass:[NSDictionary class]]) {
            resp = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        }
        if (0 != [[resp objectForKey:@"code"]intValue]) {
            failure([NSError errorWithDomain:NSURLErrorDomain code:200 userInfo:@{NSLocalizedDescriptionKey:[resp objectForKey:@"msg"]}]);
        } else {
            success([resp objectForKey:@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [Toast showToastAndSetTime:error.localizedDescription atTop:YES timerInterval:3];
    }];
}

@end
