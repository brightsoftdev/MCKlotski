//
//  MCBlockView.m
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCBlockView.h"
#import "MCBlock.h"
#import "MCDataManager.h"

@interface MCBlockView (Privates)

// 初始化私有字段和属性
- (void)initAttributes;

// 根据block确定Frame
- (CGRect)frameWithBlock:(MCBlock *)block;

// 移动BlockView
- (void)moveBlockView;
// 在touchend时校正blockView的Frame
- (void)reviseBlockViewFrame;
// 校正动画
- (void)reviseAnimationBeginWithFrame:(CGRect)frame;
// 移动动画
- (void)moveAnimationWithFrame:(CGRect)frame;
// 设置BlockView的Frame, 防止超出边界
- (void)resetBlockViewFrameWithFrame:(CGRect)frame;

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
- (void)resetBlockViewFrameWithFrame:(CGRect)frame firstObstract:(MCBlockView *)firstObstract;

// 返回当前触摸的BlockView可达到的区域（frame）
- (CGRect)frameShouldMoveBlockView;

// 取到直接阻挡blockView移动的BlockView
- (MCBlockView *)firstBlockVergeOnGesture:(kBlockGesture)gesture;

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
        bgImageView.backgroundColor = [UIColor blueColor];
        
        //bgImageView.image = [self.block blockImage];
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

#pragma mark - public method
+ (CGRect)frameWithBlockType:(int)blockType positionX:(int)x positionY:(int)y
{
    float tempX = 0.0f;
    float tempY = 0.0f;
    float tempW = 0.0f;
    float tempH = 0.0f;
    
    tempX = BLOCKVIEWWIDTH * x;
    tempY = BLOCKVIEWWIDTH * y;
    
    switch (blockType) {
        case kBlockTypeSmall:
            tempH = tempW = BLOCKVIEWWIDTH;
            break;
            
        case kBlockTypeNormalH:
            tempW = BLOCKVIEWWIDTH * 2;
            tempH = BLOCKVIEWWIDTH;
            break;
            
        case kBlockTypeNormalV:
            tempW = BLOCKVIEWWIDTH;
            tempH = BLOCKVIEWWIDTH * 2;
            break;
            
        case kBlockTypeLager:
            tempH = tempW  = BLOCKVIEWWIDTH * 2;
            break;
            
        default:
            NSAssert(kBlockTypeInvalid, @"invalid block type!!!");
            break;
    }
    return CGRectMake(tempX, tempY, tempW, tempH);
}

- (void)moveBlockViewWithFrame:(CGRect)newFrame
{
    [self notifyDelegateBeganMove];
    self.currentGesture = [self gestureWithBegin:self.frame.origin andEnd:newFrame.origin];
    self.oldFrame = self.frame;
    [self moveAnimationWithFrame:newFrame];
}

