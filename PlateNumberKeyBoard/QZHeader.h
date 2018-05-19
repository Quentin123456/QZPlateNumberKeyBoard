//
//  QZHeader.h
//  QZPlateNumberKeyBoard
//
//  Created by 臧乾坤 on 2018/1/4.
//  Copyright © 2018年 QuentinZang. All rights reserved.
//

#ifndef QZHeader_h
#define QZHeader_h

//屏幕的宽度
#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHight  [UIScreen mainScreen].bounds.size.height

#define DISTENCEW (([UIScreen mainScreen].bounds.size.width) / 320)
#define DISTENCEH (([UIScreen mainScreen].bounds.size.height) / 568)

#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]


#endif /* QZHeader_h */
