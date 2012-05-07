//
//  MCGameSceneMenuView.h
//  MCKlotski
//
//  Created by gtts on 5/6/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCView.h"

@class MCNumberView;

@protocol GameSceneMenuDelegate 

  @required
// 返回按钮事件
- (void)undoAction:(id)sender;
// 重置按钮事件
- (void)resetAction:(id)sender;
// 刷新按钮
@end

@interface MCGameSceneMenuView : MCView{
  @private
    id<GameSceneMenuDelegate> _delegate;
    UIButton *_btnUndo;
    UIButton *_btnReset;
    UILabel *_lblMoveCount;
    UILabel *_lblMinValue; // 最小移动步数的显示label
    UIImageView *_levelImageView;
    MCNumberView *_levelNumberView;
    
    NSString *_moveCountText;
    NSString *_minValueText;
    int _levelValue;
    UIImage *_levelImage;
    
}

@property (nonatomic, retain) UIButton *btnUndo;
@property (nonatomic, retain) UIButton *btnReset;
@property (nonatomic, assign) id<GameSceneMenuDelegate>delegate;
@property (nonatomic, copy) NSString *moveCountText;
@property (nonatomic, copy) NSString *minValueText;
@property (nonatomic, assign) int levelValue;
@property (nonatomic, retain) UIImage *levelImage;

@end
