//
//  MCAlertView.h
//  MCKlotski
//
//  Created by gtts on 12-4-26.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCConfig.h"

typedef enum Control_Tag{
    kTagControlInvlid = 0,
    kTagControlFirst,
    kTagControlSecond,
    kTagControlThird,
    kTagControlCount,
}kTagControl;

@class MCAlertView;

@protocol MCAlertDelegate
  @optional
- (void)alertView:(MCAlertView *)view andButton:(UIButton *)button;

@end

@interface MCAlertView : UIView{
    id<MCAlertDelegate> _delegate;
    BOOL _isShowing;
  @protected
    UIView *_border;
}

@property (nonatomic, assign) id<MCAlertDelegate> delegate;
@property (nonatomic, readonly) BOOL isShowing;

- (void)showAlertView;

@end


