//
//  MCBlock.h
//  MCKlotski
//
//  Created by gtts on 12-4-25.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCModel.h"

typedef enum {
    kBlockTypeInvalid = 0,
    kBlockTypeSmall,
    kBlockTypeNormalV,
    kBlockTypeNormalH,
    kBlockTypeLager,
    kBlockTypeMax,
}kBlockType;

@interface MCBlock : MCModel{
    int _blockID;
    int _positionX;
    int _positionY;
    BOOL _isLargeBlock;
    kBlockType _blockType;
}

@property (nonatomic, assign) int blockID;
@property (nonatomic, assign) int positionX;
@property (nonatomic, assign) int positionY;
@property (nonatomic, readonly) BOOL isLargeBlock;
@property (nonatomic, assign) kBlockType blockType;

- (UIImage *)blockImage;

@end
