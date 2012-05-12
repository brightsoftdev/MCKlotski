//
//  MCGameSettingViewController.h
//  MCKlotski
//
//  Created by gtts on 5/12/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCViewController.h"
#import "MCAboutAlertView.h"

@interface MCGameSettingViewController : MCViewController<MCAlertDelegate> {
    MCAboutAlertView *_aboutAlertView;
}

@property (nonatomic, retain)MCAboutAlertView *aboutAlertView;

@end
