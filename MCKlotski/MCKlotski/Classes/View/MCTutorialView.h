//
//  MCTutorialView.h
//  MCKlotski
//
//  Created by gtts on 5/13/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCView.h"

@interface MCTutorialView : MCView{
    UIImageView *_arrowImageView;
    UIImageView *_rectImageView;
    NSArray *_conditions;
    NSTimer *_animationTimer;
    BOOL _isBlinkDown;
}

@property (nonatomic, retain)UIImageView *arrowImageView;
@property (nonatomic, retain)UIImageView *rectImageView;
@property (nonatomic, retain)NSArray *conditions;

- (void)startBlink;
- (void)stopBlink;

@end
