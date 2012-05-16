//
//  MCGameState.h
//  MCKlotski
//
//  Created by gtts on 12-4-26.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCModel.h"

@interface MCGameState : MCModel{
    int _currentGateID;
    int _moveCount;
    NSArray *_steps; // 记住所有走过的步骤，以方便后退和播放动画等功能
    NSArray *_frames;    
    
    BOOL _isFirstSetp;
}

@property (nonatomic, assign) int currentGateID;
@property (nonatomic, assign) int moveCount;
@property (nonatomic, retain) NSArray *steps;
@property (nonatomic, retain) NSArray *frames;
@property (nonatomic, assign) BOOL isFirstStep; // 是否第一步

- (BOOL)isResumeWithGateID:(int)gateID;

@end
