//
//  MCGateViewController.m
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCGateViewController.h"
#import "MCGameSceneMenuView.h"
#import "MCConfig.h"
#import "GGFoundation.h"
#import "MCUtil.h"
#import "MCGate.h"
#import "MCStep.h"
#import "MCBlock.h"
#import "MCRectFrame.h"
#import "MCPassLevelAlertView.h"
#import "MCDataManager.h"
#import "MCGameState.h"

// 获胜区域
#define CompletedCondition CGRectMake(BLOCKVIEWWIDTH, BLOCKVIEWWIDTH * 3, BLOCKVIEWWIDTH * 2, BLOCKVIEWWIDTH * 2)


typedef enum AlertTagEnum{
    kAlertTagInvalid = 0,
    kAlertTagReset,
    kAlertTagPassLevel,
    kAlertTagNewBestMove,
    kAlertTagPassAllLevel,
    kAlertTagCount,
}kAlertTag;


@interface MCGateViewController (Privates)

- (void)createSubViews;
- (void)removeSubViews;

// 显示dialog
- (void)showPassAllLevelAlertView;
- (void)showPassLevelAlertView;
- (void)showNewBestMoveAlertView;

- (UIImage *)refreshLevelImage;

// 移除steps最后一项
- (void)removeLastStep;

// 给steps添加一项
- (void)addStepWithBlockView:(MCBlockView *)blockView;

// 判断是否是新的一步， 在同一个方向移动同一个blockView按一步计算
- (BOOL)isNewActivingWithBlockView:(MCBlockView *)blockView;

- (void)completeGateWithBlockView:(MCBlockView *)blockView;

// 判断大blockView是否在获胜区域
- (BOOL)isGameCompleted:(MCBlockView *)blockView;

// 当移动blockView时，调用
- (void)refreshGameGate;

@end

@implementation MCGateViewController
@synthesize theGateID = _theGateID;
@synthesize gameSceneView = _gameSceneView;
@synthesize gameSceneMenuView = _gameSceneMenuView;
@synthesize steps = _steps;
@synthesize currentAlertView = _currentAlertView;
@synthesize moveCount = _moveCount;
@synthesize resetAlertView = _resetAlertView;

#pragma mark - init & dealloc

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"%@ : %@", NSStringFromSelector(_cmd), self);
    }
    return self;
}

- (id)initWithGateID:(int)gateID
{
    self = [super init];
    if (self) {
        NSLog(@"%@ : %@", NSStringFromSelector(_cmd), self);
        self.theGateID = gateID;
        _moveFlag = kBlockViewMoveNormal;
        _alertButtonTag = kTagControlInvlid;
        _effects = [[NSArray arrayWithObjects:@"solved.wav", @"lifeadd.mp3", nil] retain];
        [[GGSoundManager sharedGGSoundManager] loadEffect:_effects];
    }
    return self;
}

