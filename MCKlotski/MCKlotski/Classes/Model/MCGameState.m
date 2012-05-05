//
//  MCGameState.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-26.
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
        //TODO::NSCODing
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super initWithCoder:coder];
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
