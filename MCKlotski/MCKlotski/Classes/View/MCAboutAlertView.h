//
//  MCAboutAlertView.h
//  MCKlotski
//
//  Created by gtts on 5/12/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCAlertView.h"

@interface MCAboutAlertView : MCAlertView<UIWebViewDelegate> {
    UIWebView *_aboutWebView;
}

@property (nonatomic, retain) UIWebView *aboutWebView;

- (void)laodContent;

@end
