//
//  MCViewController.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCViewController.h"
#import "GGFoundation.h"
#import "MCUtil.h"


@implementation MCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [GGSoundManager sharedGGSoundManager].loadEffectArr = [NSArray arrayWithObjects:@"Click.wav", nil];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wantsFullScreenLayout = YES;
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:
                                 [UIImage imageNamed:@"background.png"]];
    [self refreshView];
}


- (void)viewDidUnload
{
    self.view.backgroundColor = [UIColor clearColor];
    [super viewDidUnload];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - public Method
- (void)refreshView
{
    UIButton *back = [[UIButton alloc] init];
    UIImage *backImage = [UIImage imageNamed:@"back1.png"];
    back.frame = CGRectMake(10, 30, backImage.size.width, backImage.size.height);
    [back setBackgroundImage:backImage forState:UIControlStateNormal];
    [back setBackgroundImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    [back release];  
}

- (void)ButtonAction:(id)sender
{
    [[GGSoundManager sharedGGSoundManager] playEffect:@"Click.wav"];
}
#define SHAnimationDuration 0.3
- (void) showWindow
{
    UIWindow *theWindow = [MCUtil window];
    theWindow.alpha = 0.4;
    [UIWindow beginAnimations:@"ShowWindowAnimation" context:nil];
    [UIWindow setAnimationDelegate:self];
    [UIWindow setAnimationDuration:SHAnimationDuration];
    [UIWindow setAnimationDidStopSelector:@selector(windowDidShow)];
    theWindow.alpha = 1.0;
    [UIWindow commitAnimations];
}

- (void) windowDidShow
{
    
}

- (void) hideWindow
{
    UIWindow *theWindow = [MCUtil window];
    theWindow.alpha = 0.7;
    [UIWindow beginAnimations:@"HideWindowAnimation" context:nil];
    [UIWindow setAnimationDelegate:self];
    [UIWindow setAnimationDuration:SHAnimationDuration];
    [UIWindow setAnimationDidStopSelector:@selector(windowDidHide)];
    theWindow.alpha = 0.4;
    [UIWindow commitAnimations];
}

- (void) windowDidHide
{
    
}

#pragma mark - private Method
- (void)backAction:(id)sender
{
    [self ButtonAction:sender];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
