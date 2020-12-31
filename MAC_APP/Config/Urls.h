//
//  Urls.h
//  MAC_APP
//
//  Created by Jony on 2020/12/28.
//

#ifndef Urls_h
#define Urls_h

#define DEBUG_SERVER    // 注释该行切换到正式环境

#if defined(DEBUG_SERVER)
#define BASE_URL @"http://test.api.platform.discovermelody-app.com/"
#else
#define BASE_URL @"http://api.platform.discovermelody-app.com/"
#endif

#define URL_GET_APP_CONFIG              [BASE_URL stringByAppendingFormat:@"Init/getPCConfig"]
#define URL_GET_USER_INFO               [BASE_URL stringByAppendingFormat:@"User/loginCode"]
#define URL_GET_LESSON_INFO_STUDENT     [BASE_URL stringByAppendingFormat:@"Meeting/studentAccess"]
#define URL_GET_LESSON_INFO_TEACHER     [BASE_URL stringByAppendingFormat:@"Meeting/teacherAccess"]
#define URL_GET_LESSON_INFO_ASSISTANT   [BASE_URL stringByAppendingFormat:@"Meeting/assistantAccess"]
#define URL_ACCESS_CLASSROOM            [BASE_URL stringByAppendingFormat:@"Meeting/userAccess"]
#define URL_REPORT_AGORA_LOG            [BASE_URL stringByAppendingFormat:@"Log/agoraLog"]

#endif /* Urls_h */
