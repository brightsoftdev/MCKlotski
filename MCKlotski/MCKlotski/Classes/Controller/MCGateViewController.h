//
//  MCGateViewController.h
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCViewController.h"
#import "MCGameSceneMenuView.h"

@class MCGameSceneView;

typedef enum BlockViewMoveFlag{
    
    kBlockViewMoveInvalid = 0,
    kBlockViewMoveNormal, // 正常移动
    kBlockViewMoveUndo, // 返回
}kBlockViewMoveFlag;


@interface MCGateViewController : MCViewController<
  GameSceneMenuDelegate,
  UIAlertViewDelegate
> {
  @protected
    kBlockViewMoveFlag _moveFlag;
  
  @private
    int _theGateID;
    MCGameSceneView *_gameSceneView;
    MCGameSceneMenuView *_gmaeSceneMenuView;
    NSArray *_steps;
}

@property (nonatomic, assign) int theGateID;
@property (nonatomic, retain) MCGameSceneView *gameSceneView;
@property (nonatomic, retain) MCGameSceneMenuView *gameSceneMenuView;
@property (nonatomic, retain) NSArray *steps;

- (id)initWithGateID:(int)gateID;


@end
