//
//  MCResetAlertVlew.m
//  MCKlotski
//
//  Created by gtts on 5/6/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCResetAlertView.h"
#import "GGFoundation.h"

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
    
    FontLabel * lblContect = [[FontLabel alloc] initWithFrame:CGRectMake(0, 100, viewWidth, 40) 
                                                     fontName:@"方正卡通简体" 
                                                    pointSize:22];
    //[[UILabel alloc] initWithFrame:CGRectMake(0, 60, viewWidth, 40)];
    lblContect.text = @"您确定要重置本关吗？";
    lblContect.textColor = [UIColor yellowColor];
    lblContect.backgroundColor = [UIColor clearColor];
    lblContect.textAlignment = UITextAlignmentCenter;
    [self addSubview:lblContect];
    [lblContect release];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 140, 100, 20)];
    button.tag = kTagControlFirst;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"alert_reset.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(125, 140, 100, 20)];
    button2.tag = kTagControlSecond;
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"alert_cancel.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];
}

@end
