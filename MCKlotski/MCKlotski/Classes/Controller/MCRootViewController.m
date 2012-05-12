//
//  MCRootViewController.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCRootViewController.h"
#import "MCChooseLevelViewController.h"
#import "MCGameSettingViewController.h"
#import "MCTutorialGateViewController.h"
#import "MCNormalGateViewController.h"
#import "MCConfig.h"
#import "GGFoundation.h"
#import "MCSettings.h"
#import "MCDataManager.h"
#import "MCGameState.h"

@interface MCRootViewController (Privates)

- (void)createSubViews;

- (UIButton *)addMenuWithRect:(CGRect)rect andImageNmaes:(NSArray *)imageNames action:(SEL)selector;

// 显示教程Controller
- (void)showTutorialViewController;

// 显示正常Controller
- (void)showNormalViewController;

- (void)refreshPlayButton;

@end

@implementation MCRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[MCDataManager sharedMCDataManager] addObserverWithTarget:self forState:kDataManageStateChange];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createSubViews];
    [self refreshPlayButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _btnPlay = nil;
}

- (void)dealloc
{
    MCRelease(_btnPlay);
    [[MCDataManager sharedMCDataManager] removeObserverWithTarget:self forState:kDataManageStateChange];
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}


#pragma mark - Private Method
- (void)createSubViews
{
    // 添加Logo
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    UIImageView *logoImageView = 
        [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, logoImage.size.width, logoImage.size.height)];
    logoImageView.image = logoImage;
    [self.view addSubview:logoImageView];
    [logoImageView release];
    
    // 添加tjutlogo
    logoImage = [UIImage imageNamed:@"tjutlogo.png"];
    CGRect tjutLogoRect = CGRectMake(5, 25, logoImage.size.width, logoImage.size.height);
    UIImageView *tjutLogoImageView = [[UIImageView alloc] initWithFrame:tjutLogoRect];
    tjutLogoImageView.image = logoImage;
    [self.view addSubview:tjutLogoImageView];
    [tjutLogoImageView release];
    
    
    UIImage *image = [UIImage imageNamed:@"menu_normal.png"];
    float width = image.size.width;
    float height = image.size.height;
    float left = ([GGUtil screenSize].width - width) * 0.5;
    float top = 210;
    float offset = 5;
    CGRect rect = CGRectMake(left, top, width, height);
    NSArray *imageNames = [NSArray arrayWithObjects:@"play_red.png", @"play_white.png", nil];
    _btnPlay = [[self addMenuWithRect:rect andImageNmaes:imageNames action:@selector(playAction:)] retain];
    [self.view addSubview:_btnPlay];
    
    // 添加选关按钮
    rect = CGRectMake(left , top + (offset + height) * 1, width, height);
    imageNames = [NSArray arrayWithObjects:@"select_red.png", @"select_white.png", nil];
    UIButton *btnSelectGate = [self addMenuWithRect:rect 
                                      andImageNmaes:imageNames 
                                             action:@selector(levelsAction:)];
    [self.view addSubview:btnSelectGate];
    
    // 添加游戏帮助按钮
    rect = CGRectMake(left, top + (offset + height) * 2, width, height);
    imageNames = [NSArray arrayWithObjects:@"game_help_red.png", @"game_help_white.png", nil];
    UIButton *btnHelp = [self addMenuWithRect:rect andImageNmaes:imageNames action:@selector(helpAction:)];
    [self.view addSubview:btnHelp];
    
    // 游戏设置按钮
    rect = CGRectMake(left, top + (offset + height) * 3, width, height);
    imageNames = [NSArray arrayWithObjects:@"gameSet_red.png", @"gameSet_white.png", nil];
    UIButton *btnSet = [self addMenuWithRect:rect andImageNmaes:imageNames action:@selector(setAction:)];
    [self.view addSubview:btnSet];
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

- (void)refreshPlayButton
{
    if ([[MCDataManager sharedMCDataManager].gameState isFirstStep]) {
        [_btnPlay setImage:[UIImage imageNamed:@"play_red.png"] forState:UIControlStateNormal];
        [_btnPlay setImage:[UIImage imageNamed:@"play_white.png"] forState:UIControlStateHighlighted];
    }else {
        [_btnPlay setImage:[UIImage imageNamed:@"resume_red.png"] forState:UIControlStateNormal];
        [_btnPlay setImage:[UIImage imageNamed:@"resume_white.png"] forState:UIControlStateHighlighted];
    }
}

- (void)showTutorialViewController
{
    MCTutorialGateViewController *tutorialViewController = [[MCTutorialGateViewController alloc] initWithGateID:0];
    [self.navigationController pushViewController:tutorialViewController animated:YES];
    [tutorialViewController release];
}

- (void)showNormalViewController
{
    int gateID = [MCDataManager sharedMCDataManager].gameState.currentGateID;
    NSLog(@"currentGateID:%d", gateID);
    MCNormalGateViewController *normalController = [[MCNormalGateViewController alloc] initWithGateID:gateID];
    [self.navigationController pushViewController:normalController animated:YES];
    [normalController release];
}

#pragma mark - action
- (void)playAction:(id)sender
{
    [super buttonAction:sender];
    
    if ([[MCDataManager sharedMCDataManager] isNeedTutorial]) {
        [self showTutorialViewController];
        [MCDataManager sharedMCDataManager].settings.isNeedTutorial = NO;
    }else {
        [self showNormalViewController];
    }
}

- (void)levelsAction:(id)sender
{
    [super buttonAction:sender];
    MCChooseLevelViewController *levelViewController = [[MCChooseLevelViewController alloc] init];
    [self.navigationController pushViewController:levelViewController animated:YES];
    [levelViewController release];
}

- (void)helpAction:(id)sender
{
    NSLog(@"help");
}

- (void)setAction:(id)sender
{
    [super buttonAction:sender];
    MCGameSettingViewController *gameSettingViewController = [[MCGameSettingViewController alloc] init];
    [self.navigationController pushViewController:gameSettingViewController animated:YES];
    [gameSettingViewController release];
}

#pragma mark - inherit super Class
- (void)refreshView
{}

#pragma mark - DataManagerObserver
- (void)updateDataWithState:(DataManageChange)dmData
{
    if (dmData == kDataManageStateChange) {
        [self refreshPlayButton];
        return;
    }
}

@end
