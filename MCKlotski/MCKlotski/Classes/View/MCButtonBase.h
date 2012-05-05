//
//  MCButtonBase.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-27.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kButtonStateNormal = 0, 
    kButtonStateHighLight,
}kButtonState;

@interface MCButtonBase : UIView{
    id _target;
    SEL _selector;
    
    BOOL _enabled;
}

@property (nonatomic, assign) id target;
@property (nonatomic, assign) BOOL enabled;

- (void)addTarget:(id)target action:(SEL)selector;

- (void)createNormalView;
- (void)createHighLightView;

@end
