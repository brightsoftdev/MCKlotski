//
//  MCNumberView.h
//  MCKlotski
//
//  Created by gtts on 5/3/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCConfig.h"

@interface MCNumberView : UIView{
    NumberRBGType _numberType; // 不同的类型对应不同的颜色
    NSArray *_numberImages; // 存放数字图片View
    int _value; // 要显示的数据
    int _digit; // 数值的位数， 位了美观，高位需要补零
}

@property (nonatomic, assign) NumberRBGType numberType;
@property (nonatomic, retain) NSArray *numberImages;
@property (nonatomic, assign) int value;

@end
