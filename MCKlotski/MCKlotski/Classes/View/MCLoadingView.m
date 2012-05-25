//
//  MCLoadingView.m
//  MCKlotski
//
//  Created by gtts on 5/22/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCLoadingView.h"
#import <QuartzCore/QuartzCore.h>

CGPathRef NewPathWithRoundRect(CGRect rect, CGFloat cornerRadius);

//  
// NewPathWithRoundRect  
//  
// Creates a CGPathRect with a round rect of the given radius.  
//  
CGPathRef NewPathWithRoundRect(CGRect rect, CGFloat cornerRadius)  
{  
    //  
    // Create the boundary path  
    //  
    CGMutablePathRef path = CGPathCreateMutable();  
    CGPathMoveToPoint(path, NULL,  
                      rect.origin.x,  
                      rect.origin.y + rect.size.height - cornerRadius);  
    
    // Top left corner  
    CGPathAddArcToPoint(path, NULL,  
                        rect.origin.x,  
                        rect.origin.y,  
                        rect.origin.x + rect.size.width,  
                        rect.origin.y,  
                        cornerRadius);  
    
    // Top right corner  
    CGPathAddArcToPoint(path, NULL,  
                        rect.origin.x + rect.size.width,  
                        rect.origin.y,  
                        rect.origin.x + rect.size.width,  
                        rect.origin.y + rect.size.height,  
                        cornerRadius);  
    
    // Bottom right corner  
    CGPathAddArcToPoint(path, NULL,  
                        rect.origin.x + rect.size.width,  
                        rect.origin.y + rect.size.height,  
                        rect.origin.x,  
                        rect.origin.y + rect.size.height,  
                        cornerRadius);  
    
    // Bottom left corner  
    CGPathAddArcToPoint(path, NULL,  
                        rect.origin.x,  
                        rect.origin.y + rect.size.height,  
                        rect.origin.x,  
                        rect.origin.y,  
                        cornerRadius);  
    
    // Close the path at the rounded rect  
    CGPathCloseSubpath(path);  
    
    return path;  
}  

@implementation MCLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
 
+ (id)loadingViewInView:(UIView *)aSuperview  
{  
    CGRect frame = [aSuperview bounds];
    frame = CGRectMake(frame.origin.x, frame.origin.y + 20, frame.size.width, frame.size.height - 20);
    MCLoadingView *loadingView =  
    [[[MCLoadingView alloc] initWithFrame:frame] autorelease];  
    if (!loadingView)  
    {  
        return nil;  
    }  
    
    loadingView.opaque = NO;  
    loadingView.autoresizingMask =  
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
    [aSuperview addSubview:loadingView];  
    
    const CGFloat DEFAULT_LABEL_WIDTH = 280.0;  
    const CGFloat DEFAULT_LABEL_HEIGHT = 50.0;  
    CGRect labelFrame = CGRectMake(0, 0, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);  
    UILabel *loadingLabel =  
    [[[UILabel alloc]  
      initWithFrame:labelFrame]  
     autorelease];  
    loadingLabel.text = NSLocalizedString(@"Loading...", nil);  
    loadingLabel.textColor = [UIColor whiteColor];  
    loadingLabel.backgroundColor = [UIColor clearColor];  
    loadingLabel.textAlignment = UITextAlignmentCenter;  
    loadingLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];  
    loadingLabel.autoresizingMask =  
    UIViewAutoresizingFlexibleLeftMargin |  
    UIViewAutoresizingFlexibleRightMargin |  
    UIViewAutoresizingFlexibleTopMargin |  
    UIViewAutoresizingFlexibleBottomMargin;  
    
    [loadingView addSubview:loadingLabel];  
    UIActivityIndicatorView *activityIndicatorView =  
    [[[UIActivityIndicatorView alloc]  
      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]  
     autorelease];  
    [loadingView addSubview:activityIndicatorView];  
    activityIndicatorView.autoresizingMask =  
    UIViewAutoresizingFlexibleLeftMargin |  
    UIViewAutoresizingFlexibleRightMargin |  
    UIViewAutoresizingFlexibleTopMargin |  
    UIViewAutoresizingFlexibleBottomMargin;  
    [activityIndicatorView startAnimating];  
    
    CGFloat totalHeight =  
    loadingLabel.frame.size.height +  
    activityIndicatorView.frame.size.height;  
    labelFrame.origin.x = floor(0.5 * (loadingView.frame.size.width - DEFAULT_LABEL_WIDTH));  
    labelFrame.origin.y = floor(0.5 * (loadingView.frame.size.height - totalHeight));  
    loadingLabel.frame = labelFrame;  
    
    CGRect activityIndicatorRect = activityIndicatorView.frame;  
    activityIndicatorRect.origin.x =  
    0.5 * (loadingView.frame.size.width - activityIndicatorRect.size.width);  
    activityIndicatorRect.origin.y =  
    loadingLabel.frame.origin.y + loadingLabel.frame.size.height;  
    activityIndicatorView.frame = activityIndicatorRect;  
    
    // Set up the fade-in animation  
    CATransition *animation = [CATransition animation];  
    [animation setType:kCATransitionFade];  
    [[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];  
    
    return loadingView;  
}  

//  
// removeView  
//  
// Animates the view out from the superview. As the view is removed from the  
// superview, it will be released.  
//  
- (void)removeView  
{  
    UIView *aSuperview = [self superview];  
    [super removeFromSuperview];  
    
    // Set up the animation  
    CATransition *animation = [CATransition animation];  
    [animation setType:kCATransitionFade];  
    
    [[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];  
}  

//  
// drawRect:  
//  
// Draw the view.  
//  
- (void)drawRect:(CGRect)rect  
{  
    rect.size.height -= 1;  
    rect.size.width -= 1;  
    
    const CGFloat RECT_PADDING = 8.0;  
    rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);  
    
    const CGFloat ROUND_RECT_CORNER_RADIUS = 5.0;  
    CGPathRef roundRectPath = NewPathWithRoundRect(rect, ROUND_RECT_CORNER_RADIUS);  
    
    CGContextRef context = UIGraphicsGetCurrentContext();  
    
    const CGFloat BACKGROUND_OPACITY = 0.85;  
    CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);  
    CGContextAddPath(context, roundRectPath);  
    CGContextFillPath(context);  
    
    const CGFloat STROKE_OPACITY = 0.25;  
    CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);  
    CGContextAddPath(context, roundRectPath);  
    CGContextStrokePath(context);  
    
    CGPathRelease(roundRectPath);  
}  

//  
// dealloc  
//  
// Release instance memory.  
//  
- (void)dealloc  
{  
    [super dealloc];  
}  

@end
