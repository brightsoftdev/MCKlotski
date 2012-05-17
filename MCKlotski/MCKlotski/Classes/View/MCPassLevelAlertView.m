//
//  MCPassLevelAlertView.m
//  MCKlotski
//
//  Created by gtts on 5/9/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCPassLevelAlertView.h"

@implementation MCPassLevelAlertView

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
    _star.image = [UIImage imageNamed:@"alert_better_star.png"];
    [self addSubview:_star];
    [_star release];
    
    UIImage *resumeImage = [UIImage imageNamed:@"alert_resume.png"];
    UIButton *button1 = [[UIButton alloc] initWithFrame:
                         CGRectMake(20,
                                    (self.frame.size.height - resumeImage.size.height - 20), 
                                    resumeImage.size.width, 
                                    resumeImage.size.height)];
    [button1 setBackgroundImage:resumeImage forState:UIControlStateNormal];
    button1.tag = kTagControlFirst;
    [button1 addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button1];
    [button1 release];
    
    
    UIImage *nextImage = [UIImage imageNamed:@"alert_next.png"];
    UIButton *button2 = [[UIButton alloc] initWithFrame:
                         CGRectMake(130,
                                    (self.frame.size.height - nextImage.size.height - 20), 
                                    nextImage.size.width, 
                                    nextImage.size.height)];
    [button2 setBackgroundImage:nextImage forState:UIControlStateNormal];
    button2.tag = kTagControlSecond;
    [button2 addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];
    [button2 release];
}

@end
