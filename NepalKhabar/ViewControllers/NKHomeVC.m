//
//  NKHomeVC.m
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 4/26/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
// view-source:http://weather.yahooapis.com/forecastrss?w=2269179&u=c
// http://woeid.rosselliot.co.nz/lookup/kathmandu

#import "NKHomeVC.h"
#import "UIImage+StackBlur.h"
#import <QuartzCore/QuartzCore.h>
#import "NKUtil.h"
#import "NKDateConverter.h"
#import "NKNewsListingTVC.h"
#import "YahooWeatherParser.h"
#import "NKConstants.h"
#import "NSString+NepaliNumber.h"
#import "TFHpple.h"
#import "Tutorial.h"
#import "Contributor.h"
#import "HTMLParser.h"
#import "NKHTMLParser.h"
#import <SDSegmentedControl/SDSegmentedControl.h>
#import "SCYahooWeatherConditionCheck.h"
#import "InitialViewController.h"
#import "NKHomeDataHolder.h"
#import "NKAppDelegate.h"

@interface NKHomeVC ()
    @property (nonatomic, strong) NSMutableArray *btnImages;
    @property (nonatomic, strong) NSMutableArray *newsLink;

    @property (nonatomic, retain) NSMutableArray *xPath;
    @property (nonatomic, retain) NSMutableArray *xPathName;
@end

NSMutableArray *_objects;

@implementation NKHomeVC

@synthesize btnImages, newsLink;
@synthesize xPath,xPathName;

@synthesize dateLbl;
@synthesize weekDaysLbl;
@synthesize autoScrollTimer;
@synthesize viewNewsSection;
@synthesize imgArrow;

@synthesize viewNewsTitle;
@synthesize segmentCategory;
@synthesize newsScrollView;
@synthesize lblTempr;

@synthesize lblTemprHighLow;
@synthesize lblSunRise;
@synthesize imgNewsBG;
@synthesize lblSunSet;
@synthesize viewSunRiseSunSet;

@synthesize imgWeather;
@synthesize lblWeatherTitle;
@synthesize weatherinfo;
@synthesize lblLocation;
@synthesize nepalKhabarLabel;

@synthesize newsSourceParser;

float blurValue = 0.0;
float sepiaValue = 0.0;
bool newsViewShown = FALSE;
bool hasNavigated = FALSE;
bool weatherHasError = FALSE;
NSString *mainImageName;

float startX = 0;
float startY = 0;

- (IBAction)segmentChanged:(id)sender {
    [self changeSegment:[segmentCategory selectedSegmentIndex]];
}

#pragma -
#pragma mark - Animation

-(void) hideWatherInfoAnimation {
    int ht = self.view.frame.size.height;
    int wth = self.view.frame.size.width;

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         viewNewsSection.frame =  CGRectMake(0, 0, wth, ht-40);
                         coverImage.alpha = 0.9;
                         imgArrow.transform = CGAffineTransformMakeRotation(2*M_PI);
                     } completion:^(BOOL finished) {
                         [self hideWeatherDetails];
                     }];
}

-(void) showWeatherInfoAnimation; {
    int ht = self.view.frame.size.height;
    int wth = self.view.frame.size.width;
    [self showWeatherDetails];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         viewNewsSection.frame =  CGRectMake(0, ht-55, wth, ht-40);
                         coverImage.alpha = 1.0;
                         imgArrow.transform = CGAffineTransformMakeRotation(M_PI);
                     } completion:^(BOOL finished) {
                     }];
}

-(void) hideWeatherDetails {
    viewSunRiseSunSet.hidden = YES;
    lblWeatherTitle.hidden=YES;
    imgWeather.hidden=YES;
    lblTempr.hidden=YES;
    lblTemprHighLow.hidden=YES;
    lblSunRise.hidden=YES;
    lblSunSet.hidden=YES;
    lblLocation.hidden = YES;
}

