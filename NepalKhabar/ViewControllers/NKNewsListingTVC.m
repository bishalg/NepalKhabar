//
//  NKNewsListingTVC.m
//  NepalKhabar
//
//  Created by Bishal Ghimire on 4/16/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NKNewsListingTVC.h"
#import "BlogRSS.h"
#import "NKRSSParser.h"
#import "NKNewsDetails.h"
#import "NKUtil.h"
#import "NKDateConverter.h"
#import "NKNewsCategoriesList.h"
#import "NSString+HTML.h"
#import "NKHomeVC.h"
#import "NKHomeDataHolder.h"

#import "NKNewsCategoriesList.h"
#import "NKAppDelegate.h"


@interface NKNewsListingTVC ()

@end

@implementation NKNewsListingTVC

@synthesize rssParser = _rssParser;
@synthesize tableView = _tableView;
@synthesize rssURL;
@synthesize subCategory;
@synthesize categoriesList;
@synthesize dateConverter;
@synthesize rssLanguage;
@synthesize xPath;
@synthesize xPathName;
@synthesize newsTitle;
@synthesize lblNewsPaperName;
@synthesize viewCategoryName;
@synthesize lblCategoryName;
@synthesize nkRssParser;

bool descriptionContent=YES;
int cellHeight;
bool pull2Refresh;

- (IBAction)btnCategories:(id)sender {
    [self.viewDeckController toggleRightViewAnimated:YES];
}

- (IBAction)btnBackToHome:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showCategoriesView {
    NKNewsCategoriesList *second    = [self.storyboard instantiateViewControllerWithIdentifier:@"NKNewsCategoriesList"];
    second.myDelegate               = self;
    second.categoryName             = self.categoryName;
    second.categoryLink             = self.categoryLink;
    second.categoryID               = self.categoryID;
    second.modalTransitionStyle     = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:second animated:YES];
}

#pragma mark -
#pragma mark Categories Delegates
- (void)categoriesListDismissed:(NSString *)categorieName withLink:(NSString *)categorieLink     {
    self.rssURL = categorieLink;
    NKAppDelegate *appdelegate = AppDelegate;
    appdelegate.rssURL=categorieLink;
   [self parserRSS];
}

- (void)showHUD {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading News";
    HUD.detailsLabelText = @"Please Wait ...";
    HUD.mode = MBProgressHUDModeIndeterminate;
    
    [self.tableView addSubview:HUD];
    [HUD show:YES];
}

- (void)parserRSS {
    [self showHUD];
    _rssParser                      = [[NKRSSParser alloc]init];
	self.rssParser.delegate         = self;
    
    _categoriesList                 = [[NKNewsCategoriesList alloc]init];
    self.categoriesList.myDelegate  = self;
    NKAppDelegate *appDelegate      = AppDelegate;

    HUD.hidden                      = FALSE;
    if ( appDelegate.rssURL == nil) {
        self.rssURL = @"http://ekantipur.com/nep/rss";
    }
	[[self rssParser] startProcess:appDelegate.rssURL];
}

- (void)handleSideMenuChange:(NSNotification *)note {
    _tableView.scrollEnabled        = NO;
    [self showHUD];
    NKAppDelegate *appDelegate      = AppDelegate;
    [[self rssParser] startProcess:appDelegate.rssURL];
    
    NSString* categoryName          = [NSString stringWithFormat:@" %@ ", appDelegate.selectCategoryItem];
    lblCategoryName.text            = categoryName;
    
    [lblCategoryName sizeToFit];
    CGRect frame                    = lblCategoryName.frame;
    frame.origin.x                  = 160-(frame.size.width)/2;
    lblCategoryName.frame           = frame;
    lblCategoryName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pattern"]];
}

