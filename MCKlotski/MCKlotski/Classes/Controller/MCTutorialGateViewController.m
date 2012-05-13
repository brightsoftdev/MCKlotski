//
//  MCTutorialGateViewController.m
//  MCKlotski
//
//  Created by gtts on 5/12/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCTutorialGateViewController.h"
#import "MCTutorialView.h"
#import "MCTutorialAlertView.h"
#import "MCGameSceneView.h"
#import "CJSONDeserializer.h"
#import "MCGate.h"
#import "GGFoundation.h"
#import "MCDataManager.h"
#import "MCGameState.h"

@interface MCTutorialGateViewController ()

- (void)showTutorialView;
- (void)hideTutorialView;
- (void)refreshTutorialView;

- (BOOL)isTutorialActing;

- (void)showTutorialAlertView;

- (BOOL)isTutorialBlockViewWith:(MCBlockView *)blockView;

- (void)resetConditionStateWith:(MCBlockView *)blockView;

- (BOOL)tutorialDidComplete:(MCBlockView *)blockView;

@end

@implementation MCTutorialGateViewController

@synthesize conditions = _conditions;
@synthesize currentCondition = _currentCondition;
@synthesize tutorialView = _tutorialView;
@synthesize tutorialAlertView = _tutorialAlertView;

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
    self = [super initWithGateID:gateID];
    if (self) {
        
        self.currentCondition = 0;
        _isFirst = YES;
    }
    return self;
}

- (void)dealloc
{
    MCRelease(_conditions);
    MCRelease(_tutorialAlertView);
    MCRelease(_tutorialView);    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.theGateID = 0;
    [self showTutorialView];
    [self refreshTutorialView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.conditions = nil;
    self.tutorialAlertView = nil;
    self.tutorialView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - set
- (void)setTheGateID:(int)theGateID
{
    if (0 == theGateID) {
        NSData *helpJsonData = [kTutorialLayout dataUsingEncoding:NSUTF32BigEndianStringEncoding];
        NSDictionary *helpDictionary = [[CJSONDeserializer deserializer] 
                                        deserializeAsDictionary:helpJsonData error:nil];
        NSLog(@"TutorialDictionary:%@", helpDictionary);
        MCGate *gate = [[MCGate alloc] initWithDictionary:helpDictionary];
        self.gameSceneView.theGate = gate;
        [gate release];
        
        NSData *helpConditions = [kTutorialCondition dataUsingEncoding:NSUTF32BigEndianStringEncoding];
        NSArray *gcons = (NSArray *)[[CJSONDeserializer deserializer] 
                                     deserializeAsArray:helpConditions error:nil];
        self.conditions = gcons;
        NSLog(@"helpConditions: %@", gcons);
        
        _theGateID = theGateID;
       [self refreshSubViews];
    }else {
        [super setTheGateID:theGateID];
    }
}

#pragma mark - private method
- (void)showTutorialView
{
    if (![self isTutorialActing]) {
        return;
    }
    if (!self.tutorialView) {
        self.tutorialView = [[[MCTutorialView alloc] initWithFrame:
                             CGRectMake(0,
                                        0,
                                        self.gameSceneView.theBoxView.frame.size.width,
                                        self.gameSceneView.theBoxView.frame.size.height)] autorelease];
    }
    if (!self.tutorialView.superview) {
        [self.gameSceneView.theBoxView addSubview:self.tutorialView];
    }
    [self.tutorialView startBlink];
}

- (void)hideTutorialView
{
    if (self.tutorialView.superview) {
        [self.tutorialView removeFromSuperview];
    }
    [self.tutorialView stopBlink];
}

- (void)refreshTutorialView
{
    if (![self isTutorialActing]) {
        [self hideTutorialView];
        return;
    }
    NSArray *array = [[self.conditions objectAtIndex:self.currentCondition] objectForKey:@"cover"];
    self.tutorialView.conditions = array;
}

- (BOOL)isTutorialActing
{
    if (self.currentCondition < 0) {
        return NO;
    }
    return YES;
}

- (void)showTutorialAlertView
{
    if (!self.tutorialAlertView) {
        self.tutorialAlertView = [[[MCTutorialAlertView alloc] init] autorelease];
        self.tutorialAlertView.delegate = self;
    }
    [self.tutorialAlertView showAlertView];
}

- (BOOL)isTutorialBlockViewWith:(MCBlockView *)blockView
{
    if (![self isTutorialActing]) {
        return NO;
    }
    int keyBlockViewId = [[[self.conditions objectAtIndex:self.currentCondition]
                           objectForKey:@"keyid"] intValue];
    if (blockView.blockID == keyBlockViewId) {
        return YES;
    }
    return NO;
}

- (void)resetConditionStateWith:(MCBlockView *)blockView
{
    if (![self tutorialDidComplete:blockView]) {
        return;
    }
    int tempVar = self.currentCondition;
    tempVar ++;
    tempVar = tempVar >= self.conditions.count ? -1 : tempVar;
    self.currentCondition = tempVar;
    
    [self refreshTutorialView];
}

- (BOOL)tutorialDidComplete:(MCBlockView *)blockView
{
    NSArray *rfs = (NSArray *)[[self.conditions objectAtIndex:self.currentCondition] objectForKey:@"rect"];
    CGRect frame = [MCBlockView frameWithBlockType:[[rfs objectAtIndex:0] intValue] 
                                         positionX:[[rfs objectAtIndex:1]intValue] 
                                         positionY:[[rfs objectAtIndex:2] intValue]];
    if (CGRectEqualToRect(frame, blockView.frame)) {
        return YES;
    }
    return NO;
}

#pragma mark - overWrite
- (void)gotoNextLevel:(int)gateID
{
    if (_isFirst) {
        _isFirst = NO;
        [self resetNextGateWithGateID:gateID];
    }else {
        [super gotoNextLevel:gateID];
    }
}

- (void)levleDidPass
{
    if (0 == self.theGateID) {
        [self showTutorialAlertView];
        [[GGSoundManager sharedGGSoundManager] playEffect:@"lifeadd.mp3"];
    }else {
        [super levleDidPass];
    }
}

- (void)alertView:(MCAlertView *)view andButton:(UIButton *)button
{
    [super alertView:view andButton:button];
}

- (void)windowDidShow
{
    [super windowDidShow];
}

- (void)windowDidHide
{
    [super windowDidHide];
    if (self.currentAlertView == self.tutorialAlertView) {
        [self gotoNextLevel:[MCDataManager sharedMCDataManager].gameState.currentGateID];
        [self showWindow];
        return;
    }
}

- (void)refreshButtons
{
    if ([self isTutorialActing]) {
        self.gameSceneMenuView.btnUndo.enabled = NO;
        self.gameSceneMenuView.btnReset.enabled = NO;
    }else {
        [super refreshButtons];
    }
}

- (BOOL)blockShouldMoveWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture
{
    if (![self isTutorialActing]) {
        return YES;
    }
    return [self isTutorialBlockViewWith:blockView];
}

- (void)blockFrameDidChangeWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture
{
    [super blockFrameDidChangeWith:blockView andGesture:blockGesture];
    if ([self isTutorialBlockViewWith:blockView]) {
        [self resetConditionStateWith:blockView];
    }
}

@end
