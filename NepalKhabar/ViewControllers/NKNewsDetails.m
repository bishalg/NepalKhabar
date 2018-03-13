//
//  NKNewsDetails.m
//  NepalKhabar
//
//  Created by Bishal Ghimire on 4/19/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import "NKNewsDetails.h"
#import "NKNewsListingTVC.h"
#import "NKWebViewVC.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+HTML.h"
#import <SVWebViewController/SVModalWebViewController.h>
#import "NKAppDelegate.h"
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import "NKUtil.h"

@interface NKNewsDetails ()

@end

@implementation NKNewsDetails

@synthesize newsItem;
@synthesize allItems;
@synthesize itemNo;

@synthesize lblTitle;
@synthesize lblPublishDate;
@synthesize txtDescription;
@synthesize progressView;

@synthesize xPath;
@synthesize xPathName;
@synthesize webViewTextDescription;
@synthesize header;
@synthesize slideView;
@synthesize tabBtmView;
@synthesize lblNewsPaperName;
@synthesize imgTitleBar;
@synthesize titleView;
@synthesize finalHtmlElement;
@synthesize newsTitle;
@synthesize backView;
@synthesize urlString;
@synthesize newsHeader;


int newsNo;
int preBtnTag=3;
bool background = YES;
int fontValue;
NSString *colorString;
NSString *shadowColor;
 
#pragma mark - Delegate Method - HTML Parser
- (void)processCompleted {
    txtDescription.hidden = TRUE;
    lblPublishDate.hidden = TRUE;
    lblTitle.hidden = TRUE;
   // lblTitle.text = @"";
    //[self loadHTML];
    
    // DLog(@"HTML Parsing processCompleted");
    // webViewTextDescription.hidden = FALSE;
    
    
    // dispatch_async(dispatch_get_main_queue(), ^{
         [webViewTextDescription loadHTMLString:finalHtmlElement baseURL:nil];
         
         
//         [webViewTextDescription  loadHTMLString:[NSString stringWithFormat:@"<html><body bgcolor=\"#000000\" text=\"#FFFFFF\" size=\"5\">%@</body></html>",self.htmlParser.htmlValue] baseURL:nil];
//         
 
    // });
    [self loadHTML];
    [self removeActivitySpinner];
}
#pragma mark Navigation
- (IBAction)tabBtnWebView:(id)sender {
    [self viewLinkOnWeb];
}

- (void)viewLinkOnWeb {
    // NSLog(@"%@",linkURL);

    //    NKWebViewVC *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NKWebViewVC"];
//    detailViewController.newsURL = linkURL;
    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector(donePressed)];
    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:nil];
//    leftButton.image = 
    NSString *linkURL =  [[[self allItems] objectAtIndex:[self itemNo]] valueForKey:@"link"];
    
    UIImage *buttonImage = [UIImage imageNamed:@"btn_left"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
 
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:linkURL];
    webViewController.navigationItem.leftBarButtonItem = customBarItem;
    
    [self presentModalViewController:webViewController animated:YES];
   // [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)displayActivitySpinner {
    _activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 60)];
    [_activityView setBackgroundColor:[UIColor clearColor]];
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_activityIndicator setFrame:CGRectMake(145, 220, 30, 30)];
    [_activityIndicator startAnimating];
    [_activityView addSubview:_activityIndicator];
    [self.view addSubview:_activityView];
}

- (void)removeActivitySpinner {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_activityIndicator stopAnimating];
        [_activityView removeFromSuperview];
    });
}

#pragma mark - initWithNibName

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.htmlParser = [[NKHTMLParser alloc]init];
        self.htmlParser.delegate = self;
    }
    return self;
}

