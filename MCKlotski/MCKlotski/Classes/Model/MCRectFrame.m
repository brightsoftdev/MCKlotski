//
//  MCRectFrame.m
//  MCKlotski
//
//  Created by gtts on 12-4-25.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCRectFrame.h"

@implementation MCRectFrame

@synthesize frameX = _frameX;
@synthesize frameY = _frameY;
@synthesize frameWidth = _frameWidth;
@synthesize frameHeight = _frameHeight;
@synthesize frameRect = _frameRect;

#pragma mark - init & dealloc
- (id)initWithDictionary:(NSDictionary *)dict
{
    if ((self = [self initWithDictionary:dict])) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        self.frameX = [[dict objectForKey:KeyFrameX] floatValue];
        self.frameY = [[dict objectForKey:KeyFrameY] floatValue];
        self.frameWidth = [[dict objectForKey:KeyFrameWidth] floatValue];
        self.frameHeight = [[dict objectForKey:KeyFrameHeight] floatValue];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super initWithCoder:coder];
    self.frameX = [coder decodeFloatForKey:KeyFrameX];
    self.frameY = [coder decodeFloatForKey:KeyFrameY];
    self.frameWidth = [coder decodeFloatForKey:KeyFrameWidth];
    self.frameHeight = [coder decodeFloatForKey:KeyFrameHeight];
    return self;
}

- (void)initAttributes
{
	[self refreshWithRect:CGRectZero];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    [coder encodeFloat:self.frameX forKey:KeyFrameX];
    [coder encodeFloat:self.frameY forKey:KeyFrameY];
    [coder encodeFloat:self.frameWidth forKey:KeyFrameWidth];
    [coder encodeFloat:self.frameHeight forKey:KeyFrameHeight];
    [coder encodeObject:NSStringFromCGRect(self.frameRect) forKey:KeyFrameRect];
}

- (void)dealloc
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - property

- (CGRect)frameRect
{
    return CGRectMake(self.frameX, self.frameY, self.frameWidth, self.frameHeight);
}

- (void)refreshWithRect:(CGRect)rect
{
    self.frameX = rect.origin.x;
    self.frameY = rect.origin.y;
    self.frameWidth = rect.size.width;
    self.frameHeight = rect.size.height;
}

@end