- (void)setUIBarIcons {
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor];
    self.title = self.newsTitle;
    
    UIImage *buttonImage = [UIImage imageNamed:@"btn_left"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.backBarButtonItem = customBarItem;

    UIImage *catImage = [UIImage imageNamed:@"btn_sandwitch"];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:catImage forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, catImage.size.width, catImage.size.height);
    [rightButton addTarget:self action:@selector(showCategoriesView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customRightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = customRightBarItem;
}

- (void)categoryNameSelection{
    NKAppDelegate *appDelegate = AppDelegate;
    if([appDelegate.rssLanguage isEqualToString:@"nepali"]) {
        lblCategoryName.text=@" मुख्य समाचार ";
    }
    else {
        lblCategoryName.text=@" Top Stories ";
    }
    
    [lblCategoryName sizeToFit];
    CGRect frame=lblCategoryName.frame;
    frame.origin.x = 160-(frame.size.width)/2;
    lblCategoryName.frame = frame;
    lblCategoryName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pattern"]];
}

- (void)backAction {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)designTableView {
    // Remove table cell separator
    // [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Assign our own backgroud for the view
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // Add padding to the top of the table view
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
}

// Scroll View Pull 2 refresh delegarets
#pragma mark -
#pragma mark - Pull 2 Refresh 

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate  {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY < -60.0) {
        pull2Refresh = TRUE;
        [self displayActivitySpinner];
    }
}

- (void)displayActivitySpinner {
    _activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 60)];
    [_activityView setBackgroundColor:[UIColor clearColor]];
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_activityIndicator setFrame:CGRectMake(145, 20, 30, 30)];
    [_activityIndicator startAnimating];
    [_activityView addSubview:_activityIndicator];
    [_mainWindow addSubview:_activityView];
    [UIView animateWithDuration:0.25 animations:^{ [self.tableView setFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height)];
    } completion:^(BOOL finished) {
        [self parserRSS];
        [self removeActivitySpinner];
    }];
}

- (void)removeActivitySpinner {
    @try {
        [_activityIndicator stopAnimating];
        [_activityView removeFromSuperview];
        //[UIView animateWithDuration:0.250 animations:^{
            CGRect currentTableRect = self.tableView.frame;
            [self.tableView setFrame:CGRectMake(currentTableRect.origin.x, currentTableRect.origin.y - 60, currentTableRect.size.width, currentTableRect.size.height)];
       //}];
    }
    @catch (NSException *exception) {
       //  NSLog(@"Erro removing activity spinner");
    }
    
}

#pragma mark -
#pragma mark Hide / Show TabBar

- (void)hideNavBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.hidden = TRUE;
}

- (void)showNavBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.hidden = FALSE;
}


#pragma mark -
#pragma mark Hide / Show Tabbar

- (void)hideTabBar {
    UITabBar *tabBar    = self.tabBarController.tabBar;
    UIView *parent      = tabBar.superview; // UILayoutContainerView
    UIView *content     = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window      = parent.superview;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds);
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                     }];
}

- (void)showTabBar {
    UITabBar *tabBar    = self.tabBarController.tabBar;
    UIView *parent      = tabBar.superview; // UILayoutContainerView
    UIView *content     = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window      = parent.superview;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds) - CGRectGetHeight(tabBar.frame);
                         tabBar.frame = tabFrame;
                         
                         CGRect contentFrame = content.frame;
                         contentFrame.size.height -= tabFrame.size.height;
                     }];
}

//Delegate method for blog parser will get fired when the process is completed

#pragma mark -
#pragma mark RSS_Parser_Delegates

- (void)processCompleted {
    _tableView.scrollEnabled=YES;
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    DLog(@"%d",[[[self rssParser] rssItems] count]);

    if ([[[self rssParser] rssItems] count]>1) {
        // NSLog(@"RSS Exit");
        NSString *description1 = [[[[self rssParser] rssItems] objectAtIndex:0] valueForKey:@"description"];
         NSString *description2 = [[[[self rssParser] rssItems] objectAtIndex:1] valueForKey:@"description"];
       if(([description1 length ]>=40) ||([description2 length ]>=40)){
            //descriptionContent=YES;
           cellHeight = 100;
                   }else{
          //descriptionContent=NO;
            cellHeight=50;
            DLog(@"");
        }
        
    }else{
        // DLog(@"RSS Not Exit");
    }
    // NSLog(@"processCompleted");
    
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    [[self tableView]reloadData];
}

- (void)processHasErrors{
    HUD.hidden = TRUE;
	//Might be due to Internet
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Unable to download rss. Please check if you are connected to internet."
												   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
}

#pragma mark -
#pragma tableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // Return the number of sections.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self rssParser]rssItems]count];
}

