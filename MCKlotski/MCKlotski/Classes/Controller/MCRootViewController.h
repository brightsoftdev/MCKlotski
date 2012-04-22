//
//  MCRootViewController.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCViewController.h"


@class MCChooseLevelViewController;

@interface MCRootViewController : MCViewController{
    UIButton *_btnPlay;
}

@property (nonatomic, retain) MCChooseLevelViewController *chooseLevelController;

@end
