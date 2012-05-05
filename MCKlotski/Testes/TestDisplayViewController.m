//
//  TestDisplayViewController.m
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "TestDisplayViewController.h"
#import "MCButton.h"
#import "GGFoundation.h"
#import "MCSelectLevelButton.h"
#import "MCGate.h"
#import "MCNumberView.h"

@interface TestDisplayViewController ()

@end

@implementation TestDisplayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"界面上显示的内容";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MCButton *button = [[MCButton alloc] initWithFrame:CGRectMake(10, 10, 200, 100)];
    [button addTarget:self action:@selector(customAction:)];
    [button setImage:[UIImage imageNamed:@"back1.png"] forState:kButtonStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"Icon.png"] forState:kButtonStateNormal];
    FontLabel *lable = [[FontLabel alloc] initWithFrame:CGRectMake(0, 50, 200, 50) fontName:@"方正卡通简体.ttf" pointSize:18];
    lable.text = @"custom button";
    [button setLabel:lable forState:kButtonStateNormal];
    [button setImage:[UIImage imageNamed:@"back2.png"] forState:kButtonStateHighLight];
    [button setBackgroundImage:[UIImage imageNamed:@"alert_bg.png"] forState:kButtonStateHighLight];
    FontLabel *lable2 = [[FontLabel alloc] initWithFrame:CGRectMake(0, 50, 200, 50) fontName:@"方正卡通简体.ttf" pointSize:18];
    lable2.text = @"自定义按钮";
    [button setLabel:lable2 forState:kButtonStateHighLight];
    [self.view addSubview:button];
    
    MCSelectLevelButton *but = [[MCSelectLevelButton alloc] initWithFrame:CGRectMake(200, 100, 122, 200)];
    MCGate *gate = [[MCGate alloc] init];
    [but refreshWithGate:gate];
    [but addTarget:self action:@selector(test:)];
    [self.view addSubview:but];
    
    MCNumberView *numberView = [[MCNumberView alloc] initWithFrame:CGRectMake(200, 150, 50, 20)];
    numberView.value = 150;
    numberView.numberType = NumberRGBYellow;
    [self.view addSubview:numberView];
}

- (void)customAction:(id)sender
{
    MCAlertPassLevelView *view = [[MCAlertPassLevelView alloc] init];
    [view showAlertView];
    view.delegate = self;
}

- (void)alertView:(MCAlertView *)view andButton:(UIButton *)button
{
    
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

@end
