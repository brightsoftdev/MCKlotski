//
//  MCGameSettingViewController.m
//  MCKlotski
//
//  Created by gtts on 5/12/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCGameSettingViewController.h"

@interface MCGameSettingViewController ()

@end

@implementation MCGameSettingViewController

@synthesize aboutAlertView = _aboutAlertView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.aboutAlertView = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // 添加Logo
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    UIImageView *logoImageView = 
    [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, logoImage.size.width, logoImage.size.height)];
    logoImageView.image = logoImage;
    [self.view addSubview:logoImageView];
    [logoImageView release];
    
    //声音设置
    UILabel *effectMusic = [[UILabel alloc] initWithFrame:CGRectMake(20, 280, 100, 20)];
    effectMusic.text = @"音效：";
    effectMusic.font = [UIFont boldSystemFontOfSize:18];
    effectMusic.backgroundColor = [UIColor clearColor];
    effectMusic.textAlignment = UITextAlignmentRight;
    effectMusic.adjustsFontSizeToFitWidth = YES; // 设置字体大小适应label宽度
    effectMusic.shadowColor = [UIColor whiteColor];
    effectMusic.shadowOffset = CGSizeMake(1.0, 1.0);
    [self.view addSubview:effectMusic];
    
    
    
    UILabel *backgroundMusic = [[UILabel alloc] initWithFrame:CGRectMake(20, 320, 100, 20)];
    backgroundMusic.text = @"音乐：";
    backgroundMusic.font = [UIFont boldSystemFontOfSize:18];
    backgroundMusic.backgroundColor = [UIColor clearColor];
    backgroundMusic.textAlignment = UITextAlignmentRight;
    backgroundMusic.adjustsFontSizeToFitWidth = YES; // 设置字体大小适应label宽度
    backgroundMusic.shadowColor = [UIColor whiteColor];
    backgroundMusic.shadowOffset = CGSizeMake(1.0, 1.0);
    [self.view addSubview:backgroundMusic];
    
    // 游戏关于
    UIImage *aboutImage = [UIImage imageNamed:@"about_red.png"];
    CGRect rect = CGRectMake(100, 100, aboutImage.size.width, aboutImage.size.height);
    NSArray *imageNames = [NSArray arrayWithObjects:@"about_red.png", @"about_white.png", nil];
    UIButton *btnAbout = [self addMenuWithRect:rect andImageNmaes:imageNames action:@selector(aboutAction:)];
    [self.view addSubview:btnAbout];
    
    self.aboutAlertView = [[MCAboutAlertView alloc] init];
    self.aboutAlertView.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.aboutAlertView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIButton *)addMenuWithRect:(CGRect)rect andImageNmaes:(NSArray *)imageNames action:(SEL)selector  
{
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    UIImage *image = nil;
    image = [UIImage imageNamed:NSLocalizedString([imageNames objectAtIndex:0], @"normal image")];
    [button setImage:image forState:UIControlStateNormal];
    image = [UIImage imageNamed:NSLocalizedString([imageNames objectAtIndex:1], @"highlight image")];
    [button setImage:image forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"menu_normal.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"menu_highlighted.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return [button autorelease];
}

- (void)aboutAction:(id)sender
{
    [self.aboutAlertView laodContent];
    [self.aboutAlertView showAlertView];
}

#pragma mark - delegate 
- (void)alertView:(MCAlertView *)view andButton:(UIButton *)button
{
    
}

@end
