//
//  MCCustomGateViewController.m
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCCustomGateViewController.h"
#import "MCDataManager.h"
#import "MCGameState.h"
#import "MCGate.h"

@interface MCCustomGateViewController ()

- (void)showResumeAlert;

@end

@implementation MCCustomGateViewController

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
    NSLog(@"__MCCustomGateViewController");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma  mark - overwrite
- (void)resumeGame
{
    if (![[MCDataManager sharedMCDataManager].gameState isResumeWithGateID:self.theGateID]) {
        return;
    }
    [self showResumeAlert];
}

- (void)windowDidShow
{
    [super windowDidShow];
}

- (void)windowDidHide
{
    [super windowDidHide];
}

- (void)gotoNextLevel:(int)gateID
{
    [super gotoNextLevel:gateID];
    [self resetNextGateWithGateID:gateID];
}

- (void)levleDidPass
{
    [super levleDidPass];
}

#pragma mark - private method 
- (void)showResumeAlert
{
    [self showResetAlertView];
}

#pragma mark - delegate
- (void)alertView:(MCAlertView *)view andButton:(UIButton *)button
{
    [super alertView:view andButton:button];
}

@end
