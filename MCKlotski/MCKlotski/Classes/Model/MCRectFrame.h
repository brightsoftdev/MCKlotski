//
//  MCRectFrame.h
//  MCKlotski
//
//  Created by gtts on 12-4-25.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCModel.h"

@interface MCRectFrame : MCModel{
    float _frameX;
    float _frameY;
    float _frameWidth;
    float _frameHeight;
}
@property (nonatomic, assign) float frameX;
@property (nonatomic, assign) float frameY;
@property (nonatomic, assign) float frameWidth;
@property (nonatomic, assign) float frameHeight;
@property (nonatomic, readonly) CGRect frameRect;

- (void)refreshWithRect:(CGRect)rect;

@end
