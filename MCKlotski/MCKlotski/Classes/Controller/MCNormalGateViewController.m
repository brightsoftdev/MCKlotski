//
//  MCNormalGateViewController.m
//  MCKlotski
//
//  Created by gtts on 5/12/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCNormalGateViewController.h"
#import "MCDataManager.h"
#import "MCGameState.h"
#import "MCGate.h"
#import "MCRectFrame.h"

@interface MCNormalGateViewController ()

@end

@implementation MCNormalGateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"%@ : %@", NSStringFromSelector(_cmd), self);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - overWrite
- (void)resumeGame
{
    if (![[MCDataManager sharedMCDataManager].gameState isResumeWithGateID:self.theGateID]) {
        return;
    }
    self.moveCount = [MCDataManager sharedMCDataManager].gameState.moveCount;
    self.steps = [MCDataManager sharedMCDataManager].gameState.steps;
    if ([self.gameSceneView.blockViews count] != [MCDataManager sharedMCDataManager].gameState.frames.count) {
        NSLog(@"reset blockviews frames false");
        return;
    }
    for (int i = 0; i < self.gameSceneView.blockViews.count ; i++) {
        MCBlockView *blockView = [self.gameSceneView.blockViews objectAtIndex:i];
        MCRectFrame *rectFrame = [[MCDataManager sharedMCDataManager].gameState.frames objectAtIndex:i];
        blockView.frame = rectFrame.frameRect;
    }
}

- (void)gotoNextLevel:(int)gateID
{
    [super gotoNextLevel:gateID];
    MCGameState *gameState = [[MCGameState alloc] init];
    gameState.currentGateID = gateID;
    [MCDataManager sharedMCDataManager].gameState = gameState;
    [gameState release];
    
    [self resetNextGateWithGateID:gateID];
}

- (void)levleDidPass
{
    [super levleDidPass];
}

@end