- (void)startHTMLParsing {
    self.htmlParser = [[NKHTMLParser alloc]init];
    self.htmlParser.delegate = self;
    
    NSString *urlLink = [[[self allItems] objectAtIndex:[self itemNo]] valueForKey:@"link"];
    urlString=urlLink;
    // NSLog(@"xPath %@ xPathName %@",self.xPath, self.xPathName);
    
//    dispatch_get_global_queue  // dispatch_get_main_queue
    
    dispatch_queue_t taskQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(taskQ, ^{
    //dispatch_async(dispatch_get_main_queue(), ^{
        [self.htmlParser parserLink:urlLink withXPath:xPath andXPathName:xPathName];
        dispatch_async(dispatch_get_main_queue(), ^{
            webViewTextDescription.hidden = FALSE;
            self.tempNewsView.hidden = TRUE;
            [self removeActivitySpinner];
        });
    // [webViewTextDescription loadHTMLString:self.htmlParser.htmlValue baseURL:nil];
   });
    // dispatch_release(taskQ);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
}

#pragma mark-View Related
- (void)viewDidAppear:(BOOL)animated {
   [self startHTMLParsing];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.htmlParser.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    DLog(@"%@",xPath);
    
    webViewTextDescription.scrollView.showsHorizontalScrollIndicator = FALSE;
    webViewTextDescription.scrollView.alwaysBounceHorizontal = FALSE;
    NKAppDelegate *appDelegate=AppDelegate;
    lblNewsPaperName.text=appDelegate.newsPaperName;
    
    UIImage *patternImage = [UIImage imageNamed:@"bg_pattern"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
    newsHeader=[[[self allItems] objectAtIndex:newsNo] valueForKey:@"title"];
    
    [self displayActivitySpinner];
    webViewTextDescription.hidden = TRUE;
    [[webViewTextDescription scrollView] setBounces: NO];
     webViewTextDescription.scrollView.delegate=self;
    // self.title = header;
    
    newsNo = self.itemNo;
    lblTitle.text = [[[self allItems] objectAtIndex:newsNo] valueForKey:@"title"];

    
    newsTitle=[[[self allItems] objectAtIndex:newsNo] valueForKey:@"title"];
    lblPublishDate.text = [[[self allItems] objectAtIndex:newsNo] valueForKey:@"pubDate"];
    txtDescription.text =  [[[[self allItems] objectAtIndex:newsNo] valueForKey:@"description"] stringByConvertingHTMLToPlainText];
    
    /* Hide Navigation Bar Back Button */
    self.navigationItem.hidesBackButton = YES;
    
    /* Set Swipe Gestures */
    [self setSwipeGestures];
    float progressValue = (newsNo/(1.0*[allItems count]));
    progressView.progress = progressValue;
    progressView.hidden=YES;
    slideView.hidden=YES;
    self.tabBtmView.delegate=self;
    self.slideView.delegate=self;
    [self setUIBarIcons];
    fontValue = 16;
    colorString = @"#000000";
     shadowColor = @"#fff";
    
}

- (void)setUIBarIcons {
    UIImage *buttonImage = [UIImage imageNamed:@"btn_left"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(navBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
}

- (void)navBack {
    //NKNewsListingTVC *newsListsTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NKNewsListingTVC"];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]  animated:YES];
}

#pragma mark -
#pragma mark Swipe  Gestures 

- (void)setSwipeGestures {
    // Add swipeGestures //
    /*! --- Swipe Left - 1 finger */
    UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(oneFingerSwipeLeft:)];
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
    
    /*! --- Swipe Right - 1 finger */
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(oneFingerSwipeRight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
    
    /*! --- Swipe Down - 1 finger */
    UISwipeGestureRecognizer *oneFingerSwipeDown = [[UISwipeGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(oneFingerSwipeDown:)];
    [oneFingerSwipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [[self view] addGestureRecognizer:oneFingerSwipeDown];
}
- (IBAction)btnPreNews:(id)sender {
    [self previousNews];

}
- (IBAction)btnNextNews:(id)sender {
    [self nextNews];
}

- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
   [self nextNews];
}

- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
   [self previousNews];
}

- (void)oneFingerSwipeDown:(UITapGestureRecognizer *)recognizer {
   [self navigate2VLCNoteVC];
}

/*
 NSString * const kCATransitionFade;
 NSString * const kCATransitionMoveIn;
 NSString * const kCATransitionPush;
 NSString * const kCATransitionReveal;
*/

- (void)nextNews {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    NKNewsDetails *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NKNewsDetails"];
    if (newsNo >= [allItems count]-1) {
        
    }
    else {
        newsNo = newsNo + 1;
        detailViewController.itemNo = newsNo;
        detailViewController.allItems = allItems;
        detailViewController.xPathName = xPathName;
        detailViewController.xPath = xPath;
        detailViewController.header = header;
    
        DLog(@"news no %d xPathName %@ ",newsNo, xPathName);

        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController pushViewController:detailViewController animated:NO];
    }
}

- (void)previousNews {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    NKNewsDetails *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NKNewsDetails"];
    
    newsNo = newsNo - 1;
    if (newsNo < 0) {
        newsNo = 0;
    } else {
     
        detailViewController.itemNo = newsNo;
        detailViewController.allItems = allItems;
        detailViewController.xPathName = xPathName;
        detailViewController.xPath = xPath;
        detailViewController.header = header;
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:detailViewController animated:NO];
    }
}

- (void)navigate2VLCNoteVC {
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)showTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds) - CGRectGetHeight(tabBar.frame);
                         tabBar.frame = tabFrame;
                         
                         CGRect contentFrame = content.frame;
                         contentFrame.size.height -= tabFrame.size.height;
                     }];
}

