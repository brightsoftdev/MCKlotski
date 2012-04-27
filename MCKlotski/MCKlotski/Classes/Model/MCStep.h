//
//  MCStep.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-26.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCModel.h"

@interface MCStep : MCModel{
    int _blockID;
    CGRect _frameOld;
    BOOL _isNewActiving;
}

@property (nonatomic, assign)int blockID;
@property (nonatomic, assign)CGRect frameOld;
@property (nonatomic, assign)BOOL isNewActiving;

@end
