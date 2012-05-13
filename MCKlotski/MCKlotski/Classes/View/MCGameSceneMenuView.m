//
//  MCGameSceneMenuView.m
//  MCKlotski
//
//  Created by gtts on 5/6/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCGameSceneMenuView.h"
#import "MCNumberView.h"

@interface MCGameSceneMenuView ()

- (void)createSubViews;

@end

@implementation MCGameSceneMenuView

@synthesize delegate = _delegate;
@synthesize btnUndo = _btnUndo;
@synthesize btnReset = _btnReset;
@synthesize moveCountText = _moveCountText;
@synthesize minValueText = _minValueText;
@synthesize levelValue = _levelValue;
@synthesize levelImage = _levelImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"%@ : %@", NSStringFromSelector(_cmd), self);
        [self createSubViews];
    }
    return self;
}

- (void)dealloc
{
    [_btnUndo release];
    [_btnReset release];
    [_lblMinValue release];
    [_lblMoveCount release];
    [_moveCountText release];
    [_minValueText release];
    [_levelImageView release];
    [_levelNumberView release];
    [_levelImage release];
    NSLog(@"%@ : %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - Private method
- (void)createSubViews
{
    // 添加后退按钮
    self.btnUndo = [[[UIButton alloc] initWithFrame:CGRectMake(193, 59, 55, 30)] autorelease];
    [_btnUndo setBackgroundImage:[UIImage imageNamed:@"undo.png"] forState:UIControlStateNormal];
    [_btnUndo setBackgroundImage:[UIImage imageNamed:@"undo_2.png"] forState:UIControlStateHighlighted];
    [_btnUndo addTarget:self action:@selector(undoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnUndo];
    
    // 添加重置按钮
    self.btnReset = [[[UIButton alloc] initWithFrame:CGRectMake(193+55+10, 59, 55, 30)] autorelease];
    [_btnReset setBackgroundImage:[UIImage imageNamed:@"reset.png"] forState:UIControlStateNormal];
    [_btnReset setBackgroundImage:[UIImage imageNamed:@"reset_2.png"] forState:UIControlStateHighlighted];
    [_btnReset addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnReset];
    
    // 添加计数label等
    UIImage *moveImage = [UIImage imageNamed:@"move.png"]; 
    UIImageView *moveCountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_btnUndo.frame.origin.x, 20, moveImage.size.width, moveImage.size.height)];
    moveCountImageView.image = moveImage;
    [self addSubview:moveCountImageView];
    
    _lblMoveCount = [[UILabel alloc] initWithFrame:CGRectMake(_btnUndo.frame.origin.x, 35, _btnUndo.frame.size.width, 25)];
    _lblMoveCount.backgroundColor = [UIColor clearColor];
    _lblMoveCount.text = @"0";
    _lblMoveCount.font = [UIFont boldSystemFontOfSize:14];
    _lblMoveCount.textAlignment = UITextAlignmentCenter;
    _lblMoveCount.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self addSubview:_lblMoveCount];
    
    UIImage *bestImage = [UIImage imageNamed:@"best.png"]; 
    UIImageView *bestImageView = [[UIImageView alloc] initWithFrame:CGRectMake(193+55+10, 20, bestImage.size.width, bestImage.size.height)];
    bestImageView.image = bestImage;
    [self addSubview:bestImageView];
    
    _lblMinValue = [[UILabel alloc] initWithFrame:CGRectMake(193+55+10, 35, 55, 30)];
    _lblMinValue.backgroundColor = [UIColor clearColor];
    _lblMinValue.text = @"0";
    _lblMinValue.font = [UIFont boldSystemFontOfSize:14];
    _lblMinValue.textAlignment = UITextAlignmentCenter;
    _lblMinValue.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self addSubview:_lblMinValue];
    
    // 添加level标志
    _levelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 25, 65, 30)];
    _levelImageView.backgroundColor = [UIColor clearColor];
    _levelImageView.image = [UIImage imageNamed:@"levelflag.png"];
    _levelImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_levelImageView];
    
    _levelNumberView = [[MCNumberView alloc] initWithFrame:CGRectMake(100, 55, 65, 16)];
    _levelNumberView.value = 000;
    _levelNumberView.numberType = NumberRGBWhite;
    [self addSubview:_levelNumberView];
    
    //TODO:: 添加返回按钮
    UIButton *back = [[UIButton alloc] init];
    UIImage *backImage = [UIImage imageNamed:@"back1.png"];
    back.frame = CGRectMake(10, 30, backImage.size.width, backImage.size.height);
    [back setBackgroundImage:backImage forState:UIControlStateNormal];
    [back setBackgroundImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:back];
    [back release]; 
}

#pragma mark - set
- (void)setMoveCountText:(NSString *)moveCountText
{
    [_moveCountText release];
    _moveCountText = [moveCountText copy];
    _lblMoveCount.text = _moveCountText;
}

- (void)setMinValueText:(NSString *)minValueText
{
    [_minValueText release];
    _minValueText = [minValueText copy];
    _lblMinValue.text = _minValueText;
}

- (void)setLevelValue:(int)levelValue
{
    _levelValue = levelValue;
    _levelNumberView.value = _levelValue;
}

- (void)setLevelImage:(UIImage *)levelImage
{
    [_levelImage release];
    _levelImage = [levelImage retain];
    _levelImageView.image = _levelImage;
}

#pragma mark - button event 
- (void)backAction:(id)sender
{
    [self.delegate backAction:sender];
}


- (void)undoAction:(id)sender
{
    [self.delegate undoAction:sender];
}

- (void)resetAction:(id)sender
{
    [self.delegate resetAction:sender];
}

@end
