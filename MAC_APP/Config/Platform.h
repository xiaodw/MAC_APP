//
//  Platform.h
//  MAC_APP
//
//  Created by Jony on 2020/12/28.
//

#ifndef Platform_h
#define Platform_h

#if defined(PRODUCT_TYPE_WE_EDUCATION)
#define APP_Business @"weedu"
#elif defined(PRODUCT_TYPE_DISCOVER_MELODY)
#define APP_Business @"discovermelody"
#elif defined(PRODUCT_TYPE_WE_DESIGN)
#define APP_Business @"wedesign"
#endif

#endif /* Platform_h */
