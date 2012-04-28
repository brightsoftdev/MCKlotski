//
//  MCViewController.m
//  Testes
//
//  Created by lim edwon on 12-4-21.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "TestViewController.h"
#import "MCButton.h"
#import "GGFoundation.h"
#import "MCSelectLevelButton.h"
#import "MCGate.h"

@implementation TestViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"项目功能测试";
    MCAlertPassLevelView *view = [[MCAlertPassLevelView alloc] init];
    //[view showAlertView];
    view.delegate = self;
    
    MCButton *button = [[MCButton alloc] initWithFrame:CGRectMake(10, 10, 200, 100)];
    [button addTarget:self action:@selector(ahhh:)];
    [button setImage:[UIImage imageNamed:@"back1.png"] forState:MCBUTTON_STATE_NORMAL];
    [button setBackgroundImage:[UIImage imageNamed:@"alert_bg.png"] forState:MCBUTTON_STATE_NORMAL];
    FontLabel *lable = [[FontLabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50) fontName:@"方正卡通简体.ttf" pointSize:18];
    lable.text = @"我去来个吗";
    [button setLabel:lable forState:MCBUTTON_STATE_NORMAL];
    [button setImage:[UIImage imageNamed:@"Icon.png"] forState:MCBUTTON_STATE_HIGHLIGHT];
    [button setBackgroundImage:[UIImage imageNamed:@"Default.png"] forState:MCBUTTON_STATE_HIGHLIGHT];
    FontLabel *lable2 = [[FontLabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50) fontName:@"方正卡通简体.ttf" pointSize:18];
     lable2.text = @"我去来个吗!!1";
    [button setLabel:lable2 forState:MCBUTTON_STATE_HIGHLIGHT];
    [self.view addSubview:button];
    
    MCSelectLevelButton *but = [[MCSelectLevelButton alloc] initWithFrame:CGRectMake(200, 100, 122, 200)];
    MCGate *gate = [[MCGate alloc] init];
    [but refreshWithGate:gate];
    [self.view addSubview:but];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)ahhh:(id)sender
{
    NSLog(@"------------");
}

- (void) alertView:(MCAlertView *)view andButton:(UIButton *)button
{
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
