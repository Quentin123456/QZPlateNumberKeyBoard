//
//  QZLicensePlateView.h
//  QZPlateNumberKeyBoard
//
//  Created by 臧乾坤 on 2018/1/4.
//  Copyright © 2018年 QuentinZang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QZLicensePlateView : UIView

//传递车牌号的block
@property (nonatomic, copy) void(^sendTextBlock)(NSString *);

+ (instancetype)initFrame:(CGRect)frame block:(void(^)(NSString *))block;

@end