- (NSString *)reuseIdentifier:(NSIndexPath *)indexPath {
    return @"OddCell";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseID = [self reuseIdentifier:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if ( cell  == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    @try {
        UILabel *newNewsTitle = (UILabel *)[cell viewWithTag:101];
        newNewsTitle.text = [[[[self rssParser] rssItems] objectAtIndex:indexPath.row] valueForKey:@"title"];
        
        UILabel *description = (UILabel *)[cell viewWithTag:102];
        description.text = [[[[[self rssParser] rssItems] objectAtIndex:indexPath.row] valueForKey:@"description"] stringByConvertingHTMLToPlainText];
        
        UILabel *pubDate  = (UILabel *)[cell viewWithTag:103];
        NSString *dateString = [[[[self rssParser] rssItems] objectAtIndex:indexPath.row] valueForKey:@"pubDate"];
        
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(10, cellHeight-1, 300, 1)];
        separatorView.layer.borderColor = [UIColor colorWithRed:220/256.0 green:220/256.0 blue:220/256.0 alpha:1].CGColor;
        separatorView.layer.borderWidth = 2.0;
        
        [cell.contentView addSubview:separatorView];
        
        NKAppDelegate *appDelegate = AppDelegate;
        if ([appDelegate.rssLanguage isEqualToString:@"nepali"]) {
            if ([dateString length] > 0) pubDate.text = [NKUtil method004:dateString];
        } else {
            if ([dateString length] > 0) pubDate.text = [NKUtil method005:dateString];
        }
        //cell.backgroundColor = [UIColor clearColor];
        // cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_pattern"]];
        
        
       self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    @catch (NSException *exception) {
       DLog(@"error making cell");
    }
    return cell;
}

#pragma mark - NAVIGATION

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NKNewsDetails *detailVC         = [self.storyboard instantiateViewControllerWithIdentifier:@"NKNewsDetails"];
    
    NKAppDelegate *appDelegate      = AppDelegate;
    detailVC.allItems               = [[self rssParser] rssItems];
    detailVC.xPath                  = appDelegate.xPath;
    detailVC.xPathName              = appDelegate.xPathName;
    detailVC.header                 = appDelegate.newsTitle;
    //detailVC = [[[self rssParser] rssItems] objectAtIndex:indexPath.row];
    detailVC.itemNo                 = indexPath.row;
    detailVC.modalTransitionStyle   = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:detailVC animated:YES];
    //[self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController
         willCloseViewSide:(IIViewDeckSide)viewDeckSide
                  animated:(BOOL)animated {
    if(viewDeckSide == IIViewDeckRightSide) {
        // right side
    }
    else if(viewDeckSide == IIViewDeckLeftSide) {
        // left side
    }
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController
               applyShadow:(CALayer *)shadowLayer
                withBounds:(CGRect)rect {
    shadowLayer.masksToBounds   = NO;
    shadowLayer.shadowRadius    = 1;
    shadowLayer.shadowOpacity   = 0.9;
    shadowLayer.shadowColor     = [[UIColor redColor] CGColor];
    shadowLayer.shadowOffset    = CGSizeZero;
    shadowLayer.shadowPath      = [[UIBezierPath bezierPathWithRect:rect] CGPath];
}

- (void)viewDidUnload {
    [self setLblCategory:nil];
    [self setLblNewsPaperName:nil];
    [self setViewCategoryName:nil];
    [self setLblCategoryName:nil];
    [super viewDidUnload];
}
- (void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSideMenuChange:)
                                                 name:@"menuItemSelected"
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.rssParser.delegate = nil;
}

#pragma mark -
#pragma mark View

- (void)viewDidLoad {
    [super viewDidLoad];
    [self parserRSS];
    
    [self designTableView];
    UIImage *patternImage = [UIImage imageNamed:@"bg_pattern"];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
    [self.viewCategoryName setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
    [self categoryNameSelection];
    
    NKAppDelegate *appDelegate = AppDelegate;
    lblNewsPaperName.text=appDelegate.newsPaperName;
    [lblNewsPaperName setFont:[UIFont fontWithName:@"AvalonBold" size:18]];
    lblNewsPaperName.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    
    [self hideNavBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    /*
     if (![self.slidingViewController.underLeftViewController isKindOfClass:[NKNewsCategoriesList class]]) {
     self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"NKNewsCategoriesList"];
     }
     */
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dateConverter = [[NKDateConverter alloc] init];
    }
    return self;
}

@end
