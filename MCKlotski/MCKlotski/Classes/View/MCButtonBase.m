//
//  MCButtonBase.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-27.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCButtonBase.h"

@interface MCButtonBase (Private)

- (void) buttonTapDown;
- (void) buttonTapUp;

- (void) refreshButtonViewWith:(MCBUTTON_STATE)state;
- (void) initVariable;

- (void) performAction;

@end

@implementation MCButtonBase

@synthesize enabled = _enabled;
@synthesize target = _target;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) dealloc
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

- (void) setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    self.userInteractionEnabled = _enabled;
}

#pragma mark - ViewDelegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self buttonTapDown];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self performAction];
    [self buttonTapUp];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self buttonTapUp];
}

#pragma mark - public method
- (void) addTarget:(id)target action:(SEL)selector
{
    self.target = target;
    _selector = selector;
}

#pragma mark - private method
- (void) buttonTapDown
{
    [self initVariable];
    [self refreshButtonViewWith:MCBUTTON_STATE_HIGHLIGHT];
}

- (void) buttonTapUp
{
    [self refreshButtonViewWith:MCBUTTON_STATE_NORMAL];
}

- (void) refreshButtonViewWith:(MCBUTTON_STATE)state
{
    switch (state) {
        case MCBUTTON_STATE_NORMAL:
            [self createNormalView];
            break;
            
        case MCBUTTON_STATE_HIGHLIGHT:
            [self createHighLightView];
            break;
            
        default:
            NSAssert(false, @"button invalid state!!!");
            break;
    }
}

- (void)initVariable
{

}

- (void)createNormalView
{
    
}

- (void)createHighLightView
{
    
}

- (void) performAction
{
    if (!self.target) {
        return;
    }
    if ([self.target respondsToSelector:_selector]) {
        [self.target performSelector:_selector withObject:self];
    }
}

@end
