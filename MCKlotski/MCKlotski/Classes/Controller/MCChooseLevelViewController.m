//
//  MCChooseLevelViewController.m
//  MCKlotski
//
//  Created by gtts on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCChooseLevelViewController.h"
#import "MCSelectLevelButton.h"
#import "MCCustomGateViewController.h"
#import "MCGate.h"
#import "GGPageControl.h"

#define ROW_SUM 6
#define COLUMN_SUM 5

// scroller的宽度
#define kLevelsWidth 264 
// scroller的高度
#define kLevelsHeight 325


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

- (void)refreshGateButtonWithGateID:(int)gateID;


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
        [[MCDataManager sharedMCDataManager] addObserverWithTarget:self forState:kDataManageGameCompleted];
    }
    return self;
}

- (void)dealloc
{
    [[MCDataManager sharedMCDataManager] addObserverWithTarget:self forState:kDataManageGameCompleted];
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
    NSLog(@"self.scorllView.contentOffset.x:%f", self.scorllView.contentOffset.x);
    _currentPage = page;
    self.pageControl.currentPage = page;
}

#pragma mark - DataManagerObserver
- (void)updateDataWithState:(DataManageChange)dmData
{
    if (dmData == kDataManageGameCompleted) {
        [self refreshGateButtonWithGateID:[MCDataManager sharedMCDataManager].updatingGateID];
    }
}

#pragma mark - Private method
- (void)createSubViews
{
    UIImage *titleImage = [UIImage imageNamed:@"title.png"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:
                                   CGRectMake(0, 20, titleImage.size.width, titleImage.size.height)];
    titleImageView.image = titleImage;
    [self.view addSubview:titleImageView];
    [titleImageView release];
    
    
    // create UIScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((320-264)/2, 70, kLevelsWidth, kLevelsHeight + 55)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    
    // create UIPageControl
    _pageControl = [[GGPageControl alloc] initWithFrame:CGRectMake(0, _scrollView.frame.origin.y + _scrollView.frame.size.height, 320, 20)];
    _pageControl.activeImage = [UIImage imageNamed:@"red_dot.png"];
    _pageControl.inactiveImage = [UIImage imageNamed:@"blue_dot.png"];
    _pageControl.userInteractionEnabled = NO;
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
    
    self.scorllView.contentSize = CGSizeMake(self.scorllView.frame.size.width * pageNum,
                                             self.scorllView.frame.size.height);
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
        btnSelect.frame = CGRectMake(btnWidth * column , btnHeight * row + 60, btnWidth, btnHeight);
        [self.scorllView addSubview:btnSelect];
        num ++ ;
    }
}

- (void)loadScrollTitle
{
    UIImageView *sliderTitle1 = [[UIImageView alloc] initWithFrame:
                                 CGRectMake((320-264)/2 + kLevelsWidth * 0 - 20, 0, 263, 55)];
    sliderTitle1.image = [UIImage imageNamed:@"title_1.png"];
    [self.scorllView addSubview:sliderTitle1];
    [sliderTitle1 release];
    
    UIImageView *sliderTitle2 = [[UIImageView alloc] initWithFrame:
                                 CGRectMake((320-264)/2 + kLevelsWidth * 1 - 20, 0, 263, 55)];
    sliderTitle2.image = [UIImage imageNamed:@"title_2.png"];
    [self.scorllView addSubview:sliderTitle2];
    [sliderTitle2 release];
    
    UIImageView *sliderTitle3 = [[UIImageView alloc] initWithFrame:
                                 CGRectMake((320-264)/2 + kLevelsWidth * 2 - 20, 0, 263, 55)];
    sliderTitle3.image = [UIImage imageNamed:@"title_3.png"];
    [self.scorllView addSubview:sliderTitle3];
    [sliderTitle3 release];
    
    UIImageView *sliderTitle4 = [[UIImageView alloc] initWithFrame:
                                 CGRectMake((320-264)/2 + kLevelsWidth * 3 - 20, 0, 263, 55)];
    sliderTitle4.image = [UIImage imageNamed:@"title_4.png"];
    [self.scorllView addSubview:sliderTitle4];
    [sliderTitle4 release];
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
    MCCustomGateViewController *customGateViewController = 
        [[MCCustomGateViewController alloc] initWithGateID:selectButton.gate.gateID];
    [self.navigationController pushViewController:customGateViewController animated:YES];
    [customGateViewController release];
}

- (void)refreshGateButtonWithGateID:(int)gateID
{
    for (int i = 0; i < self.gateButtons.count; i++) {
        MCGate *gate = [[MCDataManager sharedMCDataManager].gates objectAtIndex:i];
        MCGate *gateNext = nil;
        MCSelectLevelButton *selectButtonNext = nil;
        if ((i+1)<self.gateButtons.count) {
             gateNext = [[MCDataManager sharedMCDataManager].gates objectAtIndex:i+1];
             selectButtonNext = [self.gateButtons objectAtIndex:i+1];
        }
       
        if (gateID == gate.gateID) {
            MCSelectLevelButton *selectButton = [self.gateButtons objectAtIndex:i];
            [selectButton refreshWithGate:gate];
            [selectButtonNext refreshWithGate:gateNext];
        }
    }
}

@end
