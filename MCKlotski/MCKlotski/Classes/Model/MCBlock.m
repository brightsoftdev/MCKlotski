//
//  MCBlock.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-25.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCBlock.h"

@implementation MCBlock

@synthesize blockID = _blockID;
@synthesize positionX = _positionX;
@synthesize positionY = _positionY;
@synthesize isLargeBlock = _isLargeBlock;
@synthesize blockType = _blockType;

- (id)initWithDictionary:(NSDictionary *)dict
{
    if ((self = [self initWithDictionary:dict])) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
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
    self.blockID = kInvaluableBlockID;
    self.positionX = 0;
    self.positionY = 0;
    self.blockType = kBlockTypeInvalid;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
}

- (void) dealloc
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];

}

#pragma mark - public Method
- (UIImage *)blockImage
{
    UIImage *image = nil;
    int random = arc4random();
    int index = random % 5;
    switch (self.blockType) {
        case kBlockTypeSmall:
            image = [UIImage imageNamed:[NSString stringWithFormat:@"block4%d.png", index]];
            break;
        case kBlockTypeNormalH:
            image = [UIImage imageNamed:[NSString stringWithFormat:@"block1%d.png",index]];
            CGImageRef imageRef = [image CGImage];
            image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:UIImageOrientationLeft];
            break;
        case kBlockTypeNormalV:
            image = [UIImage imageNamed:[NSString stringWithFormat:@"block1%d.png", index]];
            break;
        case kBlockTypeLager:
           image = [UIImage imageNamed:@"Default.png"];
            //image = [UIImage imageNamed:[NSString stringWithFormat:@"block2%d.png",index]];
            break;
        default:
            NSAssert(false, @"block's type is invalid!!!");
            break;
    }
    
    return image;
}

- (BOOL)isLargeBlock
{
    if (self.blockType == kBlockTypeLager) {
        return YES;
    }
    return NO;
}


@end
