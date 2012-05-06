//
//  MCGateViewController.m
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCGateViewController.h"
#import "MCGameSceneView.h"
#import "MCGameSceneMenuView.h"
#import "MCConfig.h"
#import "GGFoundation.h"
#import "MCGate.h"
#import "MCStep.h"


@interface MCGateViewController (Privates)

- (void)createSubViews;
- (void)removeSubViews;

@end

@implementation MCGateViewController
@synthesize theGateID = _theGateID;
@synthesize gameSceneView = _gameSceneView;
@synthesize gameSceneMenuView = _gameSceneMenuView;
@synthesize steps = _steps;

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
    NSLog(@"%@ : %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createSubViews];
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

#pragma mark - GameSceneMenuDelegate
- (void)undoAction:(id)sender
{
    [super buttonAction:sender];
    if (self.steps.count > 0) {
        // 说明已经移动了block，能执行undo操作
        _moveFlag = kBlockViewMoveUndo;
        MCStep *step = [self.steps lastObject];
        
    }
}

- (void)resetAction:(id)sender
{
    [super buttonAction:sender];
}

@end
