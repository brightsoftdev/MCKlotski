//
//  TestRootViewController.m
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "TestRootViewController.h"
#import "TestBlockViewController.h"
#import "TestDisplayViewController.h"

@interface TestRootViewController ()

@end

@implementation TestRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"项目功能测试";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)blockView:(id)sender
{
    TestBlockViewController *viewController = [[TestBlockViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

- (IBAction)displayView:(id)sender
{
    TestDisplayViewController *viewController = [[TestDisplayViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

@end
