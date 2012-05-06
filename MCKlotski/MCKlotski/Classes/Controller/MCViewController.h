//
//  MCViewController.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCViewController : UIViewController

- (void)refreshView;

/**
 * button event, control sound
 */
- (void)buttonAction:(id)sender;

- (void)showWindow;
- (void)windowDidShow;
- (void)hideWindow;
- (void)windowDidHide;

@end
