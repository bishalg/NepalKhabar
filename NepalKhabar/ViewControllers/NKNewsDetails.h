//
//  NKNewsDetails.h
//  NepalKhabar
//
//  Created by Bishal Ghimire on 4/19/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKHTMLParser.h"
#import "NKSlideView.h"
#import "ViewBottomBar.h"

@interface NKNewsDetails : UIViewController <NKHTMLParserDelegate,
UIScrollViewDelegate, BottomViewDelegate, SlideViewDelegate, UIActionSheetDelegate> {
    NSMutableArray *newsItem;
}
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (copy, nonatomic)  NSMutableArray *newsItem;
@property (copy, nonatomic) NSMutableArray *allItems;
@property  (nonatomic) NSInteger itemNo;

@property (nonatomic, strong) NSString *header;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSString *newsHeader;



@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblPublishDate;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
@property (weak, nonatomic) IBOutlet UIWebView *webViewTextDescription;

@property (weak, nonatomic) IBOutlet UIView *tempNewsView;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) NKHTMLParser *htmlParser;

@property (nonatomic, retain) NSString *xPath;
@property (nonatomic, retain) NSString *xPathName;
@property (weak, nonatomic) IBOutlet UIView *titleView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIView *activityView;
@property (nonatomic, assign) NSInteger lastContentOffset;

@property (weak, nonatomic) IBOutlet UIImageView *imgTitleBar;
 
@property (weak, nonatomic) IBOutlet NKSlideView *slideView;
 
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIView *viewBottomBackground;
@property (weak, nonatomic) IBOutlet ViewBottomBar *tabBtmView;

@property (weak, nonatomic) IBOutlet UILabel *lblNewsPaperName;
@property (strong, nonatomic) NSString *finalHtmlElement;
@property (strong, nonatomic) NSString *newsTitle;

-(void)displayActivitySpinner;
-(void)removeActivitySpinner;
 
@end
