//
//  MCGameSceneView.h
//  MCKlotski
//
//  Created by gtts on 5/6/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCView.h"
#import "MCBlockView.h"

@class MCGate;

@protocol GameSceneViewDelegate 

- (void)movingBlockView:(BOOL)isMove;

@end

@interface MCGameSceneView : MCView<BlockGestureDelegate> {
    UIView *_theBoxView;
  @private
    id<GameSceneViewDelegate> _delegate;
    NSArray *_blockViews;
    MCGate *_theGate;
    
    UIImageView *_starView;
    
    BOOL _isMoveBlockView;
    
}

@property (nonatomic, assign) id<GameSceneViewDelegate> delegate;
@property (nonatomic, retain) NSArray *blockViews;
@property (nonatomic, retain) MCGate *theGate;
@property (nonatomic, retain) UIImageView *starView;
@property (nonatomic, assign) BOOL isMoveBlockView;

/**
 * 通过blockID获取MCBlockView
 */
- (MCBlockView *)blockViewWithBlockID:(int)blockID;

// 显示star
- (void)showStar:(MCGate *)gate;

@end
