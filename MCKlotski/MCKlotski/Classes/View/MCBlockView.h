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

@class MCBlock;
@protocol BlockGestureDelegate;

/**
 * 触摸 块的手势
 */
typedef enum TOUCH_BLOCK_GESTURE{
    GESTURE_INVALID = 0,
    GESTURE_TO_LEFT,
    GESTURE_TO_RIGHT,
    GESTURE_TO_UP,
    GESTURE_TO_DOWN,
}BLOCK_GESTURE;


@interface MCBlockView : UIView{
    id<BlockGestureDelegate> _delegate;
    BLOCK_GESTURE _currentGesture;
    MCBlock *_block;
    CGRect _oldFrame;
    
    CGPoint _touchBeganPoint; // 触摸开始点
    CGPoint _touchMovePoint; // 触摸移动的点
    CGPoint _touchEndPoint; // 触摸结束点
}

@property (nonatomic, assign)id<BlockGestureDelegate> delegate;
@property (nonatomic, assign)BLOCK_GESTURE currentGesture;
// 被触摸的blockView的MCBlock实例
@property (nonatomic, retain)MCBlock *block;
// 为移动之前块的frame
@property (nonatomic, assign)CGRect oldFrame;
// 快速取得blockID
@property (nonatomic, readonly) int blockID;

/**
 * 初始化方法
 */
- (id) initWithBlock:(MCBlock *)block;

@end



/**
 * 触摸手势协议
 */
@protocol BlockGestureDelegate

@required
// 将要移动
- (void)blockShouldMoveWith:(MCBlockView *)blockView andGesture:(BLOCK_GESTURE)blockGesture;
// 移动开始
- (void)blockBeganMoveWith:(MCBlockView *)blockView andGesture:(BLOCK_GESTURE)blockGesture;
// 移动结束
- (void)blockEndMoveWith:(MCBlockView *)blockView andGesture:(BLOCK_GESTURE)blockGesture;
// 块的Frame改变
- (void)blockFrameDidChangeWith:(MCBlockView *)blockView andGesture:(BLOCK_GESTURE)blockGesture;

@end