- (void)viewDidUnload {
    [self setLblTitle:nil];
    [self setLblPublishDate:nil];
    [self setTxtDescription:nil];
    [self setProgressView:nil];
    [self setWebViewTextDescription:nil];
    [self setTempNewsView:nil];
    //[self setViewSetting:nil];
     
    [self setSlideView:nil];
     
    //[self setTabView:nil];
    [self setTabBtmView:nil];
    [self setLblNewsPaperName:nil];
    [self setImgTitleBar:nil];
    [self setTitleView:nil];
    [self setViewBottomBackground:nil];
    [self setBtnBack:nil];
    [self setBackView:nil];
    [super viewDidUnload];
}
- (IBAction)btnClose:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark- Scrollview Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_lastContentOffset <=(int)scrollView.contentOffset.y) {
        self.viewBottomBackground.hidden = YES;
      tabBtmView.hidden=YES;
        slideView.hidden=YES;
    }
    if (_lastContentOffset > (int)scrollView.contentOffset.y)  {
        self.viewBottomBackground.hidden = NO;
        
       tabBtmView.hidden=NO;
    }  

}
- (void)slideView:(NKSlideView *)slideView didSelectOption:(NSInteger)slideValue{
   //NSLog(@"Current value of slider is %d", slideValue);
    fontValue=slideValue;
    [self loadHTML];
}

- (void)loadHTML {
    [webViewTextDescription  loadHTMLString:[self htmlWithHeader] baseURL:nil];
}

- (NSString *)htmlWithHeader {
    //webViewTextDescription.frame.size.width=320.0f;
    NSMutableString *html = [[NSMutableString alloc] init];
    NSString * headerHTML = [NSString stringWithFormat:@"<div id ='foo' style='font-size:%dpx';>%@<div>", fontValue, self.htmlParser.htmlValue];
    html = [NSString stringWithFormat:@"<div id ='foo' style='font-size:%dpx';><strong style=\"text-shadow:1px 1px %@;\">%@</strong><div><div id ='foo';>%@<div>",(fontValue+4),shadowColor,newsTitle,headerHTML];
    html = [NSString stringWithFormat:@"<meta  width=device-width, initial-scale=1.0/><html><head><style type=\"text/css\">body{font-family:arial, helvetica, sans-serif;}a {color:#4ca3d9 !important;} img{max-width:300px !important; margin-bottom:10px !important; height:auto !important;}</style></head><body style=\"max-width:300px !important;\" text=\"%@\">%@</body></html>",colorString,html];
    return html;
}

