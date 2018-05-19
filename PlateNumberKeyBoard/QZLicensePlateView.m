//
//  QZLicensePlateView.m
//  QZPlateNumberKeyBoard
//
//  Created by 臧乾坤 on 2018/1/4.
//  Copyright © 2018年 QuentinZang. All rights reserved.
//

#import "QZLicensePlateView.h"
#import "QZHeader.h"

#define INPUTHEIGHT 180 * DISTENCEH


@interface QZLicensePlateView ()

@property (strong, nonatomic) QZLicensePlateView *carNumberView;
@property (strong, nonatomic) UIButton *bottomBtn;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) NSArray *provinceArr;
@property (strong, nonatomic) NSArray *letterArr;
@property (strong, nonatomic)UIView *provinceView;
@property (strong, nonatomic) UIView *letterView;
@property (assign, nonatomic) int count;
@property (copy, nonatomic) NSString *provinceStr;
@property (copy, nonatomic) NSString *letterStr;
@property (copy, nonatomic) NSString *totalTextStr;

@end

@implementation QZLicensePlateView

+ (instancetype)initFrame:(CGRect)frame block:(void (^)(NSString *))block {
    
    QZLicensePlateView *carNumberView = [[QZLicensePlateView alloc] initWithFrame:frame];
    carNumberView.carNumberView = carNumberView;
    carNumberView.sendTextBlock = block;
    [carNumberView popUpView];
    return carNumberView;
    
}


- (void)popUpView {
    
    self.count = 0;
    self.provinceStr = @"";
    self.letterStr = @"";
    self.totalTextStr = @"";
    self.provinceArr = [NSArray array];
    self.provinceArr = @[@"京",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪",@"苏",
                         @"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",
                         @"琼",@"渝",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青",@"宁",
                         @"ABC",@"新",@"使",@"领",@"警",@"学",@"港",@"澳",@"◁"];
    
    self.letterArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",
                       @"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",
                       @"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",
                       @"返回",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"◁"];
    
    NSLog(@"provinceArr = 数量 %lu   letterArr = 数量 %lu",(unsigned long)_provinceArr.count,(unsigned long)_letterArr.count);
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, 0, screenWidth, screenHight);
    bottomBtn.backgroundColor = [UIColor clearColor];
    [bottomBtn addTarget:self action:@selector(bottomClick:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomBtn = bottomBtn;
    [self addSubview:bottomBtn];
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHight, screenWidth, INPUTHEIGHT)];
    bottomView.backgroundColor = [UIColor clearColor];
    self.bottomView = bottomView;
    [bottomBtn addSubview:bottomView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.transform = CGAffineTransformTranslate(self.bottomView.transform, 0, -INPUTHEIGHT);
    }];
    
    
#pragma mark ----- 省份简称
    UIView *provinceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, INPUTHEIGHT)];
    provinceView.backgroundColor = RGB_COLOR(220, 220, 220);
    self.provinceView = provinceView;
    [bottomView addSubview:provinceView];
    
    
    int provinceWidth = (screenWidth) / 10;
    int provinceHeight = INPUTHEIGHT / 4;
    int blankWidth = screenWidth - provinceWidth * 7 - 3;
    
    for (int i = 0; i < _provinceArr.count; i++) {
        UIButton *provinceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i < 10) {
            provinceBtn.frame = CGRectMake(1.5 + provinceWidth * i, 1.5, provinceWidth - 3, provinceHeight - 3);
            
        }else if (i >= 10 && i < 20) {
            provinceBtn.frame = CGRectMake(1.5 + provinceWidth * (i - 10), 1.5 + provinceHeight, provinceWidth - 3, provinceHeight - 3);
            
        }else if (i >= 20 && i < 30){
            provinceBtn.frame = CGRectMake(1.5 + provinceWidth * (i - 20), 1.5 + provinceHeight * 2, provinceWidth - 3, provinceHeight - 3);
            
        }else if (i == 30){
            provinceBtn.frame = CGRectMake(1.5, 1.5 + provinceHeight * 3, blankWidth / 2, provinceHeight - 3);
        }else if(i == 38){
            provinceBtn.frame = CGRectMake(screenWidth - blankWidth / 2, 1.5 + provinceHeight * 3, blankWidth / 2 - 1.5, provinceHeight - 3);
        }else{
            provinceBtn.frame = CGRectMake(4.5 + blankWidth / 2 + provinceWidth * (i - 31), 1.5 + provinceHeight * 3, provinceWidth - 3, provinceHeight - 3);
        }
        
        provinceBtn.backgroundColor = [UIColor whiteColor];
        [provinceBtn setTitle:_provinceArr[i] forState:0];
        [provinceBtn setTitleColor:[UIColor blackColor] forState:0];
        provinceBtn.layer.cornerRadius = 3;
        provinceBtn.tag = 1000 + i;
        [provinceBtn addTarget:self action:@selector(provinceClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:provinceBtn];
    }
    
    
