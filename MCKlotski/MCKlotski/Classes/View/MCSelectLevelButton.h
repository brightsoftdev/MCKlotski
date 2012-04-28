//
//  MCSelectLevelButton.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-27.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCButtonBase.h"

@class MCGate;

@interface MCSelectLevelButton : MCButtonBase{
    MCGate *_gate;
    int _index;
    
    UIView *_highlightView;
    
    UIImageView *_backgroundView;
    UIImageView *_flagView;
    UILabel *_lblNumber;
}

@property (nonatomic, retain) MCGate *gate;
@property (nonatomic, assign) int index;
@property (nonatomic, retain) UIView *highlightView;
@property (nonatomic, retain) UIImageView *backgroundView;
@property (nonatomic, retain) UIImageView *flagView;
@property (nonatomic, retain) UILabel *lblNumber;

- (void) refreshWithGate:(MCGate *)gate;

@end