- (void)dealloc
{
    [[GGSoundManager sharedGGSoundManager] unloadEffectsWith:_effects];
    MCRelease(_effects);
    MCRelease(_gameSceneView);
    MCRelease(_gameSceneMenuView);
    MCRelease(_steps);
    MCRelease(_currentAlertView);
    MCRelease(_resetAlertView);
    MCRelease(_passLevelAlertView);
    MCRelease(_passAllLevelAlertView);
    MCRelease(_newBestMoveAlertView);
    NSLog(@"%@ : %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createSubViews];
    [self refreshSubViews];
    [self refreshButtons];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [self removeSubViews];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - get & set
- (void)setSteps:(NSArray *)steps
{
    [_steps autorelease];
    _steps = [steps retain];
    
    [self refreshButtons];
}

- (void)setTheGateID:(int)theGateID
{
    MCGate *tempGate = [[MCDataManager sharedMCDataManager] gateWithID:theGateID];
    if (!tempGate) {
        NSLog(@"invalid gate!!!!");
        return;
    }
    self.gameSceneView.theGate = tempGate;
    _theGateID = theGateID;
    [self resumeGame];
    [self refreshSubViews];
}

- (void)setMoveCount:(int)moveCount
{
    _moveCount = moveCount;
    [self refreshSubViews];
}

#pragma mark - public method
- (void)resumeGame
{}

- (void)refreshSubViews
{
    self.gameSceneMenuView.moveCountText = [NSString stringWithFormat:@"%d", self.moveCount];
    self.gameSceneMenuView.minValueText = [NSString stringWithFormat:@"%d", self.gameSceneView.theGate.passMin];
    self.gameSceneMenuView.levelValue = self.gameSceneView.theGate.gateID;
    self.gameSceneMenuView.levelImage = [self refreshLevelImage]; 
}

- (void)resetGateWithGateID:(int)gateID
{
    self.steps = nil;
    self.moveCount = 0;
    self.theGateID = gateID;
    [self.gameSceneView resetBlockViewFrameAnimation];
}

- (void)resetNextGateWithGateID:(int)gateID
{
    self.steps = nil;
    self.moveCount = 0;
    self.theGateID = gateID;
    [self.gameSceneView showBlockViews];
}

#pragma mark - Priate method
- (void)createSubViews
{
    // 添加游戏场景背景
    UIImage *gateFrameImage = [UIImage imageNamed:@"gateframe.png"];
    UIImageView *gateFrameBgView = 
    [[[UIImageView alloc] initWithFrame:
      CGRectMake(0, 0,  gateFrameImage.size.width, gateFrameImage.size.height)] autorelease];
    gateFrameBgView.backgroundColor = [UIColor clearColor];
    gateFrameBgView.image = gateFrameImage;
    [self.view addSubview:gateFrameBgView];
    
    self.gameSceneView = [[[MCGameSceneView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    self.gameSceneView.delegate = self;
    MCGate *gate = [[MCDataManager sharedMCDataManager] gateWithID:self.theGateID];
    self.gameSceneView.theGate = gate;
    
    [self.view addSubview:self.gameSceneView];
    
    self.gameSceneMenuView = [[[MCGameSceneMenuView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)] autorelease];
    self.gameSceneMenuView.delegate = self;
    [self.view addSubview:self.gameSceneMenuView];
   
    [self refreshSubViews]; 
}

- (void)backAction:(id)sender
{
    [super buttonAction:sender];
    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)removeSubViews
{
    self.gameSceneView = nil;
    self.gameSceneMenuView = nil;
    _passLevelAlertView = nil;
    _passAllLevelAlertView = nil;
    _resetAlertView = nil;
    _newBestMoveAlertView = nil;
}

- (UIImage *)refreshLevelImage
{
    UIImage *image = [UIImage imageNamed:@"levelflag.png"];
    MCGate *gate = self.gameSceneView.theGate;
    if (gate) {
        if (gate.passMoveCount > gate.passMin || gate.passMoveCount == -1) {
            image = [UIImage imageNamed:@"levelflag.png"];
        }else if(gate.passMoveCount == gate.passMin){
            image = [UIImage imageNamed:@"levelflag.png"];
        }
    }
    return image;
}

- (void)removeLastStep
{
    if (self.steps.copy > 0) {
        NSMutableArray *tempSteps = [NSMutableArray arrayWithArray:self.steps];
        [tempSteps removeLastObject];
        self.steps = [NSArray arrayWithArray:tempSteps];
    }
}

- (void)addStepWithBlockView:(MCBlockView *)blockView
{
    MCStep *step = [[MCStep alloc] init];
    step.blockID = blockView.blockID;
    step.frameOld = blockView.oldFrame;
    step.isNewActiving = [self isNewActivingWithBlockView:blockView];
    NSMutableArray *tempSteps = [NSMutableArray arrayWithArray:self.steps];
    [tempSteps addObject:step];
    [step release];
    self.steps = [NSArray arrayWithArray:tempSteps];
}

- (BOOL)isNewActivingWithBlockView:(MCBlockView *)blockView
{
    if (self.steps.count > 0) {
        MCStep *lastStep = [self.steps lastObject];
        if (lastStep.blockID != blockView.blockID) {
            self.moveCount ++;
            return YES;
        }
        return NO;
    }
    self.moveCount ++;
    return YES;
}

- (void)completeGateWithBlockView:(MCBlockView *)blockView
{
    if (!blockView.block.isLargeBlock) {
        // 移动不是大的blockView
        return;
    }else {
        // 判断是否在指定的获胜区域
        if ([self isGameCompleted:blockView]) {
            [self levleDidPass];
        }
    }
}

- (BOOL)isGameCompleted:(MCBlockView *)blockView
{
    if (CGRectEqualToRect(blockView.frame, CompletedCondition)) {
        return YES;
    }
    return NO;
}

- (void)levleDidPass
{
    BOOL isNewRMin = NO;
    BOOL isPassAllLevel = NO;
    
    if ([MCUtil isCompleteAllGate:self.gameSceneView.theGate]) {
        isPassAllLevel = YES;
    }
    
    MCGate *gate = self.gameSceneView.theGate;
    if (gate.passMoveCount != gate.passMin) {
        self.gameSceneView.theGate.passMoveCount = self.moveCount;
    }
    
    if ([gate checkNewRecord:self.moveCount]) {
        // 是否是新纪录
        isNewRMin = YES;
        self.gameSceneView.theGate.passMoveCount = self.moveCount;
    }
    
    if (![[MCDataManager sharedMCDataManager] updateGateWithGate:self.gameSceneView.theGate]) {
        NSLog(@"update gate state failed!!!");
        return;
    }
    
    if (isPassAllLevel) {
        [self showPassAllLevelAlertView];
        [[GGSoundManager sharedGGSoundManager] playEffect:@"lifeadd.mp3"];
    }else{
        if(isNewRMin) {
            [self showNewBestMoveAlertView];
            [[GGSoundManager sharedGGSoundManager] playEffect:@"solved.wav"];
        }else {
            [self showPassLevelAlertView];
            [[GGSoundManager sharedGGSoundManager] playEffect:@"lifeadd.mp3"];
        }
    }
}

- (void)refreshGameGate
{
    if (self.theGateID <= 0) {
        return;
    }
    
    MCBlockView *keyBlockView = nil;
    for (MCBlockView *blockView in self.gameSceneView.blockViews) {
        if (blockView.block.isLargeBlock) {
            // 如果是大blockView
            keyBlockView = blockView;
            break;
        }
    }
    
    MCGameState *gameState = [[MCGameState alloc] init];
    if (keyBlockView) {
        if ([self isGameCompleted:keyBlockView]) {
            gameState.currentGateID = [MCUtil nextGateIDWith:self.gameSceneView.theGate];
            [MCDataManager sharedMCDataManager].gameState = gameState;
        }else {
            if (self.steps.count > 0) {
                gameState.currentGateID = self.gameSceneView.theGate.gateID;
                gameState.moveCount = self.moveCount;
                gameState.steps = self.steps;
                NSMutableArray *mfs = [NSMutableArray array];
                for (MCBlockView *blockView in self.gameSceneView.blockViews) {
                    MCRectFrame *frame = [[MCRectFrame alloc] init];
                    [frame refreshWithRect:blockView.frame];
                    [mfs addObject:frame];
                    [frame release];
                }
                gameState.frames = [NSArray arrayWithArray:mfs];
                [MCDataManager sharedMCDataManager].gameState = gameState;
            }else {
                NSLog(@"not Move anything blockView!!!!");
            }
        }
    }
    [gameState release];
}

- (void)gotoNextLevel:(int)gateID
{
    
}

- (void)showResetAlertView
{
    NSLog(@"showResetAlertView");
    if (!_resetAlertView) {
        _resetAlertView = [[MCResetAlertView alloc] init];
        _resetAlertView.delegate = self;
        _resetAlertView.tag = kAlertTagReset;
    }
    [_resetAlertView showAlertView];
}

- (void)showPassAllLevelAlertView
{
     NSLog(@"showPassAllLevelAlertView");
    if (!_passAllLevelAlertView) {
        _passAllLevelAlertView = [[[[MCPassAllLevelAlertView alloc] init] autorelease] retain];
        _passAllLevelAlertView.delegate = self;
        _passAllLevelAlertView.tag = kAlertTagPassAllLevel;
    }
    [_passAllLevelAlertView showAlertView];
}

- (void)showNewBestMoveAlertView
{
     NSLog(@"showNewBestMoveAlertView");
    if (!_newBestMoveAlertView) {
        _newBestMoveAlertView = [[[[MCNewBestMoveAlertView alloc] init] autorelease] retain];
        _newBestMoveAlertView.delegate = self;
        _newBestMoveAlertView.tag = kAlertTagNewBestMove;
    }
    [_newBestMoveAlertView showAlertView];
}

- (void)showPassLevelAlertView
{
     NSLog(@"showPassLevelAlertView");
    if (!_passLevelAlertView) {
        _passLevelAlertView = [[[[MCPassLevelAlertView alloc] init] autorelease] retain];
        _passLevelAlertView.delegate = self;
        _passLevelAlertView.tag = kAlertTagPassLevel;
    }
    [_passLevelAlertView showAlertView];
}

#pragma mark - GameSceneMenuDelegate
- (void)undoAction:(id)sender
{
    [super buttonAction:sender];
    if (self.steps.count > 0) {
        // 说明已经移动了block，能执行undo操作
        _moveFlag = kBlockViewMoveUndo;
        MCStep *step = [self.steps lastObject];
        MCBlockView *blockView = [self.gameSceneView blockViewWithBlockID:step.blockID];
        [blockView moveBlockViewWithFrame:step.frameOld];
    }
}

- (void)resetAction:(id)sender
{
    [super buttonAction:sender];
    [self showResetAlertView];
}

- (void)refreshButtons
{
    if (self.steps.count > 0) {
        self.gameSceneMenuView.btnUndo.enabled = YES;
        self.gameSceneMenuView.btnReset.enabled = YES;
    }else {
        self.gameSceneMenuView.btnUndo.enabled = NO;
        self.gameSceneMenuView.btnReset.enabled = NO;
    }
}

#pragma mark - MCAlertDelegate
- (void)alertView:(MCAlertView *)view andButton:(UIButton *)button
{
    NSLog(@"MCAlertDelegate: %@",NSStringFromSelector(_cmd));
    // 所有dialog都需要执行
    self.currentAlertView = view;
    _alertButtonTag = button.tag;
    [self hideWindow];
}

#pragma mark- GameSceneViewDelegate
- (void)movingBlockView:(BOOL)isMove
{
    self.gameSceneMenuView.btnUndo.userInteractionEnabled = isMove;
    self.gameSceneMenuView.btnReset.userInteractionEnabled = isMove;
}

- (void)blockFrameDidChangeWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture
{
    if (_moveFlag == kBlockViewMoveUndo ) {
        // 如果是返回
        MCStep *lastStep = [self.steps lastObject];
        if (lastStep.isNewActiving) {
            self.moveCount -= 1;
        }
        [self removeLastStep];
        _moveFlag = kBlockViewMoveNormal;
        return;
    }
    
    // 如果是正常移动blockView
    [self addStepWithBlockView:blockView];
    [self completeGateWithBlockView:blockView];
    [self refreshGameGate];
}

#pragma mark - overWirte method
- (void)refreshView
{}

- (void) windowDidShow
{
    [super windowDidShow];
}

- (void)windowDidHide
{
    [super windowDidHide];
    if (self.currentAlertView == _resetAlertView) {        
        if (kTagControlFirst == _alertButtonTag) {
            // 如果是重置按钮， 则重置游戏
            MCGameState *gameState = [[MCGameState alloc] init];
            gameState.currentGateID = self.theGateID;
            [MCDataManager sharedMCDataManager].gameState = gameState;
            [gameState release];
            [self resetGateWithGateID:self.theGateID];
        }
        [self showWindow];
        return;
    }
    if (self.currentAlertView == _passLevelAlertView) {
        if (kTagControlFirst == _alertButtonTag) {
            [self gotoNextLevel:self.theGateID];
        }else if(kTagControlSecond == _alertButtonTag){
            [self gotoNextLevel:[MCUtil nextGateIDWith:self.gameSceneView.theGate]];
        }
        [self.gameSceneView showStar:self.gameSceneView.theGate];
        [self showWindow];
        return;
    }
    if (self.currentAlertView == _passAllLevelAlertView) {
        if (kTagControlFirst == _alertButtonTag) {
            [self gotoNextLevel:self.theGateID];
        }else if(kTagControlSecond == _alertButtonTag){
            [self gotoNextLevel:1];
        }
        [self.gameSceneView showStar:self.gameSceneView.theGate];
        [self showWindow];
        return;
    }
    if (self.currentAlertView == _newBestMoveAlertView) {
        if (kTagControlFirst == _alertButtonTag) {
            [self gotoNextLevel:self.theGateID];
        }else if(kTagControlSecond == _alertButtonTag){
            [self gotoNextLevel:[MCUtil nextGateIDWith:self.gameSceneView.theGate]];
        }
        [self.gameSceneView showStar:self.gameSceneView.theGate];
        [self showWindow];
        return;
    }
}

@end
