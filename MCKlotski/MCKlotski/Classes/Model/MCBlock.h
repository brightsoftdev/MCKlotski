//
//  MCBlock.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-25.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCModel.h"

typedef enum {
    BLOCK_TYPE_INVALID = 0,
    BLOCK_TYPE_SMALL,
    BLOCK_TYPE_NORMALV,
    BLOCK_TYPE_NORMALH,
    BLOCK_TYPE_LARGE,
    BLOCK_TYPE_MAX,
}BLOCK_TYPE;

@interface MCBlock : MCModel{
    int _blockID;
    int _positionX;
    int _positionY;
    BOOL _isLargeBlock;
    BLOCK_TYPE _blockType;
}

@property (nonatomic, assign) int blockID;
@property (nonatomic, assign) int positionX;
@property (nonatomic, assign) int positionY;
@property (nonatomic, readonly) BOOL isLargeBlock;
@property (nonatomic, assign) BLOCK_TYPE blockType;

- (UIImage *) blockImage;

@end
