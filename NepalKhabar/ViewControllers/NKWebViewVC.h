//
//  NKWebViewVC.h
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 4/22/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class MBProgressHUD;

@interface NKWebViewVC : UIViewController <UIWebViewDelegate,UIScrollViewDelegate> {
    NSMutableArray *newItem;
    NSString *newsURL;
     MBProgressHUD *HUD;
    // IBOutlet UIWebView *webView;
    //IBOutlet UIActivityIndicatorView *activityIndicator;
}

//@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *newsURL;
@property (copy, nonatomic)  NSMutableArray *newsItem;
@property (nonatomic, assign) NSInteger lastContentOffset;
 


@end
