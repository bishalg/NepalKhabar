//
//  NKWebViewVC.m
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 4/22/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import "NKWebViewVC.h"

@interface NKWebViewVC ()

@end

@implementation NKWebViewVC
@synthesize webView;
@synthesize newsItem;
@synthesize newsURL;
// @synthesize activityIndicator;


#pragma mark- HUD
-(void) showHUD{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading News";
    HUD.detailsLabelText = @"Please Wait ...";
    HUD.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:HUD];
    [HUD show:YES];
}


#pragma mark-nav
- (IBAction)openSafari:(id)sender {
    NSString *urlString = [newsItem valueForKey:@"link"];
    urlString = self.newsURL;
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
   // DLog(@"url to open %@" ,url);
    if (![[UIApplication sharedApplication] openURL:url]){
        DLog(@"Failed to open url %@",[url description]);
    }
}

#pragma mark
#pragma mark Hide / Show Tabbar

- (void)hideTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds);
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                     }];
}

#pragma mark- webView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // NSLog(@"Loading: %@", [request URL]);
    return YES;
}

-(void) webViewDidStartLoad:(UIWebView *) webView{
   // NSLog(@"Start Loading");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void) webViewDidFinishLoad:(UIWebView *) webView{
    // NSLog(@"stop loading");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    DLog(@"failed loading with error %@", error.description);
//    NSLog(@"didFail: %@; stillLoading:%@", [[webView request]URL],
//          (webView.loading?@"NO":@"YES"));
//    [btnUpdate setHidden:NO];

}




#pragma mark- Scrollview Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //self.lastContentOffset = scrollView.contentOffset.y;
    // DLog(@"showTabbarSetting");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (_lastContentOffset < (int)scrollView.contentOffset.y) {
        // NSLog(@"showTabbarSetting");
    }
    else {
        // NSLog(@"showTabbarSetting");
    }  
}

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    webView.delegate = self;
    [self loadWebView];
    
    
    webView.scrollView.delegate=self;
    
    
    UIImage *patternImage = [UIImage imageNamed:@"bg_pattern"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
}
- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}

-(void) viewDidAppear:(BOOL)animated{
    // [self hideTabBar];
}



-(void) loadWebView {
    NSString *urlAddress = newsURL;
    // NSLog(@"open link in web view %@" , newsURL);
    NSURL *url = [NSURL URLWithString:[urlAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] ];
    
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url];
    [requestObj setValue:@"Safari" forHTTPHeaderField:@"User-Agent"];
    
    //Load the request in the UIWebView.
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Mozilla/3.0", @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    webView.scalesPageToFit = YES;
    [webView loadRequest:requestObj];
}

@end