-(void) showWeatherDetails {
    if (!weatherHasError) {
        viewSunRiseSunSet.hidden = NO;
        lblWeatherTitle.hidden=NO;
        imgWeather.hidden=NO;
        lblTempr.hidden=NO;
        lblTemprHighLow.hidden=NO;
        lblSunRise.hidden=NO;
        lblSunSet.hidden=NO;
        lblLocation.hidden = NO;
    }
}

- (void)toggleWeatherSection {
    if (newsViewShown) {
        [self showWeatherInfoAnimation];
        newsViewShown = FALSE;
    } else {
        /* News Section Visible */
        [self hideWatherInfoAnimation];
        newsViewShown = TRUE;
    }
}

- (void)animateText {
    NKDateConverter *object = [[NKDateConverter alloc] init];
    NSString *mth = [object getNepaliMonth:[NSDate date]];
    NSString *currentTemp = [[NSString alloc] init];
    
    self.weekDaysLbl.text = [object getNepaliDay:1];
    self.dateLbl.text = mth;
    
    currentTemp = [[NKUtil getUserDefault:kSCTagTemp_Condition] string2NepaliNumber] ;
    currentTemp = [NSString stringWithFormat:@"%@°", currentTemp ] ;
    self.lblTempr.text =  currentTemp;
    
    int wth = self.view.frame.size.width;
    [weekDaysLbl setFrame:CGRectMake(wth-240, 50, 130, 45)];
    [dateLbl setFrame:CGRectMake(wth-240, 85, 130, 45)];
    
    [lblTemprHighLow setFrame:CGRectMake(wth-160, 120, 150, 45)];
    [lblTempr setFrame:CGRectMake(wth-160, 160, 130, 60)];
    
    [imgWeather setFrame:CGRectMake(wth-280, 150, 81, 81)];
    [lblWeatherTitle setFrame:CGRectMake(wth-280, 120, 100, 45)];
    
    [UIView animateWithDuration:3 animations:^{
        self.dateLbl.alpha = 1.0;
        self.weekDaysLbl.alpha = 1.0;
        self.lblTempr.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)changeSegment:(int) segIndex {
    self.newsSourceParser = [[NKLocalJSONParser alloc]init];
    self.newsSourceParser.delegate = self;

    if (segIndex == 0 ) {
        [newsSourceParser convertNewsSource:@"rssNP"];
    } else {
        [newsSourceParser convertNewsSource:@"rssEN"];
    }
}

#pragma mark
#pragma mark Gesture

- (void)setSwipeGestures {
    /* Touch On News Section View  */
    UITapGestureRecognizer *touchOnNewsView = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(toggleWeatherSection)];
    touchOnNewsView.numberOfTapsRequired = 1;
    [[self viewNewsTitle] addGestureRecognizer:touchOnNewsView];
}

#pragma mark -
#pragma mark - ParserDelegate Methods
#define FACTOR .9

- (void)loadImages {
    int numberOfImages = self.btnImages.count;
    
    CGRect frame = self.newsScrollView.frame;
    for (int i = 0; i < numberOfImages; i++) {
        if (i % 2 == 0) {
            frame.origin.x = 30.0f;
            frame.origin.y = i*75.0f;
        }
        else {
            frame.origin.x = self.view.frame.size.width - 150.0f;
            frame.origin.y = (i-1)*75.0f;
        }
        frame.size.height = 146.0f * FACTOR;
        frame.size.width = 133.0f * FACTOR;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *myImage =   [UIImage imageNamed:[self.btnImages objectAtIndex:i]];
        [button setBackgroundImage:myImage forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(myButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = frame;
        button.tag = i;
        [self.newsScrollView addSubview:button];
    }
    CGFloat frameHeight = (numberOfImages/2) * 200 * FACTOR;
    
    CGRect scrollFrame = newsScrollView.frame;
    scrollFrame.size.height = self.view.frame.size.height - 75;
    
    [newsScrollView setFrame:scrollFrame];
    [newsScrollView setContentSize:CGSizeMake(300,frameHeight)];
    DLog(@"scroll content %f  scroll frame %f",frameHeight, scrollFrame.size.height);
}

#pragma mark -
#pragma mark - Navigation
/* navigation on click */
- (void)myButtonAction:(id)sender {
 
    NKAppDelegate *viewController = AppDelegate;
    if (segmentCategory.selectedSegmentIndex == 0) {
        viewController.rssLanguage = @"nepali";
    } else if (segmentCategory.selectedSegmentIndex == 1) {
        viewController.rssLanguage = @"english";        
    }
    else {
        viewController.rssLanguage = @"nepali";
    }
    
    viewController.rssURL = [self.newsLink objectAtIndex:[sender tag]];
    viewController.xPath = [self.newsSourceParser.xpath objectAtIndex:[sender tag]];
    viewController.xPathName = [self.newsSourceParser.xpathName objectAtIndex:[sender tag]];
    viewController.newsTitle = [self.newsSourceParser.title objectAtIndex:[sender tag]];
    
    NSString *catID = [self.newsSourceParser.categoryID objectAtIndex:[sender tag]];
    viewController.categoryID = catID;
    
    viewController.categoryName = [self.newsSourceParser.categoryTitle objectForKey:catID];
    viewController.categoryLink = [self.newsSourceParser.categoryLink objectForKey:catID];
    viewController.newsPaperName=[self.newsSourceParser.labelName objectAtIndex:[sender tag]];
    
    hasNavigated = TRUE;
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        InitialViewController *initialviewController =[self.storyboard instantiateViewControllerWithIdentifier:@"InitialViewController"];
        [self.navigationController pushViewController:initialviewController animated:YES];
    });  
}

#pragma mark -
#pragma mark - ParserDelegate Methods
- (void)jsonParserReady {
    btnImages = [[NSMutableArray alloc] init];
    newsLink = [[NSMutableArray alloc] init];
    xPath = [[NSMutableArray alloc] init];
    xPathName = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< [self.newsSourceParser.title count]; i++) {
        [btnImages addObject:[self.newsSourceParser.imageName objectAtIndex:i]];
        [newsLink addObject:[self.newsSourceParser.mainLink objectAtIndex:i]];
        [xPath addObject:[self.newsSourceParser.xpath objectAtIndex:i]];
        [xPathName addObject:[self.newsSourceParser.xpathName objectAtIndex:i]];
    }
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self loadImages];
    });
}

