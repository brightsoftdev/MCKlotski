//
//  MCGameState.m
//  MCKlotski
//
//  Created by gtts on 12-4-26.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCGameState.h"

@implementation MCGameState

@synthesize currentGateID = _currentGateID;
@synthesize moveCount = _moveCount;
@synthesize frames = _frames;
@synthesize steps = _steps;
@synthesize isFirstStep = _isFirstSetp;

- (id)initWithDictionary:(NSDictionary *)dict
{
    if ((self = [self initWithDictionary:dict])) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        if ([dict objectForKey:KeyCurrentGateId]) {
            self.currentGateID = [[dict objectForKey:KeyCurrentGateId] intValue];
        }
        self.moveCount = [[dict objectForKey:KeyMoveCount] intValue];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super initWithCoder:coder];
    self.currentGateID = [coder decodeIntForKey: KeyCurrentGateId];
    self.moveCount = [coder decodeIntForKey:KeyMoveCount];
    self.frames = [coder decodeObjectForKey:KeyFrames];
    self.steps = [coder decodeObjectForKey:KeySteps];
    self.isFirstStep = [coder decodeBoolForKey:KeyIsFirstStep];
    return self;
}

- (void)initAttributes
{
    self.currentGateID = 1;
    self.moveCount = 0;
    self.steps = [NSArray array];
    self.frames = [NSArray array];
    self.isFirstStep = YES;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    [coder encodeInt:self.currentGateID forKey:KeyCurrentGateId];
    [coder encodeInt:self.moveCount forKey:KeyMoveCount];
    [coder encodeObject:self.frames forKey:KeyFrames];
    [coder encodeObject:self.steps forKey:KeySteps];
    [coder encodeBool:self.isFirstStep forKey:KeyIsFirstStep];
}

- (void)dealloc
{
    MCRelease(_frames);
    MCRelease(_steps);
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - 
- (BOOL)isFirstStep
{
    if (self.currentGateID > 1) {
        return NO;
    } else {
        return ![self isResumeWithGateID:1];
    }
}

- (BOOL)isResumeWithGateID:(int)gateID
{
    if (self.currentGateID != gateID) {
        return NO; // 出现了错误
    }
    if ([self.steps count] > 0) {
        return YES;
    }
    return NO;
}

@end
