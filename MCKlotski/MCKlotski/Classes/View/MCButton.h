//
//  MCButton.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-27.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCButtonBase.h"


@interface MCButton : MCButtonBase{
    
    UIImageView *_normalView;
    UIImageView *_hightlightView;
    UILabel *_normalLabel;
    UILabel *_highlightLabel;
    UIImageView *_normalBackgroundView;
    UIImageView *_highlightBackgroundView;
}

- (void) setImage:(UIImage *)image forState:(MCBUTTON_STATE)state;

- (void) setLabel:(UILabel *)label forState:(MCBUTTON_STATE)state;

- (void) setBackgroundImage:(UIImage *)image forState:(MCBUTTON_STATE)state;

@end