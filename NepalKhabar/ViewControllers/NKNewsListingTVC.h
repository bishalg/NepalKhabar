//
//  NKNewsListingTVC.h
//  NepalKhabar
//
//  Created by Bishal Ghimire on 4/16/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKRSSParser.h"
#import "NKNewsCategoriesList.h"
#import "MBProgressHUD.h"
#import "NKDateConverter.h"
#import "ECSlidingViewController.h"
#import <ViewDeck/IIViewDeckController.h>

@class MBProgressHUD;

@interface NKNewsListingTVC : ECSlidingViewController
<UITableViewDataSource,UITableViewDelegate,BlogRssParserDelegate, CategoriesDelegate,IIViewDeckControllerDelegate> {
    NKRSSParser *_rssParser;
	UITableView *_tableView;
	UIToolbar *_toolbar;
    NSString  *rssURL;
    NSString *rssLanguage;
    NSString *subCategory;
    NSString *xPath;
    NSString *xPathName;
    NKNewsCategoriesList *_categoriesList;
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UILabel *lblNewsPaperName;
@property (weak, nonatomic) IBOutlet UIView *viewCategoryName;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoryName;

@property (weak, nonatomic) IBOutlet UILabel *lblCategory;

@property (strong, nonatomic) NKRSSParser *nkRssParser;
@property (copy, nonatomic) NSString *rssURL;
@property (copy, nonatomic) NSString *rssLanguage;

@property (copy, nonatomic) NSString *xPath;
@property (copy, nonatomic) NSString *xPathName;

@property (nonatomic, assign) NSArray *categoryName;
@property (nonatomic, assign) NSArray *categoryLink;
@property (nonatomic, assign) NSString *categoryID;

@property (nonatomic, assign) NSString *newsTitle;

@property (nonatomic,retain) IBOutlet UITableView * tableView;
@property (nonatomic, strong) NSString *subCategory;

@property (nonatomic,retain) IBOutlet NKRSSParser* rssParser;
@property (strong, nonatomic) NKNewsCategoriesList *categoriesList;
@property (strong, nonatomic) NKDateConverter *dateConverter;

@property (nonatomic, strong) UIWindow *mainWindow;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIView *activityView;

-(void)displayActivitySpinner;
-(void)removeActivitySpinner;


@end