- (void)viewBottomBar:(ViewBottomBar *)tabBtmView didSelectOption:(NSInteger)btnTag{
    
    UIActionSheet *action;
    switch (btnTag) {
        case 0:
            slideView.hidden=YES;
            if (background) {
                colorString = @"#b3b3b3";
                self.view.backgroundColor = [UIColor blackColor];
                
                UIImage *image = [UIImage imageNamed: @"title_bg_dark"];
                [imgTitleBar setImage:image];
                background=NO;
                self.btnBack.imageView.image = [UIImage  imageNamed:@"back_light"];
                lblNewsPaperName.textColor = [UIColor whiteColor];
                shadowColor = @"#000";
                txtDescription.textColor = [UIColor whiteColor];
                lblPublishDate.textColor=[UIColor whiteColor];
                lblTitle.textColor=[UIColor whiteColor];
                backView.backgroundColor=[UIColor whiteColor];
                
            }
            else {
                colorString = @"#000000";
                UIImage *patternImage = [UIImage imageNamed:@"bg_pattern"];
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
                
                UIImage *image = [UIImage imageNamed: @"title_bg"];
                [imgTitleBar setImage:image];
                background=YES;
                self.btnBack.imageView.image = [UIImage  imageNamed:@"back_bright"];
                lblNewsPaperName.textColor = [UIColor blackColor];
                txtDescription.textColor = [UIColor blackColor];
                lblPublishDate.textColor=[UIColor blackColor];
                lblTitle.textColor=[UIColor blackColor];
                backView.backgroundColor=[UIColor clearColor];
                shadowColor = @"#fff";
                
            }
            [self loadHTML];

            break;

        case 1:
            if (slideView.hidden) {
                slideView.hidden=NO;
            }else{
                slideView.hidden=YES;
            }
            [self loadHTML];
            break;
    
        case 2:
            slideView.hidden=YES;
            action =[[UIActionSheet alloc] initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"View on Web",@"Tweet",@"Facebook",nil];
            [action showInView:self.view];
            break;
        default:
            break;
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    DLog(@"buttonIndex %d",buttonIndex)
    
    @try {
        switch (buttonIndex) {
            case 0:
                [self viewLinkOnWeb];
                break;
            case 1:                
                if ([TWTweetComposeViewController canSendTweet]) {
                    TWTweetComposeViewController *tweetSheet =
                    [[TWTweetComposeViewController alloc] init];
                    [tweetSheet addURL:[NSURL URLWithString:self.urlString]];
                    
                    NSString* finalNews = [NSString stringWithFormat:@"#NK %@",self.newsTitle];
                    
                    [tweetSheet setInitialText:finalNews];
                    [self presentModalViewController:tweetSheet animated:YES];
                }
                else
                {
                    UIAlertView *alertView = [[UIAlertView alloc]
                                              initWithTitle:@"Sorry"
                                              message:@"You can't send a tweet right now"
                                              delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
                    [alertView show];
                }
                break;
                
            case 2:
                if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
                    [NKUtil showMessageBoxTitle:@"Facebook Share Not available" andMessage:@"Facebook share is available only in iOS 6.0 or higher"];
                } else {
                    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
                        SLComposeViewController *tweetSheet =[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                        [tweetSheet addURL:[NSURL URLWithString:self.urlString]];
                        NSString* finalNews = [NSString stringWithFormat:@"#NK %@",self.newsTitle];
                        [tweetSheet setInitialText:finalNews];
                        [self presentModalViewController:tweetSheet animated:YES];
                    }else
                    {
                        UIAlertView *alertView = [[UIAlertView alloc]
                                                  initWithTitle:@"Sorry"
                                                  message:@"You can't send a Facebook right now"
                                                  delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
                        [alertView show];
                    }
                }
                break;
            default:
                break;
        }
    }
    @catch (NSException *exception) {
        
    }
}

@end
