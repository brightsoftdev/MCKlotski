//
//  MCNewBestMoveAlertView.m
//  MCKlotski
//
//  Created by gtts on 5/9/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCNewBestMoveAlertView.h"

@implementation MCNewBestMoveAlertView

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
    
    
    UIImageView *_star = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 134)/2, (self.frame.size.height - 118-128), 133, 118)];
    _star.contentMode = UIViewContentModeCenter;
    _star.image = [UIImage imageNamed:@"alert_best_star.png"];
    [self addSubview:_star];
    [_star release];
    
    UIImage *buttonImage = [UIImage imageNamed:@"alert_continue.png"];
    UIButton *button = [[UIButton alloc] initWithFrame:
                        CGRectMake((self.frame.size.width - buttonImage.size.width) / 2,
                                   (self.frame.size.height - buttonImage.size.height - 20), 
                                   buttonImage.size.width, 
                                   buttonImage.size.height)];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button release];
}

@end
