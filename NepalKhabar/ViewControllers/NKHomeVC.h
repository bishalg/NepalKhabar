//
//  NKHomeVC.h
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 4/26/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKLocalJSONParser.h"
#import "SCYahooWeatherParser.h"

@interface NKHomeVC : UIViewController <UIScrollViewDelegate, NewsSourceDelegate, SCYahooWeatherParserDelegate> {
    IBOutlet UIImageView *coverImage;
  	UIImage *source;
}

// Image Holder View - THIS View has Background Images
@property (strong, nonatomic) IBOutlet UIView *viewImageHolder;

@property (weak, nonatomic) IBOutlet UILabel *nepalKhabarLabel;
@property (retain) NSArray *weatherinfo;
@property (weak, nonatomic) IBOutlet UIImageView *imgWeather;
@property (weak, nonatomic) IBOutlet UILabel *lblWeatherTitle;

@property (strong, nonatomic) NKLocalJSONParser *newsSourceParser;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *weekDaysLbl;

@property (weak, nonatomic) IBOutlet UIView *viewNewsSection;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;
@property (weak, nonatomic) IBOutlet UIView *viewNewsTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentCategory;
@property (strong, nonatomic) IBOutlet UIScrollView *newsScrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblTempr;
@property (weak, nonatomic) IBOutlet UILabel *lblTemprHighLow;
@property (weak, nonatomic) IBOutlet UILabel *lblSunRise;
@property (weak, nonatomic) IBOutlet UILabel *lblSunSet;
@property (weak, nonatomic) IBOutlet UIView *viewSunRiseSunSet;

@property (nonatomic, retain) NSTimer *autoScrollTimer;
@property (weak, nonatomic) IBOutlet UIImageView *imgNewsBG;



@end
