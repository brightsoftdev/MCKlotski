//
//  MCSettings.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-25.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCModel.h"

@interface MCSettings : MCModel{
    BOOL _isSoundEnable;
    BOOL _isNeedTutorial;
}

@property (nonatomic, assign) BOOL isSoundEnable;
@property (nonatomic, assign) BOOL isNeedTutorial;

@end
