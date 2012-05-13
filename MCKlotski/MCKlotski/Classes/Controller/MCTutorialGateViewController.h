//
//  MCTutorialGateViewController.h
//  MCKlotski
//
//  Created by gtts on 5/12/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCGateViewController.h"

@class MCTutorialAlertView;
@class MCTutorialView;

@interface MCTutorialGateViewController : MCGateViewController{
    NSArray *_conditions;
    int _currentCondition;
    MCTutorialView *_tutorialView;
    MCTutorialAlertView *_tutorialAlertView;
    
    BOOL _isFirst;
}

@property (nonatomic, retain)NSArray *conditions;
@property (nonatomic, assign)int currentCondition;
@property (nonatomic, retain)MCTutorialAlertView *tutorialAlertView;
@property (nonatomic, retain)MCTutorialView *tutorialView;

@end
