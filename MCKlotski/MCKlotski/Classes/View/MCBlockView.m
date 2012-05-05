//
//  MCBlockView.m
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCBlockView.h"
#import "MCBlock.h"

@interface MCBlockView (Privates)

// 初始化私有字段和属性
- (void)initAttributes;

// 根据block确定Frame
- (CGRect)frameWithBlock:(MCBlock *)block;

// 移动BlockView
- (void)moveBlockView;
// 在touchend时校正blockView的Frame
- (void)reviseBlockViewFrame;

// 通过touchBeganPoint和touchMovePoint判定手势类型
- (kBlockGesture)gestureWithBegin:(CGPoint)beginPoint andEnd:(CGPoint)endPoint;

// BlockGestureDelegate Methods
- (BOOL)notifyDelegateShoudMove;
- (void)notifyDelegateBeganMove;
- (void)notifyDelegateEndedMove;
- (void)notifyDelegateFrameDidChange;

// 手势十是否改变了
- (BOOL)gestureIsChangedWith:(kBlockGesture)gesture;

// 触摸移动的距离
- (float)touchMoveDistance;
// 根据移动的距离移动block
- (void)moveBlockViewWithDistance:(float)distance;

// 重新设置BlockView的Frame
- (void)resetBlockViewFrameWithFrame:(CGRect)frame;

@end

@implementation MCBlockView

@synthesize delegate = _delegate;
@synthesize currentGesture = _currentGesture;
@synthesize oldFrame = _oldFrame;
@synthesize block = _block;
@synthesize blockID = _blockID;

#pragma mark - init & dealloc
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
         NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        self.oldFrame = self.frame;
        self.block = nil;
        [self initAttributes];
    }
    return self;
}

- (id)initWithBlock:(MCBlock *)block
{
    self = [super init];
    if (self) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);  
        [self initAttributes];
        self.block = block;
        self.frame = self.oldFrame = [self frameWithBlock:self.block];
        
        // 初始化块精灵背景
        UIImageView *bgImageView= [[UIImageView alloc] initWithFrame:
                                   CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        bgImageView.backgroundColor = [UIColor clearColor];
        
        bgImageView.image = [self.block blockImage];
        NSLog(@"%@", bgImageView.image);
        [self addSubview:bgImageView];
        [bgImageView release];
    }
    return self;
}

- (void)dealloc
{
    self.block = nil;
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - get & set
- (int)blockID
{
    return self.block.blockID;
}

- (void)setCurrentGesture:(kBlockGesture)gesture
{
    if (_currentGesture != kGestureInvalid) {
        return;
    }
    _currentGesture = gesture;
}

#pragma mark - Touch Event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    _touchBeganPoint = [touch locationInView:self.superview];
    self.oldFrame = self.frame;
    _currentGesture = kGestureInvalid;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    _touchMovePoint = [touch locationInView:self.superview];
    
    // 移动blockView
    [self moveBlockView];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    _touchEndPoint = [touch locationInView:self.superview];
    [self reviseBlockViewFrame];// 校正frame
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}


#pragma mark - private method
- (void)initAttributes
{
    self.multipleTouchEnabled = NO; // 不支持多点触控
    _touchEndPoint = CGPointZero;
    _touchMovePoint = CGPointZero;
    _touchEndPoint = CGPointZero;
    _currentGesture = kGestureInvalid;
    self.delegate = nil;
}

- (CGRect)frameWithBlock:(MCBlock *)block
{
    float x = BLOCKVIEWWIDTH * block.positionX;
    float y = BLOCKVIEWWIDTH * block.positionY;
    float width = 0.0;
    float height = 0.0;
    
    switch (block.blockType) {
        case kBlockTypeSmall:
            width = height = BLOCKVIEWWIDTH;
            break;
            
        case kBlockTypeNormalH:
            width = BLOCKVIEWWIDTH * 2;
            height = BLOCKVIEWWIDTH;
            break;
        
        case kBlockTypeNormalV:
            width = BLOCKVIEWWIDTH;
            height = BLOCKVIEWWIDTH * 2;
            break;
            
        case kBlockTypeLager:
            width = height = BLOCKVIEWWIDTH * 2;
            break;
            
        default:
            NSAssert(kBlockTypeInvalid, @"invalid block type!!!");
            break;
    }
    return CGRectMake(x, y, width, height);
}

