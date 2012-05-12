//
//  MCAboutAlertView.m
//  MCKlotski
//
//  Created by gtts on 5/12/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCAboutAlertView.h"

@implementation MCAboutAlertView

@synthesize aboutWebView = _aboutWebView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    self.aboutWebView = nil;
    [super dealloc];
}

- (void)updateAlertFrame
{
    UIImage *alertBgImage = [UIImage imageNamed:@"about.png"];
    int viewWidth = alertBgImage.size.width;
    int viewHeight = alertBgImage.size.height;
    self.frame = CGRectMake((_border.frame.size.width - viewWidth) / 2, (_border.frame.size.height - viewHeight) / 2, viewWidth, viewHeight);
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    background.contentMode = UIViewContentModeCenter;
    background.image = alertBgImage;
    [self addSubview:background];
    [background release];
    
    UIImage *buttonImage = [UIImage imageNamed:@"alert_continue.png"];
    UIButton *button = [[UIButton alloc] initWithFrame:
                        CGRectMake((self.frame.size.width - buttonImage.size.width) / 2,
                                   (self.frame.size.height - buttonImage.size.height - 20), 
                                   buttonImage.size.width, 
                                   buttonImage.size.height)];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button release];
}

- (void)laodContent
{
    self.aboutWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.aboutWebView.delegate = self;
    [self addSubview:self.aboutWebView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [self.aboutWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
}


#pragma mark -
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView 
    shouldStartLoadWithRequest:(NSURLRequest *)request 
    navigationType:(UIWebViewNavigationType)navigationType {
    return true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"]; 
	NSLog(@"title11=%@",title);
	
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"]; 
	NSLog(@"title=%@",title);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"index.html error, %@", error);
}



@end
