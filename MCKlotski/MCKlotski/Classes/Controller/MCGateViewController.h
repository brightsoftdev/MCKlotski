//
//  MCGateViewController.h
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCViewController.h"
#import "MCBlockView.h"

@class MCGate;

typedef enum BlockViewMoveFlag{
    
    kBlockViewMoveInvalid = 0,
    kBlockViewMoveNormal, // 正常移动
    kBlockViewMoveUndo, // 返回
}kBlockViewMoveFlag;


@interface MCGateViewController : MCViewController<
  BlockGestureDelegate,
  UIAlertViewDelegate
> {
  @protected
    kBlockViewMoveFlag _moveFlag;
  
  @private
    int _theGateID;
    UIView *_theBoxView;
    NSArray *_blockViews;
    MCGate *_theGate;
    
    UIImageView *_starView;
}

@property (nonatomic, assign) int theGateID;
@property (nonatomic, retain) NSArray *blockViews;
@property (nonatomic, retain) MCGate *theGate;
@property (nonatomic, retain) UIImageView *starView;

- (id)initWithGateID:(int)gateID;


@end