- (void)moveBlockView
{
    kBlockGesture gesture = [self gestureWithBegin:_touchBeganPoint andEnd:_touchMovePoint];
    self.currentGesture = gesture;
    
    if (![self notifyDelegateShoudMove]) {
        // 没有准备好
        return;
    }
    
    if ([self gestureIsChangedWith:gesture]) {
        // 手势变了， 触摸结束
        return;
    }
    
    [self notifyDelegateBeganMove];
    
    // 随着手的移动，改变BlockView的frame
    float distane = [self touchMoveDistance];
    // 根据移动的距离移动block
    [self moveBlockViewWithDistance:distane];
}

// 校正frame
- (void)reviseBlockViewFrame
{
    
}

- (kBlockGesture)gestureWithBegin:(CGPoint)beginPoint andEnd:(CGPoint)endPoint
{
    float deltaX = endPoint.x - beginPoint.x;
    float deltaY = endPoint.y - beginPoint.y;
    
    if (fabsf(deltaX) > fabsf(deltaY)) {
        // 在x方向
        if (deltaX > 0) {
            return kGestureToRight;
        }
        return kGestureToLeft;
        
    }else {
        // 在y方向
        if (deltaY > 0) {
            return kGestureToUp;
        }
        return kGestureToDown;
    }

    return kGestureInvalid;
}

- (BOOL)notifyDelegateShoudMove
{
    if (self.delegate) {
        return [self.delegate blockShouldMoveWith:self andGesture:self.currentGesture];
    }
    return NO;
}

- (void)notifyDelegateBeganMove
{
    if (self.delegate) {
        [self.delegate blockBeganMoveWith:self andGesture:self.currentGesture];
    }
}

- (void)notifyDelegateEndedMove
{
    
}

- (void)notifyDelegateFrameDidChange
{
    
}

// 手势是否改变
- (BOOL)gestureIsChangedWith:(kBlockGesture)gesture
{
    if (self.currentGesture != gesture) {
        return YES;
    }
    return NO;
}

- (float)touchMoveDistance
{
    float distance = 0.0f;
    switch (self.currentGesture) {
        case kGestureToDown:
            distance = fabsf(_touchBeganPoint.y - _touchEndPoint.y);
            break;
        
        case kGestureToLeft:
            distance = fabsf(_touchBeganPoint.x - _touchEndPoint.x);
            break;
            
        case kGestureToRight:
            distance = fabsf(_touchBeganPoint.x - _touchEndPoint.x);
            break;
            
        case kGestureToUp:
            distance = fabsf(_touchBeganPoint.y - _touchEndPoint.y);
            break;
            
        default:
            NSAssert(kGestureInvalid, @"gesture is invalid!!!");
            break;
    }
    return distance;
}

- (void)moveBlockViewWithDistance:(float)distance
{
    CGRect tempFrame = self.frame;
    switch (self.currentGesture) {
        case kGestureToDown:
            tempFrame.origin.y = self.oldFrame.origin.y + distance;
            break;
            
        case kGestureToUp:
            tempFrame.origin.y = self.oldFrame.origin.y - distance;
            break;
            
        case kGestureToLeft:
            tempFrame.origin.x = self.oldFrame.origin.x - distance;
            break;
            
        case kGestureToRight:
            tempFrame.origin.x = self.oldFrame.origin.x + distance;
            break;
            
        default:
            NSAssert(kGestureInvalid, @"gesture is invalid!!!");
            break;
    }
    
    //TODO::
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
