//
//  MCAlertView.m
//  MCKlotski
//
//  Created by gtts on 12-4-26.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCAlertView.h"
#import "MCUtil.h"
#import "GGFoundation.h"

#define kTransitionDuration 0.2

@interface MCAlertView (Private)

- (void)updateAlertFrame;

- (void)showAnimation;

- (void)hideAlertView;
- (void)hideAnimation;

@end

@implementation MCAlertView

@synthesize delegate = _delegate;
@synthesize isShowing = _isShowing;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        self.alpha = 1.0f;
        self.backgroundColor = [UIColor clearColor];
        _border = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [MCUtil window].frame.size.width, [MCUtil window].frame.size.height)];
        _border.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
        [_border addSubview:self];
        _isShowing = NO;
        self.userInteractionEnabled = NO;
        [self updateAlertFrame];
    }
    return self;
}

- (void)dealloc
{
    MCRelease(_border);
     NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - public method
- (void)showAlertView
{
    if (self.isShowing) {
        // 已经显示了
        return;
    }
    [[MCUtil window] addSubview:_border];
    [self showAnimation];
}

#pragma mark - Private method
- (void)hideAlertView
{
    if (!self.isShowing) {
        return;
    }
    [self hideAnimation];
}

- (void)updateAlertFrame
{}

- (void)showAnimation
{
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.65, 0.65);
    [UIView beginAnimations:@"AlertShowAnimation" context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(showAnimationStep1)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.15, 1.15);
    [UIView commitAnimations];
}
- (void)showAnimationStep1 {
	[UIView beginAnimations:@"GOAlertShowAnimation" context:nil];
	[UIView setAnimationDuration:kTransitionDuration/2.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(showAnimationStep2)];
	self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85, 0.85);
	[UIView commitAnimations];
}
- (void)showAnimationStep2 {
	[UIView beginAnimations:@"GOAlertShowAnimation" context:nil];
	[UIView setAnimationDuration:kTransitionDuration/2.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(showAnimationStep3)];
	self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.05, 1.05);
	[UIView commitAnimations];
}
- (void)showAnimationStep3 {
	[UIView beginAnimations:@"GOAlertShowAnimation" context:nil];
	[UIView setAnimationDuration:kTransitionDuration/2.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(showAnimationDidStop)];
	self.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];
}
- (void)showAnimationDidStop
{
	_isShowing = YES;
    self.userInteractionEnabled = YES;
}

- (void)hideAnimation
{
    [UIView beginAnimations:@"HideAlertAnimation" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(hideAnimationDidStop)];
	[UIView setAnimationDuration:kTransitionDuration/1.5];
	self.alpha = 0.0;
	[UIView commitAnimations];
}
- (void)hideAnimationDidStop
{
	_isShowing = NO;	
	[_border removeFromSuperview];
	self.alpha = 1.0;
}

- (void)performAction:(id)sender
{
    UIButton *button  = (UIButton *)sender;
    if (self.delegate) {
        [[GGSoundManager sharedGGSoundManager] playEffect:@"Clcik.wav"];
        [self.delegate alertView:self andButton:button];
        [self hideAlertView];
    }
}

@end
