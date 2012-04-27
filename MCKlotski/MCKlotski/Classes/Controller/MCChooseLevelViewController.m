//
//  MCChooseLevelViewController.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCChooseLevelViewController.h"

@implementation MCChooseLevelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    }
    return self;
}

- (void)dealloc
{
     NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}


@end