#pragma mark ----- 首字母大写
    UIView *letterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, INPUTHEIGHT)];
    letterView.backgroundColor = RGB_COLOR(220, 220, 220);
    letterView.hidden = YES;
    self.letterView = letterView;
    [bottomView addSubview:letterView];
    
    
    for (int i = 0; i < _letterArr.count; i++) {
        UIButton *letterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i < 10) {
            
            letterBtn.frame = CGRectMake(1.5 + provinceWidth * i, 1.5, provinceWidth - 3, provinceHeight - 3);
            
        } else if (i >= 10 && i < 20) {
            
            letterBtn.frame = CGRectMake(1.5 + provinceWidth * (i - 10), 1.5 + provinceHeight, provinceWidth - 3, provinceHeight - 3);
            
        } else if (i >= 20 && i < 29) {
            
            letterBtn.frame = CGRectMake(1.5 + provinceWidth / 2 + provinceWidth * (i - 20), 1.5 + provinceHeight * 2, provinceWidth - 3, provinceHeight - 3);
            
        } else if (i == 29) {
            
            letterBtn.frame = CGRectMake(1.5, 1.5 + provinceHeight * 3, blankWidth / 2, provinceHeight - 3);
            
            
        } else if(i == 37) {
            
            letterBtn.frame = CGRectMake(screenWidth - blankWidth / 2, 1.5 + provinceHeight * 3, blankWidth / 2 - 1.5, provinceHeight - 3);
            
        } else {
            
            letterBtn.frame = CGRectMake(4.5 + blankWidth / 2 + provinceWidth * (i - 30), 1.5 + provinceHeight * 3, provinceWidth - 3, provinceHeight - 3);
            
        }
        
        letterBtn.backgroundColor = [UIColor whiteColor];
        [letterBtn setTitle:_letterArr[i] forState:0];
        [letterBtn setTitleColor:[UIColor blackColor] forState:0];
        letterBtn.layer.cornerRadius = 3;
        letterBtn.tag = 1000 + i;
        [letterBtn addTarget:self action:@selector(letterClick:) forControlEvents:UIControlEventTouchUpInside];
        [letterView addSubview:letterBtn];
    }
    
}


- (void)bottomClick:(UIButton *)sender {
    
    [self putAway];
    
}


//  省份简称
- (void)provinceClick:(UIButton *)sender {
    
    int index = (int)sender.tag - 1000;
    if (index == 30) {//    切换英文输入
        self.provinceView.hidden = YES;
        self.letterView.hidden = NO;
        
    } else if (index == 38) {//   删除
        
        [self deleteText];
        
    } else {
        
        self.provinceView.hidden = YES;
        self.letterView.hidden = NO;
        self.provinceStr = [NSString stringWithFormat:@"%@",_provinceArr[index]];
        NSString *textStr = [NSString stringWithFormat:@"%@",_provinceStr];
        if (self.sendTextBlock) {
            self.sendTextBlock(textStr);
            _totalTextStr = textStr;
        }
        //        NSLog(@"省份简称：    %@",_provinceArr[index]);
    }
    
}


//  车牌首字母
- (void)letterClick:(UIButton *)sender {
    
    int index = (int)sender.tag - 1000;
    //    NSLog(@"车牌首字母：    %d",index);
    
    if (index == 29) {//    切换英文输入
        
        self.provinceView.hidden = NO;
        self.letterView.hidden = YES;
        
    } else if (index == 37) {//   删除
        
        [self deleteText];
        
    } else {
        
        self.letterStr = [NSString stringWithFormat:@"%@%@",_letterStr,_letterArr[index]];
        NSString *textStr = [NSString stringWithFormat:@"%@%@",_provinceStr,_letterStr];
        if (self.sendTextBlock) {
            self.sendTextBlock(textStr);
            _totalTextStr = textStr;
        }
        if (textStr.length == 7) {
            [self putAway];
        }
        //        NSLog(@"车牌信息    %@",textStr);
    }
    
}


//  隐藏键盘
- (void)putAway {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.transform = CGAffineTransformTranslate(self.bottomView.transform, 0, 200 * DISTENCEH);
    } completion:^(BOOL finished) {
        self.alpha = 0;
    }];
    
}


//  删除数据
- (void)deleteText {
    
    //    NSLog(@"删除前的数据  %@",_totalTextStr);
    if (_totalTextStr.length > 0) {
        
        NSString *textStr = [_totalTextStr substringToIndex:([_totalTextStr length] - 1)];
        
        if (self.sendTextBlock) {
            self.sendTextBlock(textStr);
            _totalTextStr = textStr;
        }
        
        if (textStr.length == 0) {
            self.provinceView.hidden = NO;
            self.letterView.hidden = YES;
        }
        //        NSLog(@"删除前后的字符串  %@",textStr);
    } else {
        
        self.count = 0;
        self.provinceStr = @"";
        self.letterStr = @"";
        self.totalTextStr = @"";
        
    }
    
}


@end
