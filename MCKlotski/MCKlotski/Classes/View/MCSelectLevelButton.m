//
//  MCSelectLevelButton.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-27.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCSelectLevelButton.h"
#import "MCGate.h"

@interface MCSelectLevelButton (Private)

- (void) createSubViews;

- (NSString *) getID:(int) theID;

- (void) customView;

- (void) resetView;

@end

@implementation MCSelectLevelButton

@synthesize gate = _gate;
@synthesize index = _index;
@synthesize highlightView = _highlightView;
@synthesize backgroundView = _backgroundView;
@synthesize flagView = _flagView;
@synthesize lblNumber = _lblNumber;

- (id) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
         NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        [self createSubViews];
    }
    return self;
}

- (void) dealloc
{
    MCRelease(_gate);
    MCRelease(_lblNumber);
    MCRelease(_backgroundView);
    MCRelease(_flagView);
    self.highlightView = nil;
     NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}
#pragma mark - public method
- (void) refreshWithGate:(MCGate *)gate
{
    self.gate = gate;
    [self resetView];
    self.gate.isLocked = YES;
    
    self.backgroundView.image = [UIImage imageNamed:@"levelbg.png"];
    if (self.gate.isLocked) {
        UIImage *lockImage = [UIImage imageNamed:@"locked.png"];
        self.flagView.image = lockImage;
        //self.flagView.frame = CGRectMake(0, 0, lockImage.size.width, lockImage.size.height);
        self.lblNumber.text = [self getID:gate.gateID];
        self.enabled = NO;
        return;
    }
    
    if (self.gate.passMoveCount != 0) {
        // TODO::选关界面
    }
    
}

#pragma mark - private method
- (void) createSubViews
{
    UIImageView *bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    bgimg.backgroundColor = [UIColor clearColor];
    [self addSubview:bgimg];
    self.backgroundView = bgimg;
    [bgimg release];
    
    UIImage *star = [UIImage imageNamed:@"star1.png"]; 
    int width = star.size.width;
    int height = star.size.height;
    UIImageView *flagImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - width - 5, self.frame.size.height - height - 5, width, height)];
    flagImg.backgroundColor = [UIColor clearColor];
    flagImg.contentMode = UIViewContentModeCenter;
    [self addSubview:flagImg];
    self.flagView = flagImg;
    [flagImg release];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 25, 10)];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    numLabel.font = [UIFont boldSystemFontOfSize:14];
    numLabel.textAlignment = UITextAlignmentCenter;
    [self addSubview:numLabel];
    self.lblNumber = numLabel;
    [numLabel release];
}

- (void) resetView
{
    self.enabled = YES;
    self.backgroundView.image = nil;
    self.flagView.image = nil;
    
    self.lblNumber.alpha = 1.0;
    self.lblNumber.text = @"";
   // self.lblNumber.center = CGPointMake(35, 42);
}

- (void) customView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    view.userInteractionEnabled = NO;
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.highlightView = view;
    [view release];
}

-(NSString *)getID:(int) theID
{
    NSString *result = NULL;
    if (theID >0 && theID <= 9) {
        result =  [NSString stringWithFormat:@"00%d", theID];
    }else if( theID >= 10 && theID <= 99)
    {
        result =  [NSString stringWithFormat:@"0%d", theID];
    }else if(theID >=100 && theID <= 120){
        result = [NSString stringWithFormat:@"%d", theID];
    }
    return  result;
}

#pragma mark - overwrite
- (void) createNormalView
{
    if (!self.highlightView) {
        [self customView];
    }
    if (self.highlightView.superview) {
        [self.highlightView removeFromSuperview];
    }
}

- (void)createHighLightView
{
    if (!self.highlightView) {
        [self customView];
    }
    if (!self.highlightView.superview) {
        [self addSubview:self.highlightView];
    }    
}

@end
