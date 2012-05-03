//
//  MCNumberView.m
//  MCKlotski
//
//  Created by gtts on 5/3/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCNumberView.h"
#import "MCUtil.h"

#define MinNumberDigit 2

@interface MCNumberView(Privates)

- (NSArray *) createNumberImages;

// 计算数字的位数
- (int) digit;

- (void) refreshImages;

- (UIImage *)redNumberImageWithNumber:(int)num;
- (UIImage *)whiteNumberImageWithNumber:(int)num;
- (UIImage *)grayNumberImageWithNumber:(int)num;
- (UIImage *)yellowNumberImageWithNumber:(int)num;

@end

@implementation MCNumberView

@synthesize numberType = _numberType;
@synthesize numberImages = _numberImages;
@synthesize value = _value;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        self.backgroundColor = [UIColor clearColor];
        self.numberImages = nil;
        _digit = 0;
        self.value = 0;
    }
    return self;
}

- (void) dealloc
{
    MCRelease(_numberImages);
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - set and refresh
- (void) setValue:(int)value
{
    _value = value;
    int theDigit = [self digit];
    
    if (theDigit != _digit) {
        _digit = theDigit;
        [MCUtil clearAllSubViewsWith:self];
        self.numberImages = [self createNumberImages];
    }
    [self refreshImages];
}

- (void) setNumberType:(NumberRBGType)numberType
{
    _numberType = numberType;
    [self refreshImages];
}

#pragma mark - Privates method
- (NSArray *) createNumberImages
{
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:10];
    float x = 0.0;
    float y = 0.0;
    float width = self.frame.size.width / _digit;
    float height = self.frame.size.height;
    float space = width / 20.0;
    for (int i = 0; i < _digit; ++i) {
        x = self.frame.size.width - (i+1) * width + space;
        y = space;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, (width - 2 * space), (height - 2 * space))];
        imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView];
        [images addObject:imageView];
        [imageView release];
    }
    return images;
}

- (int) digit
{
    // 判断value是几位数
    int num = 0;
    int theValue = self.value;
    int index = 1;
    do {
        index *= 10;
        theValue -= theValue % index;
        num ++;
    } while (theValue > 0);
    num = num > MinNumberDigit ? num : MinNumberDigit; // 最少要MinNumberDigit位
    return num;
}

- (void) refreshImages
{
    
}

- (UIImage *) redNumberImageWithNumber:(int)num
{
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"red_%d", num]];
    return image;
}

- (UIImage *) whiteNumberImageWithNumber:(int)num
{
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"white_%d", num]];
    return image;
}

- (UIImage *) grayNumberImageWithNumber:(int)num
{
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"gray_%d", num]];
    return image;
}

- (UIImage *) yellowNumberImageWithNumber:(int)num
{
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"yellow_%d", num]];
    return image;
}

@end