- (void)jsonParserConnectionFailed {
    DLog(@"error");
}

- (void)loadWeatherDataFromLocal {
    NSString *temprLowHigh = [NSString stringWithFormat:@"↑%@°",
                              [[NKUtil getUserDefault:kSCTagHigh_Forecast] string2NepaliNumber]];
    temprLowHigh = [temprLowHigh stringByAppendingString:
                    [NSString stringWithFormat:@"↓%@°",
                     [[NKUtil getUserDefault:kSCTagLow_Forecast] string2NepaliNumber]]];
    
    NSString *sunRise =  [NSString stringWithFormat:@"%@",
                          [[NKUtil getUserDefault:kSCTagSunrise_Astronomy] string2NepaliNumber]];
    
    NSString *sunSet = [NSString stringWithFormat:@"%@",
                        [[NKUtil getUserDefault:kSCTagSunset_Astronomy] string2NepaliNumber]];
    
    NSString *currentTemp = [NSString stringWithFormat:@"%@°",
                            [NKUtil getUserDefault:kSCTagTemp_Condition]];
    
    SCYahooWeatherConditionCheck *weatherConditionCheck =[SCYahooWeatherConditionCheck alloc];
    weatherinfo=[weatherConditionCheck yahooWeatherConditionCheck:[NKUtil getUserDefault:kSCTagCode_Condition]];
    lblWeatherTitle.text=[weatherinfo objectAtIndex:1];
    imgWeather.image = [UIImage imageNamed:[weatherinfo objectAtIndex:0]];

    if ([[NKUtil getUserDefault:kSCTagHigh_Forecast] intValue] < [currentTemp intValue]) {
        currentTemp = [NKUtil getUserDefault:kSCTagHigh_Forecast];
    }
    
    if ([[NKUtil getUserDefault:kSCTagLow_Forecast] intValue] > [currentTemp intValue]) {
        currentTemp = [NKUtil getUserDefault:kSCTagLow_Forecast];
    }
    
    lblTempr.text = [currentTemp string2NepaliNumber];
    lblTemprHighLow.text = temprLowHigh;
    lblSunRise.text = sunRise;
    lblSunSet.text = sunSet;
}

