//
//  MCGameSceneMenuView.h
//  MCKlotski
//
//  Created by gtts on 5/6/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCView.h"

@protocol GameSceneMenuDelegate 

  @required
// 返回按钮事件
- (void)undoAction:(id)sender;
// 重置按钮事件
- (void)resetAction:(id)sender;
@end

@interface MCGameSceneMenuView : MCView{
  @private
    id<GameSceneMenuDelegate> _delegate;
    UIButton *_btnUndo;
    UIButton *_btnReset;
}

@property (nonatomic, assign) id<GameSceneMenuDelegate>delegate;

@end
