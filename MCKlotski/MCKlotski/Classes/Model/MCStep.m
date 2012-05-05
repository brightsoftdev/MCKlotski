//
//  MCStep.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-26.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCStep.h"

@implementation MCStep

@synthesize blockID = _blockID;
@synthesize frameOld = _frameOld;
@synthesize isNewActiving = _isNewActiving;

- (id)initWithDictionary:(NSDictionary *)dict
{
    if ((self = [self initWithDictionary:dict])) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        int blockID = [[dict objectForKey:KeyBlockID] intValue];
        if (kInvaluableBlockID != blockID) {
            self.blockID = blockID;
        }
        self.frameOld = CGRectFromString([dict objectForKey:KeyFrameOld]);
        self.isNewActiving = [[dict objectForKey:KeyIsNewActiving] boolValue];

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super initWithCoder:coder];
    self.blockID = [coder decodeIntForKey:KeyBlockID];
    self.frameOld = CGRectFromString([coder decodeObjectForKey:KeyFrameOld]);
    self.isNewActiving = [coder decodeBoolForKey:KeyIsNewActiving];
    return self;
}

- (void)initAttributes
{
    self.blockID = kInvaluableBlockID;
    self.frameOld = CGRectZero;
    self.isNewActiving = NO;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    [coder encodeInt:self.blockID forKey:KeyBlockID];
    [coder encodeObject:NSStringFromCGRect(self.frameOld) forKey:KeyFrameOld];
    [coder encodeBool:self.isNewActiving forKey:KeyIsNewActiving];
}

- (void)dealloc
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

@end
