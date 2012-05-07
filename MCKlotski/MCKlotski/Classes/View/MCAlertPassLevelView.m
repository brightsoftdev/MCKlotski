//
//  MCAlertPassLevelView.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-26.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCAlertPassLevelView.h"

@implementation MCAlertPassLevelView

- (void)updateAlertFrame
{
    UIImage *alertBgImage = [UIImage imageNamed:@"alert_bg.png"];
    int viewWidth = alertBgImage.size.width;
    int viewHeight = alertBgImage.size.height;
    self.frame = CGRectMake((_border.frame.size.width - viewWidth) / 2, (_border.frame.size.height - viewHeight) / 2, viewWidth, viewHeight);
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    background.contentMode = UIViewContentModeCenter;
    background.image = alertBgImage;
    [self addSubview:background];
    [background release];
    
    UIImage *buttonImage = [UIImage imageNamed:@"alert_continue.png"];
    UIButton *button = [[UIButton alloc] initWithFrame:
                        CGRectMake((self.frame.size.width - buttonImage.size.width) / 2,
                                   (self.frame.size.height - buttonImage.size.height - 20), 
                                   buttonImage.size.width, 
                                   buttonImage.size.height)];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button release];
}

- (void)continueAction:(id)sender
{
    [super buttonAction:sender];
    [super hideAlertView];
}

@end
