//
//  Colors.h
//  MAC_APP
//
//  Created by Jony on 2020/12/28.
//

#ifndef Colors_h
#define Colors_h

#define Colors_FromRGB(rgbValue) [NSColor colorWithRed:((((rgbValue) & 0xFF0000) >> 16))/255.f \
green:((((rgbValue) & 0xFF00) >> 8))/255.f \
blue:(((rgbValue) & 0xFF))/255.f alpha:1.0]

#define Color_FromRGB_Alpha(rgbValue, a) [NSColor colorWithRed:((((rgbValue) & 0xFF0000) >> 16))/255.f \
green:((((rgbValue) & 0xFF00) >> 8))/255.f \
blue:(((rgbValue) & 0xFF))/255.f alpha:a]

#endif /* Colors_h */
