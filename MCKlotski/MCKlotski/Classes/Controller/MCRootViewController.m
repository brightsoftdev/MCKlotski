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

@interface MCRootViewController (Privates)

- (void) createSubViews;

@end

@implementation MCRootViewController

@synthesize chooseLevelController = _chooseLevelController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self createSubViews];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
}

- (void) dealloc
{
    MCRelease(_btnPlay);
    MCRelease(_chooseLevelController);
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}


#pragma mark - Private Method
- (void) createSubViews
{
}

#pragma mark - inherit super Class
- (void)refreshView
{}

@end
