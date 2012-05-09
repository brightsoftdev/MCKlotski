//
//  MCBlockView.h
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义每一格的宽度
#define BLOCKVIEWWIDTH 65
#define kBoxWidth (4 * BLOCKVIEWWIDTH)
#define kBoxHeight (5 * BLOCKVIEWWIDTH)
#define kBoxX 0.0
#define kBoxY 0.0

@class MCBlock;
@protocol BlockGestureDelegate;

/**
 * 触摸 块的手势
 */
typedef enum TOUCH_BLOCK_GESTURE{
    kGestureInvalid = 0,
    kGestureToLeft,
    kGestureToRight,
    kGestureToUp,
    kGestureToDown,
}kBlockGesture;


@interface MCBlockView : UIView{
    id<BlockGestureDelegate> _delegate;
    kBlockGesture _currentGesture;
    MCBlock *_block;
    CGRect _oldFrame;
    
    CGPoint _touchBeganPoint; // 触摸开始点
    CGPoint _touchMovePoint; // 触摸移动的点
    CGPoint _touchEndPoint; // 触摸结束点
}

@property (nonatomic, assign)id<BlockGestureDelegate> delegate;
@property (nonatomic, assign)kBlockGesture currentGesture;
// 被触摸的blockView的MCBlock实例
@property (nonatomic, retain)MCBlock *block;
// 为移动之前块的frame
@property (nonatomic, assign)CGRect oldFrame;
// 快速取得blockID
@property (nonatomic, readonly) int blockID;

/**
 * 初始化方法
 */
- (id)initWithBlock:(MCBlock *)block;

/**
 * 获取blockView的frame
 */
+ (CGRect)frameWithBlockType:(int)blockType positionX:(int)x positionY:(int)y;

// 通过frame移动块
- (void)moveBlockViewWithFrame:(CGRect)newFrame;

// 判断是否在边界
- (BOOL)isVergeBoundary;

@end



/**
 * 触摸手势协议
 */
@protocol BlockGestureDelegate

  @required
// 将要移动,是否准备好
- (BOOL)blockShouldMoveWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture;
// 移动开始
- (void)blockBeganMoveWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture;
// 移动结束
- (void)blockEndMoveWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture;
// 块的Frame改变
- (void)blockFrameDidChangeWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture;

@end