- (BOOL)isVergeBoundary
{
    switch (self.currentGesture) {
        case kGestureToUp:
            if (self.frame.origin.y > kBoxY) {
                return NO;
            }
            break;
            
        case kGestureToDown:
            if (self.frame.origin.y + self.frame.size.height < kBoxHeight) {
                return NO;
            }
            break;
            
        case kGestureToLeft:
            if (self.frame.origin.x > kBoxX) {
                return NO;
            }
            break;
            
        case kGestureToRight:
            if (self.frame.origin.x + self.frame.size.width < kBoxWidth) {
                return NO;
            }
            break;
            
        default:
            break;
    }
    return YES;
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
    int blockType = block.blockType;
    int x = block.positionX;
    int y = block.positionY;
    return [MCBlockView frameWithBlockType:blockType positionX:x positionY:y];
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

// 校正frame， 保证每次移动的距离都是BLOCKVIEWWIDTH的整数倍
- (void)reviseBlockViewFrame
{
    CGRect revisedFrame = self.frame;
    float mdistance = 0.0f;
    switch (self.currentGesture) {
        case kGestureToUp:
            mdistance = fabsf(self.oldFrame.origin.y - self.frame.origin.y);
            break;
            
        case kGestureToDown:
            mdistance = fabsf(self.oldFrame.origin.y - self.frame.origin.y);
            break;
            
        case kGestureToLeft:
            mdistance = fabsf(self.oldFrame.origin.x - self.frame.origin.x);
            break;
            
        case kGestureToRight:
            mdistance = fabsf(self.oldFrame.origin.x - self.frame.origin.x);
            break;
        default:
            break;
    }
    
    // 转换为棋盘坐标
    float quo = mdistance / BLOCKVIEWWIDTH;
    int intQuo = (int)quo;
    
    // 移动超过（BLOCKVIEWWIDTH / 2） 时按一格算, 否则按0计算
    float res = mdistance - intQuo * BLOCKVIEWWIDTH;
    res = res > BLOCKVIEWWIDTH / 2.0 ? BLOCKVIEWWIDTH : 0.0;
    mdistance = intQuo * BLOCKVIEWWIDTH + res;
    
    switch (self.currentGesture) {
        case kGestureToUp:
            revisedFrame.origin.y = self.oldFrame.origin.y - mdistance;
            break;
            
        case kGestureToDown:
            revisedFrame.origin.y = self.oldFrame.origin.y + mdistance;
            break;
            
        case kGestureToLeft:
            revisedFrame.origin.x = self.oldFrame.origin.x - mdistance;
            break;
            
        case kGestureToRight:
            revisedFrame.origin.x = self.oldFrame.origin.x + mdistance;
            break;
        default:
            break;
    }
    if (CGRectEqualToRect(self.frame, revisedFrame)) {
        [self notifyDelegateEndedMove];
        return;
    }
    
    [self reviseAnimationBeginWithFrame:revisedFrame];
}

- (void) reviseAnimationBeginWithFrame:(CGRect)frame
{
    [UIView beginAnimations:@"reviseAnimation" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDidStopSelector:@selector(reviseAnimationEnd:)];
    [self resetBlockViewFrameWithFrame:frame];
    [UIView commitAnimations];
}

- (void)reviseAnimationEnd:(id)sender
{
    [self notifyDelegateEndedMove];
}

- (void)moveAnimationWithFrame:(CGRect)frame
{
    [UIView beginAnimations:@"moveAnimation" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDidStopSelector:@selector(moveAnimationEnd:)];
    [self resetBlockViewFrameWithFrame:frame];
}

- (void)moveAnimationEnd:(id)sender
{
    [self notifyDelegateEndedMove];
}

// 判定手势方向
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
        if (deltaY < 0) {
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
    if (self.delegate) {
        [self.delegate blockEndMoveWith:self andGesture:self.currentGesture];
    }
    [self notifyDelegateFrameDidChange];
}

- (void)notifyDelegateFrameDidChange
{
    if (self.delegate) {
        if (!CGRectEqualToRect(self.oldFrame, self.frame)) {
            [self.delegate blockFrameDidChangeWith:self andGesture:self.currentGesture];
        }
    }
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
            distance = fabsf(_touchBeganPoint.y - _touchMovePoint.y);
            break;
        
        case kGestureToLeft:
            distance = fabsf(_touchBeganPoint.x - _touchMovePoint.x);
            break;
            
        case kGestureToRight:
            distance = fabsf(_touchBeganPoint.x - _touchMovePoint.x);
            break;
            
        case kGestureToUp:
            distance = fabsf(_touchBeganPoint.y - _touchMovePoint.y);
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
    
    MCBlockView *obstract = [self firstBlockVergeOnGesture:self.currentGesture];
    NSLog(@"obstract : %@", obstract);
    // 重置BlockView的Frame
    [self resetBlockViewFrameWithFrame:tempFrame firstObstract:obstract];
    
}

// 返回当前触摸的BlockView可达到的区域（frame）
- (CGRect)frameShouldMoveBlockView
{
    CGRect valuableFrame=CGRectZero;
    switch (self.currentGesture) {
        case kGestureToUp:
            valuableFrame = CGRectMake(self.frame.origin.x,
                                       kBoxY,
                                       self.frame.size.width,
                                       self.frame.origin.y - kBoxY);
            break;
            
        case kGestureToDown:
            valuableFrame = CGRectMake(self.frame.origin.x, 
                                       self.frame.origin.y + self.frame.size.height, 
                                       self.frame.size.width, 
                                       kBoxHeight - (self.frame.size.height + self.frame.origin.y));
            break;
            
        case kGestureToLeft:
            valuableFrame = CGRectMake(kBoxX, 
                                       self.frame.origin.y, 
                                       self.frame.origin.x - kBoxX, 
                                       self.frame.size.height);
            break;
            
        case kGestureToRight:
            valuableFrame = CGRectMake(self.frame.origin.x + self.frame.size.width,
                                       self.frame.origin.y,
                                       kBoxWidth - (self.frame.origin.x + self.frame.size.width),
                                       self.frame.size.height);
            break;
            
        default:
            break;
    }
    return valuableFrame;
}

// 取到直接阻挡blockView移动的BlockView
- (MCBlockView *)firstBlockVergeOnGesture:(kBlockGesture)gesture
{
    MCBlockView *firstBlockView = nil;
    
    CGRect valuableFrame = CGRectZero;
    valuableFrame = [self frameShouldMoveBlockView];
    
    // 存储移动过程中挡路的blockView
    NSMutableArray *obstracts = [NSMutableArray array];
    for (MCBlockView *blockView in [MCDataManager sharedMCDataManager].blockViews) {
        if (blockView == self) {
            // 如果是self， 跳过此次循环
            continue;
        }
        if (CGRectIntersectsRect(valuableFrame, blockView.frame)) {
            [obstracts addObject:blockView];
        }
    }
    
    float minDistance = (_currentGesture == kGestureToLeft || _currentGesture == kGestureToRight) ? 
                        kBoxWidth : kBoxHeight;
    float currentDistance = 0.0f;
    for (MCBlockView *blockView in obstracts) {
        switch (self.currentGesture) {
            case kGestureToUp:
                currentDistance = fabsf(self.frame.origin.y - blockView.center.y);
                break;
                
            case kGestureToDown:
                currentDistance = fabsf(self.frame.origin.y - blockView.center.y);
                break;
                
            case kGestureToLeft:
                currentDistance = fabsf(self.frame.origin.x - blockView.center.x);
                break;
                
            case kGestureToRight:
                currentDistance = fabsf(self.frame.origin.x - blockView.center.x);
                break;
                
            default:
                break;
        }
        if (currentDistance < minDistance) {
            minDistance = currentDistance;
            firstBlockView = blockView;
        }
    }
    
    return firstBlockView;
}

- (void)resetBlockViewFrameWithFrame:(CGRect)frame
{
    if (frame.origin.x < kBoxX + BLOCKVIEWWIDTH / 2.0) {
        frame.origin.x = kBoxX;
    }
    if (frame.origin.x > kBoxWidth - self.frame.size.width) {
        frame.origin.x = kBoxWidth - self.frame.size.width;
    }
    if (frame.origin.y < kBoxY + BLOCKVIEWWIDTH / 2.0) {
        frame.origin.y = kBoxY;
    }
    if (frame.origin.y > kBoxHeight - self.frame.size.height) {
        frame.origin.y = kBoxHeight - self.frame.size.height;
    }
    
    self.frame = frame;
}

- (void)resetBlockViewFrameWithFrame:(CGRect)frame firstObstract:(MCBlockView *)firstObstract
{
    CGRect tempFrame = frame;
    if (firstObstract) {
        switch (self.currentGesture) {
            case kGestureToUp:
                if (tempFrame.origin.y < 
                    (firstObstract.frame.origin.y + firstObstract.frame.size.height)) 
                    tempFrame.origin.y = firstObstract.frame.origin.y + firstObstract.frame.size.height;
                break;
                
            case kGestureToDown:
                if (tempFrame.origin.y > firstObstract.frame.origin.y - self.frame.size.height) {
                    tempFrame.origin.y = firstObstract.frame.origin.y - self.frame.size.height;
                }
                break;
                
            case kGestureToLeft:
                if (tempFrame.origin.x <
                    (firstObstract.frame.origin.x + firstObstract.frame.size.width)) {
                    tempFrame.origin.x = firstObstract.frame.origin.x + firstObstract.frame.size.width;
                }
                break;
                
            case kGestureToRight:
                if (tempFrame.origin.x > firstObstract.frame.origin.x - self.frame.size.width) {
                    tempFrame.origin.x = firstObstract.frame.origin.x - self.frame.size.width;
                }
                break;
            default:
                NSAssert(kGestureInvalid, @"gesture is invalid!!!");
                break;
        }
    }else {
        switch (self.currentGesture) {
            case kGestureToUp:
                tempFrame.origin.y = tempFrame.origin.y < kBoxY ? kBoxY : tempFrame.origin.y;
                break;
                
            case kGestureToDown:
                tempFrame.origin.y = 
                    tempFrame.origin.y > (kBoxHeight - self.frame.size.height) ? 
                        (kBoxHeight - self.frame.size.height) : tempFrame.origin.y;
                break;
                
            case kGestureToLeft:
                tempFrame.origin.x = tempFrame.origin.x < kBoxX ? kBoxX : tempFrame.origin.x;
                break;
                
            case kGestureToRight:
                tempFrame.origin.x = 
                    tempFrame.origin.x > (kBoxWidth - self.frame.size.width)?
                        kBoxWidth - self.frame.size.width : tempFrame.origin.x;
                break;
            default:
                NSAssert(kGestureInvalid, @"gesture is invalid!!!");
                break;
        }
    }
    self.frame = tempFrame;
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
