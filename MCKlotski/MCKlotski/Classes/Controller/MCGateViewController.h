//
//  MCGateViewController.h
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCViewController.h"
#import "MCGameSceneMenuView.h"
#import "MCResetAlertView.h"
#import "MCGameSceneView.h"
#import "MCPassAllLevelAlertView.h"
#import "MCNewBestMoveAlertView.h"

@class MCPassLevelAlertView;

typedef enum BlockViewMoveFlag{
    
    kBlockViewMoveInvalid = 0,
    kBlockViewMoveNormal, // 正常移动
    kBlockViewMoveUndo, // 返回
}kBlockViewMoveFlag;


@interface MCGateViewController : MCViewController<
  GameSceneMenuDelegate,
  MCAlertDelegate,
  GameSceneViewDelegate
> {
  @protected
    kBlockViewMoveFlag _moveFlag;
    int _theGateID;
  
  @private
    NSArray *_effects; // 音效
    MCGameSceneView *_gameSceneView;
    MCGameSceneMenuView *_gmaeSceneMenuView;
    NSArray *_steps;
    
    MCAlertView *_currentAlertView;  // 当前弹出dialog
    MCResetAlertView *_resetAlertView; // 点击重置按钮之后弹出的dialog
    MCPassLevelAlertView *_passLevelAlertView; // 过关之后的Dialog
    MCPassAllLevelAlertView *_passAllLevelAlertView; // 通过所有关之后的dialog
    MCNewBestMoveAlertView *_newBestMoveAlertView; // 当移动总数小于等于最小移动值时，显示的dialog
    
    // 移动总数
    int _moveCount;
    
    kTagControl _alertButtonTag;
    
}

@property (nonatomic, assign) int theGateID;
@property (nonatomic, retain) MCGameSceneView *gameSceneView;
@property (nonatomic, retain) MCGameSceneMenuView *gameSceneMenuView;
@property (nonatomic, retain) NSArray *steps;
@property (nonatomic, retain) MCAlertView *currentAlertView;
@property (nonatomic, assign) int moveCount;
@property (nonatomic, retain) MCResetAlertView *resetAlertView;

- (id)initWithGateID:(int)gateID;

// 刷新按钮，设置按钮是否可点击
- (void)refreshButtons;

- (void)resumeGame;
- (void)refreshSubViews;

- (void)gotoNextLevel:(int)gateID;

// 重置关
- (void)resetGateWithGateID:(int)gateID;
- (void)resetNextGateWithGateID:(int)gateID;

- (void)showResetAlertView;

// 在level完成的情况下执行
- (void)levleDidPass;

@end
