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
#import "MCGate.h"
#import "MCStep.h"
#import "MCAlertPassLevelView.h"
#import "MCDataManager.h"

typedef enum AlertTagEnum{
    kAlertTagInvalid = 0,
    kAlertTagReset,
    kAlertTagPassLevel,
    kAlertTagCount,
}kAlertTag;


@interface MCGateViewController (Privates)

- (void)createSubViews;
- (void)removeSubViews;
- (void)showResetAlertView;
- (UIImage *)refreshLevelImage;

@end

@implementation MCGateViewController
@synthesize theGateID = _theGateID;
@synthesize gameSceneView = _gameSceneView;
@synthesize gameSceneMenuView = _gameSceneMenuView;
@synthesize steps = _steps;
@synthesize currentAlertView = _currentAlertView;
@synthesize moveCount = _moveCount;

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
    }
    return self;
}

- (void)dealloc
{
    MCRelease(_gameSceneView);
    MCRelease(_gameSceneMenuView);
    MCRelease(_steps);
    MCRelease(_currentAlertView);
    MCRelease(_resetAlertView);
    MCRelease(_passLevelAlertView);
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
        NSLog(@"invlid gate!!!!");
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

#pragma mark - Priate method
- (void)createSubViews
{
    self.gameSceneView = [[[MCGameSceneView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    MCGate *gate =  [[MCGate alloc] init];
    gate.passMin = 1;
    gate.passMoveCount = 1;
    gate.layout = [NSArray arrayWithObjects:@"2",@"0",@"0",@"3",@"1",@"0",@"2",@"3",@"0",@"3",@"1",@"1",@"2",@"0",@"2",@"4",@"1",@"2",@"1",@"3",@"2",@"1",@"3",@"3",@"1",@"1",@"4",@"1",@"2",@"4", nil];
    self.gameSceneView.theGate = gate;
    [gate release];
    
    [self.view addSubview:self.gameSceneView];
    
    self.gameSceneMenuView = [[[MCGameSceneMenuView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)] autorelease];
    self.gameSceneMenuView.delegate = self;
    [self.view addSubview:self.gameSceneMenuView];
    
    UIButton *back = [[UIButton alloc] init];
    UIImage *backImage = [UIImage imageNamed:@"back1.png"];
    back.frame = CGRectMake(10, 450, backImage.size.width, backImage.size.height);
    [back setBackgroundImage:backImage forState:UIControlStateNormal];
    [back setBackgroundImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    [back release]; 
    
    // 重置dialog
    _resetAlertView = [[MCResetAlertView alloc] init];
    _resetAlertView.delegate = self;
    _resetAlertView.tag = kAlertTagReset;
    
    _passLevelAlertView = [[MCAlertPassLevelView alloc] init];
    _passLevelAlertView.delegate = self;
    _passLevelAlertView.tag = kAlertTagPassLevel;
   
    //TODO::
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
    [_passLevelAlertView showAlertView];
}

- (void)resetAction:(id)sender
{
    [super buttonAction:sender];
    [_resetAlertView showAlertView];
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
    [self hideWindow];
    
    
    // 特殊的dialog的特殊代码
    if (view.tag == kAlertTagReset) {
        if (button.tag = kTagControlFirst) {
            // 如果是重置按钮， 则重置游戏
            
        }
    }
}

#pragma mark- GameSceneViewDelegate
- (void)movingBlockView:(BOOL)isMove
{
    self.gameSceneMenuView.btnUndo.userInteractionEnabled = isMove;
    self.gameSceneMenuView.btnReset.userInteractionEnabled = isMove;
}

#pragma mark - overWirte method
- (void) windowDidShow
{
    [super windowDidShow];
}

- (void)windowDidHide
{
    [super windowDidHide];
    if (self.currentAlertView == _resetAlertView) {
        [self showWindow];
        return;
    }
    
    if (self.currentAlertView == _passLevelAlertView) {
        [self showWindow];
        return;
    }
}

@end
