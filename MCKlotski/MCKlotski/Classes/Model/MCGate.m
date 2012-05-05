//
//  MCGate.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCGate.h"

#define kInvalidGateID -1

@implementation MCGate

@synthesize gateID = _gateID;
@synthesize passMin = _passMin;
@synthesize passMoveCount = _passMoveCount;
@synthesize isLocked = _isLocked;
@synthesize layout = _layout;

- (id)initWithDictionary:(NSDictionary *)dict
{
    if ((self = [self initWithDictionary:dict])) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        int gateid = [[dict objectForKey:KeyGateID] intValue];
        if (kInvalidGateID != gateid) {
            self.gateID = gateid;
        }
        self.passMin = [[dict objectForKey:KeyPassMin] intValue];
        self.passMoveCount = [[dict objectForKey:KeyPassMoveCount] intValue];
        self.isLocked = [[dict objectForKey:KeyLocked] boolValue];
        self.layout = [dict objectForKey:KeyLayout];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super initWithCoder:coder];
    self.gateID = [coder decodeIntForKey:KeyGateID];
    self.passMin = [coder decodeIntForKey:KeyPassMin];
    self.passMoveCount = [coder decodeIntForKey:KeyPassMoveCount];
    self.isLocked = [coder decodeBoolForKey:KeyLocked];
    self.layout = [coder decodeObjectForKey:KeyLayout];
    return self;
}

- (void)initAttributes
{
    self.gateID = kInvalidGateID;
    self.passMin = 0;
    self.passMoveCount = 0;
    self.isLocked = YES;
    self.layout = nil;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    [coder encodeInt:self.gateID forKey:KeyGateID];
    [coder encodeInt:self.passMin forKey:KeyPassMin];
    [coder encodeInt:self.passMoveCount forKey:KeyPassMoveCount];
    [coder encodeBool:self.isLocked forKey:KeyLocked];
    [coder encodeObject:self.layout forKey:KeyLayout];
}

- (void)dealloc
{
    self.layout = nil;
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - overWrite
- (void)refreshWithModel:(MCModel *)model
{
    [super refreshWithModel:model];
    MCGate *gate = (MCGate *)model;
    self.gateID = gate.gateID;
    self.passMin = gate.passMin;
    self.passMoveCount = gate.passMoveCount;
    self.isLocked = gate.isLocked;
    self.layout = gate.layout;
}

#pragma mark - Public Method
+ (MCGate *)invalidGateWithId:(int)gateId
{
    MCGate *gate = [[[MCGate alloc] init] autorelease];
    gate.gateID = gateId;
    gate.passMin = 0;
    gate.passMoveCount = 0;
    gate.isLocked = YES;
    gate.layout = [NSArray array];
    return gate;
}

- (BOOL)isInvalidGate
{
    if (self.gateID < 0) {
        return YES;
    }
    return NO;
}

- (BOOL)checkNewRecord:(int)stepCount
{
    if (stepCount <= self.passMin) {
        self.passMin = stepCount;
        return YES;
    }
    return NO;
}

@end
