//
//  MCRectFrame.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-25.
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
        self.frameRect = CGRectFromString([dict objectForKey:KeyFrameRect]);
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
    self.frameRect = CGRectFromString([coder decodeObjectForKey:KeyFrameRect]);
    return self;
}

- (void)initAttributes
{
	self.frameRect = CGRectZero;
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
- (void)setFrameRect:(CGRect)frameRect
{
    self.frameRect = frameRect;
    self.frameX = frameRect.origin.x;
    self.frameY = frameRect.origin.y;
    self.frameWidth = frameRect.size.width;
    self.frameHeight = frameRect.size.height;
}

- (CGRect)frameRect
{
    return CGRectMake(self.frameX, self.frameY, self.frameWidth, self.frameHeight);
}

@end
