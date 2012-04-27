//
//  MCGate.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCModel.h"

@interface MCGate : MCModel{
    int _gateID; // 关id
    int _passMin; // 最优步数 
    int _passMoveCount; // 完成所用步数
    BOOL _isLocked; // 是否锁定
    NSArray *_layout; // 布局
}
@property (nonatomic, assign) int gateID;
@property (nonatomic, assign) int passMin;
@property (nonatomic, assign) int passMoveCount;
@property (nonatomic, assign) BOOL isLocked;
@property (nonatomic, retain) NSArray *layout;

/**
 * 检测是否是新记录
 */
- (BOOL)checkNewRecord:(int)stepCount;

/*! 无效关*/
+ (MCGate *)invalidGateWithId:(int)gateId;

/*!判断gate是否无效*/
- (BOOL)isInvalidGate;


@end
