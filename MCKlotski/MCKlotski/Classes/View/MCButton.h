//
//  MCButton.h
//  MCKlotski
//
//  Created by gtts on 12-4-27.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCButtonBase.h"


@interface MCButton : MCButtonBase{
  @private
    UIImageView *_normalView;
    UIImageView *_hightlightView;
    UILabel *_normalLabel;
    UILabel *_highlightLabel;
    UIImageView *_normalBackgroundView;
    UIImageView *_highlightBackgroundView;
}

- (void)setImage:(UIImage *)image forState:(kButtonState)state;

- (void)setLabel:(UILabel *)label forState:(kButtonState)state;

- (void)setBackgroundImage:(UIImage *)image forState:(kButtonState)state;

@end