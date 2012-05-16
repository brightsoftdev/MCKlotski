//
//  MCChooseLevelViewController.h
//  MCKlotski
//
//  Created by gtts on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCViewController.h"
#import "MCDataManager.h"

@class GGPageControl;

@interface MCChooseLevelViewController : MCViewController<
  UIScrollViewDelegate, 
  UIAlertViewDelegate,
  DataManagerObserver
> {
  @private
    UIScrollView *_scrollView;
    GGPageControl *_pageControl;
    
    int _currentPage; // 当前页
    NSMutableArray *_gateButtons;
}

@property (nonatomic, retain) UIScrollView *scorllView;
@property (nonatomic, retain) GGPageControl *pageControl;

/**
 *此属性存放MCSelectLevelButton对象。每一项代表一个选关按钮
 */
@property (nonatomic, retain) NSMutableArray *gateButtons;

@end
