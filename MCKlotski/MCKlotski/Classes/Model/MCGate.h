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
    NSArray *_layout; 
}
@property (nonatomic, assign) int gateID;
@property (nonatomic, assign) int passMin;
@property (nonatomic, assign) int passMoveCount;
@property (nonatomic, assign) BOOL isLocked;
/**
 * 游戏布局，类似“[4,2,0,3,0,1,3,0,2,3,2,2,3,0,3,1,2,3,1,3,3,1,0,4,1,1,4,1,2,4,1,3,4]”的数组
 */
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
