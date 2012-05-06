//
//  MCGameSceneView.m
//  MCKlotski
//
//  Created by gtts on 5/6/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCGameSceneView.h"
#import "MCDataManager.h"
#import "MCUtil.h"
#import "MCGate.h"
#import "MCBlock.h"

@interface MCGameSceneView ()

- (void)createSubViews;
- (void)createBlockViews;

- (void)clearBoxView;

- (void)showBlockViews;
- (void)showStar:(MCGate *)gate;



@end

@implementation MCGameSceneView

@synthesize blockViews = _blockViews;
@synthesize theGate = _theGate;
@synthesize starView = _starView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"%@ : %@", NSStringFromSelector(_cmd), self);
        _blockViews = nil;
        [self createSubViews];
    }
    return self;
}

- (void)dealloc
{
    [_blockViews release];
    _blockViews = nil;
    [_theBoxView release];   
    [_theGate release];
    [_starView release];
    NSLog(@"%@ : %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - get & set
- (void)setBlockViews:(NSArray *)blockViews
{
    [_blockViews autorelease];
    _blockViews = [blockViews retain];
    [MCDataManager sharedMCDataManager].blockViews = _blockViews;
    [self showBlockViews];
}

- (void)setTheGate:(MCGate *)theGate
{
    [_theGate autorelease];
    _theGate = [theGate retain];
    [self showStar:_theGate];
    [self createBlockViews];
}

#pragma mark - public method
- (MCBlockView *)blockViewWithBlockID:(int)blockID
{
    MCBlockView *tempBlcokView = nil;
    for (MCBlockView *blockView in self.blockViews) {
        if (blockID == blockView.blockID) {
            tempBlcokView = [blockView retain];
        }
    }
    return tempBlcokView;
}

#pragma mark - Priate method
- (void)createSubViews
{
    // 添加游戏场景背景
    UIImage *gateFrameImage = [UIImage imageNamed:@"gateFrame.png"];
    UIImageView *gateFrameBgView = 
    [[[UIImageView alloc] initWithFrame:
      CGRectMake(0, 0,  gateFrameImage.size.width, gateFrameImage.size.height)] autorelease];
    gateFrameBgView.backgroundColor = [UIColor clearColor];
    gateFrameBgView.image = gateFrameImage;
    [self addSubview:gateFrameBgView];
    
    _theBoxView = [[UIView alloc] initWithFrame:
                   CGRectMake((self.frame.size.width - kBoxWidth) / 2, 90, kBoxWidth, kBoxHeight)];
    _theBoxView.backgroundColor = [UIColor clearColor];
    [self addSubview:_theBoxView];
}

- (void)clearBoxView
{
    [MCUtil clearAllSubViewsWith:_theBoxView];
}

- (void)showBlockViews
{
    [self clearBoxView];
    for (MCBlockView *blockView in self.blockViews) {
        [_theBoxView addSubview:blockView];
    }
}

- (void)showStar:(MCGate *)gate
{
    [_starView removeFromSuperview];
    self.starView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 70, 51, 51)];
    if (_theGate.passMoveCount != 0) {
        if (_theGate.passMoveCount > _theGate.passMin || _theGate.passMoveCount == -1) {
            _starView.image = [UIImage imageNamed:@"star1.png"];
        }else {
            _starView.image = [UIImage imageNamed:@"star2.png"];
        }
    }else {
        // 还没有开始移动，即第一次移动
        _starView.image = [UIImage imageNamed:@"star3.png"];
    }
    [self addSubview:_starView];
}

- (void)createBlockViews
{
    int layoutCount = self.theGate.layout.count;
    if (0 == layoutCount || 0 != layoutCount % 3) {
        NSLog(@"Invaluable layout!");
        return;
    }
    
    NSMutableArray *tempBlockViews = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0 ; i < layoutCount; i += 3) {
        kBlockType blockType = [[self.theGate.layout objectAtIndex:i] intValue];
        int positionX = [[self.theGate.layout objectAtIndex:(i + 1)] intValue];
        int positionY = [[self.theGate.layout objectAtIndex:(i + 2)] intValue];
        MCBlock *block = [[MCBlock alloc] init];
        block.blockID = i / 3;
        block.blockType = blockType;
        block.positionX = positionX;
        block.positionY = positionY;
        MCBlockView *blockView = [[MCBlockView alloc] initWithBlock:block];
        blockView.delegate = self;
        [tempBlockViews addObject:blockView];
        [block release];
        [blockView release];
    }
    self.blockViews = [NSArray arrayWithArray:tempBlockViews];
}

#pragma mark - BlockGestureDelegate

- (BOOL)blockShouldMoveWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture
{
    return YES;
}

- (void)blockBeganMoveWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture
{
    
}

- (void)blockEndMoveWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture
{
    
}

- (void)blockFrameDidChangeWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture
{
    
}

@end
