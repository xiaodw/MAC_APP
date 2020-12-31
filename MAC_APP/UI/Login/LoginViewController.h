//
//  LoginViewController.h
//  MAC_APP
//
//  Created by Jony on 2020/12/30.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

enum LOGIN_STATUS {
    LOGIN_STATUS_NOT_READY = 0,
    LOGIN_STATUS_WAIT_LESSON_CODE,
    LOGIN_STATUS_READY,
    LOGIN_STATUS_DOING,
    LOGIN_STATUS_DONE
};

@protocol LoginDelegate <NSObject>
- (void)joinClass:(NSString *)joinCode;
@end

@interface LoginViewController : NSViewController
-(void)setLoginStatus:(enum LOGIN_STATUS)status;
@end

NS_ASSUME_NONNULL_END
