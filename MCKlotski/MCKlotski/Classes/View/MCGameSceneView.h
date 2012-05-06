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

@interface MCGameSceneView : MCView<BlockGestureDelegate> {
    UIView *_theBoxView;
  @private
    NSArray *_blockViews;
    MCGate *_theGate;
    
    UIImageView *_starView;
    
}

@property (nonatomic, retain) NSArray *blockViews;
@property (nonatomic, retain) MCGate *theGate;
@property (nonatomic, retain) UIImageView *starView;

/**
 * 通过blockID获取MCBlockView
 */
- (MCBlockView *)blockViewWithBlockID:(int)blockID;

@end
