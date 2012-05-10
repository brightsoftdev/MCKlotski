//
//  MCResetAlertVlew.m
//  MCKlotski
//
//  Created by gtts on 5/6/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCResetAlertView.h"

@implementation MCResetAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

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
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    button.tag = kTagControlFirst;
    [button setTitle:@"重置" forState:UIControlStateNormal];
    [button setTitle:@"重置2" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"alert_continue.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 20)];
    button2.tag = kTagControlSecond;
    [button2 setTitle:@"取消" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];
}

@end
