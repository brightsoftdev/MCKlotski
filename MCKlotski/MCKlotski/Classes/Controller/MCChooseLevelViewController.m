//
//  MCChooseLevelViewController.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCChooseLevelViewController.h"
#import "MCDataManager.h"
#import "MCSelectLevelButton.h"
#import "MCCustomGateViewController.h"
#import "MCGate.h"

#define ROW_SUM 6
#define COLUMN_SUM 5


@interface MCChooseLevelViewController (Privates)

- (void)createSubViews;
- (void)removeSubViews;

- (void)createGateButtons;
- (void)scrollAndPageConfig;

// 设置Scroll的背景
- (void)loadScrollBackground;

// 载入选关按钮
- (void)loadSelectButtons;

- (void)loadScrollTitle;

// 改变页的事件
- (void)changePage:(id)sender;

// 点击选关按钮的事件
- (void)selectGateAction:(id)sender;


@end

@implementation MCChooseLevelViewController

@synthesize scorllView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize gateButtons = _gateButtons;

#pragma mark - initialization & dealloc
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        _currentPage = 0;
        self.gateButtons = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc
{
    [_scrollView release];
    _scrollView = nil;
    [_pageControl release];
    _pageControl = nil;
    [_gateButtons release];
    _gateButtons = nil;
     NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createSubViews];
    [self createGateButtons];
    [self scrollAndPageConfig];
    [self loadScrollBackground];
    [self loadSelectButtons];
    [self loadScrollTitle];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self removeSubViews];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float pageWidth = self.scorllView.frame.size.width; 
    int page = floorf((self.scorllView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"%f--", self.scorllView.contentOffset.x);
    _currentPage = page;
    self.pageControl.currentPage = page;
}

#pragma mark - Private method
- (void)createSubViews
{
    // create UIScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 70, 300, 300)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    
    // create UIPageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _scrollView.frame.origin.y + _scrollView.frame.size.height, 320, 20)];
    _pageControl.currentPage = 0;
    _pageControl.backgroundColor = [UIColor clearColor];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
}

- (void) removeSubViews
{
    self.scorllView = nil;
    self.pageControl = nil;
}

- (void)createGateButtons
{
    NSMutableArray *gates_ = [NSMutableArray array];
    for (int i = 0 ; i < 150; ++i) {
        MCGate *gate = [[MCGate  alloc] init];
        gate.isLocked = NO;
        [gates_ addObject:gate];        
    }
    [MCDataManager sharedMCDataManager].gates = gates_;
    
    int gateCount = [MCDataManager sharedMCDataManager].gates.count;
    for (int i = 0; i < gateCount; i++) {
        MCSelectLevelButton *gateButton = [[MCSelectLevelButton alloc] initWithFrame:CGRectMake(0, 0, 53, 53)];
        gateButton.backgroundColor = [UIColor clearColor];
        gateButton.index = i + 1;
        gateButton.gate = [[MCDataManager sharedMCDataManager].gates objectAtIndex:i];
        [gateButton addTarget:self action:@selector(selectGateAction:)];
        [gateButton refreshWithGate:[[MCDataManager sharedMCDataManager].gates objectAtIndex:i]];
        [self.gateButtons addObject:gateButton];
        [gateButton release];
    }
}

- (void)scrollAndPageConfig
{
    int btnCount = [self.gateButtons count];
    int pageNum = btnCount / (ROW_SUM * COLUMN_SUM);
    if (btnCount % (ROW_SUM * COLUMN_SUM) > 0) {
        pageNum ++;
    }
    
    self.scorllView.contentSize = CGSizeMake(self.scorllView.frame.size.width * pageNum, self.scorllView.frame.size.height);
    self.pageControl.numberOfPages = pageNum;
}

- (void)loadScrollBackground
{
    //TODO:: loadScrollBackground
}

- (void)loadSelectButtons
{
    // 每页选关button总数
    int perPageCount = ROW_SUM * COLUMN_SUM;
    
    int page = 1;
    int num = 0;
    int row = 0;
    int column = 0;
    
    for (MCSelectLevelButton *btnSelect in self.gateButtons) {
        page = num/ perPageCount + 1;
        row = num / COLUMN_SUM - (page - 1) * ROW_SUM;
        column = num % COLUMN_SUM + num / perPageCount * COLUMN_SUM; 
        int btnWidth = btnSelect.frame.size.width;
        int btnHeight = btnSelect.frame.size.height;
        btnSelect.frame = CGRectMake(btnWidth * column , btnHeight * row, btnWidth, btnHeight);
        [self.scorllView addSubview:btnSelect];
        num ++ ;
    }
}

- (void)loadScrollTitle
{
    //TODO:: loadScrollTitle
}

- (void)changePage:(id)sender
{
    int page = self.pageControl.currentPage;
    CGRect theFrame = self.scorllView.frame;
    theFrame.origin.x = theFrame.size.width * page;
    theFrame.origin.y = 0;
    [self.scorllView scrollRectToVisible:theFrame animated:YES]; // 仅仅显示指定区域的内容
}

- (void)selectGateAction:(id)sender
{
    [super buttonAction:sender];
    MCSelectLevelButton *selectButton = (MCSelectLevelButton *)sender;
    MCCustomGateViewController *customGateViewController = [[MCCustomGateViewController alloc] init];
    NSLog(@"------------");
    [self.navigationController pushViewController:customGateViewController animated:YES];
    [customGateViewController release];
}

@end
