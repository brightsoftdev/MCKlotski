//
//  MCTutorialView.m
//  MCKlotski
//
//  Created by gtts on 5/13/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCTutorialView.h"

#define kBlinkAniamtionInterval 0.01

@interface  MCTutorialView ()

- (void)createSubViews:(CGRect)frame;

- (void)refreshSubViews;

@end

@implementation MCTutorialView
@synthesize arrowImageView = _arrowImageView;
@synthesize rectImageView = _rectImageView;
@synthesize conditions = _conditions;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = NO;
        
        _isBlinkDown = YES;
        self.conditions = nil;
        
        [self createSubViews:frame];
    }
    return self;
}

- (void)dealloc
{
    [_animationTimer invalidate];
    [_animationTimer release];
    self.arrowImageView = nil;
    self.rectImageView = nil;
    self.conditions = nil;
    [super dealloc];
}

#pragma mark - set
- (void)setConditions:(NSArray *)conditions
{
    [_conditions release];
    _conditions = [conditions retain];
    
    [self refreshSubViews];
}

#pragma mark - public method
- (void)startBlink
{
    if (!_animationTimer) {
        _animationTimer = [NSTimer scheduledTimerWithTimeInterval:kBlinkAniamtionInterval
                                                           target:self 
                                                         selector:@selector(blinkAnimation:)
                                                         userInfo:nil 
                                                          repeats:YES];
        [_animationTimer fire];
    }
}

- (void)stopBlink
{
    if ([_animationTimer isValid]) {
        [_animationTimer invalidate];
        _animationTimer = nil;
    }
}

- (void)blinkAnimation:(id)sender
{
    if (_isBlinkDown) {
        self.arrowImageView.alpha -= kBlinkAniamtionInterval;
    }else {
        self.arrowImageView.alpha += kBlinkAniamtionInterval;
    }
    
    if (_isBlinkDown && self.arrowImageView.alpha <= 0.0) {
        self.arrowImageView.alpha = 0.0;
        _isBlinkDown = NO;
    }
    
    if (!_isBlinkDown && self.arrowImageView.alpha >= 1.0) {
        self.arrowImageView.alpha = 1.0;
        _isBlinkDown = YES;
    }
}

#pragma mark - private method
- (void)createSubViews:(CGRect)frame
{
    UIImageView *tipBox = [[UIImageView alloc] initWithFrame:
                           CGRectMake((self.frame.size.width - 200)/2.0, 30.0, 200, 110)];
    tipBox.backgroundColor = [UIColor clearColor];
    tipBox.contentMode = UIViewContentModeCenter;
    tipBox.image = [UIImage imageNamed:@"tipBox.png"];
    [self addSubview:tipBox];
    [tipBox release];
    
    UIImageView *tempRectImageView = [[UIImageView alloc] initWithFrame:
                                      CGRectMake(0, 0,  frame.size.width, frame.size.height)];
    tempRectImageView.backgroundColor = [UIColor clearColor];
    tempRectImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:tempRectImageView];
    self.rectImageView = tempRectImageView;
    [tempRectImageView release];
    
    UIImageView *tempArrowImageView = [[UIImageView alloc] initWithFrame:
                                       CGRectMake(0, 0, frame.size.width, frame.size.height)];
    tempArrowImageView.backgroundColor = [UIColor clearColor];
    tempArrowImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:tempArrowImageView];
    self.arrowImageView = tempArrowImageView;
    [tempArrowImageView release];
}

- (void)refreshSubViews
{
    if (!self.conditions) {
        return;
    }
    self.arrowImageView.image = [UIImage imageNamed:[self.conditions objectAtIndex:0]];
    CGPoint point1 = CGPointMake([[self.conditions objectAtIndex:1] floatValue], 
                                [[self.conditions objectAtIndex:2] floatValue]);
    self.arrowImageView.center = point1;
    
    self.rectImageView.image = [UIImage imageNamed:[self.conditions objectAtIndex:3]];
    CGPoint point2 = CGPointMake([[self.conditions objectAtIndex:4] floatValue],
                                 [[self.conditions objectAtIndex:5] floatValue]);
    self.rectImageView.center = point2;
}

@end