- (void)initYahooWeather {
    [self loadWeatherDataFromLocal];
    [NKUtil getUserDefault:kSCTagCode_Condition];

    if ([[NKUtil getUserDefault:kSCTagCode_Condition] length]==0) {
        weatherHasError = TRUE;
        // DLog(@"weatherHasError");
        [self hideWeatherDetails];
    }
    
    static NSInteger weatherID = 2269179;
    SCYahooWeatherParser *weatherParser = [[SCYahooWeatherParser alloc] initWithWOEID:weatherID
                                                                          weatherUnit:SCWeatherUnitCelcius
                                                                             delegate:self];
    [weatherParser parse];
}

#pragma mark - SCYahooWeatherParserDelegate
- (void)yahooWeatherParser:(SCYahooWeatherParser *)parser recievedWeatherInformation:(SCWeather *)weather {
    weatherHasError = FALSE;
    [self showWeatherDetails];
    [self loadWeatherDataFromLocal];
}

#pragma mark -
#pragma mark View Related

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [nepalKhabarLabel setFont:[UIFont fontWithName:@"AvalonBold" size:20]];
    nepalKhabarLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];

    [self setSwipeGestures];
    [self hideNavBar];
    
    self.newsSourceParser = [[NKLocalJSONParser alloc]init];
    self.newsSourceParser.delegate = self;
    [self.newsSourceParser convertNewsSource:@"rssNP"];
    
    newsViewShown = FALSE;
    
    CGFloat ht = self.view.frame.size.height;
    CGFloat wth = self.view.frame.size.width;
     viewNewsSection.frame =  CGRectMake(0, ht-55, wth, ht-40);
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
       [self toggleWeatherSection];
    });
    
    UIImage *patternImage = [UIImage imageNamed:@"bg_pattern"];
    [imgNewsBG setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
    
   [self initYahooWeather];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    [self imageAccordingToTime];
}

- (void)viewWillAppear:(BOOL)animated {
    [self hideNavBar];
}

- (void)viewDidDisappear:(BOOL)animated {
    autoScrollTimer = nil;
    [autoScrollTimer invalidate];
}

#pragma mark
#pragma mark Hide / Show TabBar

- (void)hideNavBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.hidden = TRUE;
}

- (void)showNavBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.hidden = FALSE;
}

#pragma mark
#pragma mark Memory 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setDateLbl:nil];
    [self setWeekDaysLbl:nil];
    [self setViewNewsSection:nil];
    [self setImgArrow:nil];
    [self setViewNewsTitle:nil];
    [self setSegmentCategory:nil];
    [self setViewNewsSection:nil];
    [self setNewsScrollView:nil];
    [self setLblTempr:nil];
    [self setLblTemprHighLow:nil];
    [self setLblSunRise:nil];
    [self setImgNewsBG:nil];
    [self setLblSunSet:nil];
    [self setViewSunRiseSunSet:nil];
    [self setImgWeather:nil];
    [self setLblWeatherTitle:nil];
    [self setLblLocation:nil];
    [self setNepalKhabarLabel:nil];
    [self setViewImageHolder:nil];
    [super viewDidUnload];
}

- (void)imageAccordingToTime {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:[NSDate date]];
    NSInteger hour = [components hour];
    if(hour >= 0 && hour < 12){
        mainImageName =@"gadget_wall_morning@iphone5";
    }
    else if(hour >= 12 && hour < 15){
        mainImageName =@"gadget_wall_afternoon@iphone5";
    }
    else if(hour >= 15 && hour <20){
        mainImageName =@"gadget_wall_evening@iphone5";
    }
    else if(hour>=20){
        mainImageName =@"gadget_wall_night@iphone5";
    }
    
    [self initYahooWeather];
    coverImage.image = [UIImage imageNamed:mainImageName];
    [self animateText];
}

@end
