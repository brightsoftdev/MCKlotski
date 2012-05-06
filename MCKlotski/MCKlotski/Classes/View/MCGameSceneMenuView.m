//
//  MCGameSceneMenuView.m
//  MCKlotski
//
//  Created by gtts on 5/6/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCGameSceneMenuView.h"

@interface MCGameSceneMenuView ()

- (void)createSubViews;

@end

@implementation MCGameSceneMenuView

@synthesize delegate = _delegate;

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
    NSLog(@"%@ : %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - Private method
- (void)createSubViews
{
    // 添加后退按钮
    _btnUndo = [[UIButton alloc] initWithFrame:CGRectMake(193, 59, 55, 30)];
    [_btnUndo setBackgroundImage:[UIImage imageNamed:@"undo.png"] forState:UIControlStateNormal];
    [_btnUndo setBackgroundImage:[UIImage imageNamed:@"undo_2.png"] forState:UIControlStateHighlighted];
    [_btnUndo addTarget:self action:@selector(undoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnUndo];
    [_btnUndo release];
    
    // 添加重置按钮
    _btnReset = [[UIButton alloc] initWithFrame:CGRectMake(193+55+10, 59, 55, 30)];
    [_btnReset setBackgroundImage:[UIImage imageNamed:@"reset.png"] forState:UIControlStateNormal];
    [_btnReset setBackgroundImage:[UIImage imageNamed:@"reset_2.png"] forState:UIControlStateHighlighted];
    [_btnReset addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnReset];
    [_btnReset release];
    
    //TODO:: 添加返回按钮
}

#pragma mark - buttnon event 
- (void)backAction:(id)sender
{
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
