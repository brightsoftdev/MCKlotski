//
//  MCButton.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-27.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCButton.h"

#define Index_Background 0
#define Index_image 1
#define Index_Label 2

@interface MCButton (Private)

- (void)removeViews; // 移除一些view

@end

@implementation MCButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    }
    return self;
}

- (void)dealloc
{
    [_normalView release];
    [_normalLabel release];
    [_normalBackgroundView release];
    [_highlightLabel release];
    [_hightlightView release];
    [_highlightBackgroundView release];
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - public method

- (void)setImage:(UIImage *)image forState:(kButtonState)state
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    switch (state) {
        case kButtonStateNormal:
            _normalView = [imageView retain];   
            break;
            
        case kButtonStateHighLight:
            _hightlightView = [imageView retain];
            break;
            
        default:
            NSAssert(false, @"button invalid state!!!");
            break;
    }
    [imageView release];
    [self createNormalView];
}

- (void)setLabel:(UILabel *)label forState:(kButtonState)state
{
    switch (state) {
        case kButtonStateNormal:
            _normalLabel = [label retain];
            break;
            
        case kButtonStateHighLight:
            _highlightLabel = [label retain];
            break;
            
        default:
            NSAssert(false, @"button invalid state!!!");
            break;
    }
    [self createNormalView];
}

- (void)setBackgroundImage:(UIImage *)image forState:(kButtonState)state
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    switch (state) {
        case kButtonStateNormal:
            _normalBackgroundView = [imageView retain];
            break;
            
        case kButtonStateHighLight:
            _highlightBackgroundView = [imageView retain];
            break;
            
        default:
            NSAssert(false, @"button invalid state!!!");
            break;
    }
    [imageView release];
    [self createNormalView];
}

#pragma mark - private method

- (void)initVariable
{
    if (!_hightlightView && _normalView) {
        _hightlightView = [_normalView retain];
    }
    if (!_highlightLabel && _normalLabel) {
        _highlightLabel = [_normalLabel retain];
    }
    if (!_highlightBackgroundView && _normalBackgroundView) {
        _highlightBackgroundView = [_normalBackgroundView retain];
    }
}

- (void)removeViews
{
    if (_normalView && _normalView.superview) {
        [_normalView removeFromSuperview];
    }
    if (_normalLabel && _normalLabel.superview) {
        [_normalLabel removeFromSuperview];
    }
    if (_normalBackgroundView && _normalBackgroundView.superview) {
        [_normalBackgroundView removeFromSuperview];
    }
    
    if (_hightlightView && _hightlightView.superview) {
        [_hightlightView removeFromSuperview];
    }
    if (_highlightLabel && _highlightLabel.superview) {
        [_highlightLabel removeFromSuperview];
    }
    if (_highlightBackgroundView && _highlightBackgroundView.superview) {
        [_highlightBackgroundView removeFromSuperview];
    }
}

- (void)createNormalView
{
    [self removeViews];
    // 添加背景
    if (_normalBackgroundView && !_normalBackgroundView.superview) {
        [self insertSubview:_normalBackgroundView atIndex:Index_Background];
    }
    // 添加前景
    if (_normalView && !_normalView.superview) {
        [self insertSubview:_normalView atIndex:Index_image];
    }
    // 添加文字
    if (_normalLabel && !_normalLabel.superview) {
        [self insertSubview:_normalLabel atIndex:Index_Label];
    }
}

- (void)createHighLightView
{
    [self removeViews];
    if (_highlightBackgroundView && !_highlightBackgroundView.superview) {
        [self insertSubview:_highlightBackgroundView atIndex:Index_Background];
    }
    if (_hightlightView && !_hightlightView.superview) {
        [self insertSubview:_hightlightView atIndex:Index_image];
    }
    if (_highlightLabel && !_highlightLabel.superview) {
        [self insertSubview:_highlightLabel atIndex:Index_Label];
    }
}

@end
