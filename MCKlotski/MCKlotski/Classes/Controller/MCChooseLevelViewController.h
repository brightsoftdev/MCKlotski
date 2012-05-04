//
//  MCChooseLevelViewController.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCViewController.h"

@interface MCChooseLevelViewController : MCViewController
<UIScrollViewDelegate, UIAlertViewDelegate>{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    int _currentPage; // 当前页
    NSMutableArray *_gateButtons;
}

@property (nonatomic, retain) UIScrollView *scorllView;
@property (nonatomic, retain) UIPageControl *pageControl;

/**
 *此属性存放MCSelectLevelButton对象。每一项代表一个选关按钮
 */
@property (nonatomic, retain) NSMutableArray *gateButtons;

@end
