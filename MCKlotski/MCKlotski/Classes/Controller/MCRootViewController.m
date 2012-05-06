//
//  MCRootViewController.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCRootViewController.h"
#import "MCChooseLevelViewController.h"
#import "MCConfig.h"
#import "GGFoundation.h"

@interface MCRootViewController (Privates)

- (void)createSubViews;

- (UIButton *)addMenuWithRect:(CGRect)rect andImageNmaes:(NSArray *)imageNames action:(SEL)selector;


@end

@implementation MCRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createSubViews];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _btnPlay = nil;
}

- (void)dealloc
{
    MCRelease(_btnPlay);
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}


#pragma mark - Private Method
- (void)createSubViews
{
    UIImage *image = [UIImage imageNamed:@"menu_normal.png"];
    float width = image.size.width;
    float height = image.size.height;
    float left = ([GGUtil screenSize].width - width) * 0.5;
    float top = 50;
    float offset = 5;
    CGRect rect = CGRectMake(left, top, width, height);
    NSArray *imageNames = [NSArray arrayWithObjects:@"play_red.png", @"play_white.png", nil];
    _btnPlay = [[self addMenuWithRect:rect andImageNmaes:imageNames action:@selector(playAction:)] retain];
    [self.view addSubview:_btnPlay];
    
    // 添加选关按钮
    rect = CGRectMake(left , top + offset + height, width, height);
    imageNames = [NSArray arrayWithObjects:@"play_red.png", @"play_white.png", nil];
    [self.view addSubview:[self addMenuWithRect:rect andImageNmaes:imageNames action:@selector(levelsAction:)]];
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

#pragma mark - action
- (void)playAction:(id)sender
{
    [super buttonAction:sender];
    NSLog(@"fasd");
}

- (void)levelsAction:(id)sender
{
    [super buttonAction:sender];
    MCChooseLevelViewController *levelViewController = [[MCChooseLevelViewController alloc] init];
    [self.navigationController pushViewController:levelViewController animated:YES];
    [levelViewController release];
}

#pragma mark - inherit super Class
- (void)refreshView
{}

@end
