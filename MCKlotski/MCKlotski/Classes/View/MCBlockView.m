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
- (void) initAttributes;

// 根据block确定Frame
- (CGRect)frameWithBlock:(MCBlock *)block;

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

- (id) initWithBlock:(MCBlock *)block
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
- (int) blockID
{
    return self.block.blockID;
}

#pragma mark - private method
- (void) initAttributes
{
    self.multipleTouchEnabled = NO; // 不支持多点触控
    _touchEndPoint = CGPointZero;
    _touchMovePoint = CGPointZero;
    _touchEndPoint = CGPointZero;
    _currentGesture = GESTURE_INVALID;
    self.delegate = nil;
}

- (CGRect) frameWithBlock:(MCBlock *)block
{
    float x = BLOCKVIEWWIDTH * block.positionX;
    float y = BLOCKVIEWWIDTH * block.positionY;
    float width = 0.0;
    float height = 0.0;
    
    switch (block.blockType) {
        case BLOCK_TYPE_SMALL:
            width = height = BLOCKVIEWWIDTH;
            break;
            
        case BLOCK_TYPE_NORMALH:
            width = BLOCKVIEWWIDTH * 2;
            height = BLOCKVIEWWIDTH;
            break;
        
        case BLOCK_TYPE_NORMALV:
            width = BLOCKVIEWWIDTH;
            height = BLOCKVIEWWIDTH * 2;
            break;
            
        case BLOCK_TYPE_LARGE:
            width = height = BLOCKVIEWWIDTH * 2;
            break;
            
        default:
            NSAssert(BLOCK_TYPE_INVALID, @"invalid block type!!!");
            break;
    }
    return CGRectMake(x, y, width, height);
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
