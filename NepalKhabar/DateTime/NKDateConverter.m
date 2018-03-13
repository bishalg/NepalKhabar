//
//  NKDateConverter.m
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 4/26/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//
// http://en.wikipedia.org/wiki/Nepali_calendar
// बैशाख जेठ असार साउन भदौ असोज कार्तिक मंसिर पुष माघ फागुन चैत्र
// आईतवार सोमवार मंगलवार बुधवार  बिहीबार  शुक्रवार शनिवार

#import "NKDateConverter.h"
#import "NSString+NepaliNumber.h"
/*
 बैशाख (4) Apr 14 - (5) May 14
 जेठ (5) May 15 - (6) Jun 14
 असार Jun 15 - Jul 15
 साउन Jul 16 - Aug 16
 भदौ Aug 17 - Sep 16 
 असोज Sep 17 - Oct 17
 कार्तिक (10) Oct 18 - (11) Nov 15
 मंसिर (11) Nov 16 - (12) Dec 15
 पुष (12) Dec 16 - (1) Jan 14
 माघ (1) Jan 15 - (2) Feb 12
 फागुन   (2) Feb 13 - (3)  Mar 14 
 चैत्र (3) Mar 14 - (4) Apr 13
 */

@implementation NKDateConverter

NSInteger daysInAMonth[15];

- (id) init
{
    if ( self = [super init] )
    {
        NSString *sampleDate = [[NSString alloc] init];
        for (int i = 1; i<13; i++) {
            sampleDate =  [NSString stringWithFormat:@"01 %d 2013",i];
            daysInAMonth[i] = [self noOfDaysInAMonth:[self getDateWithDateMonthYear:sampleDate]];
        }
    }
    return self;
}

-(NSUInteger) noOfDaysInAMonth : (NSDate *)inputDate{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:inputDate];
    return rng.length;
}

- (NSDate *) getDateWithDateMonthYear:(NSString *) dateString; {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MM yyyy"];
    // NSDate *myDate = [dateFormatter dateFromString:@"Sun, 06 Nov 1994 08:49:37 GMT"];
    NSDate *myDate = [dateFormatter dateFromString:dateString];
    return myDate;
}



- (int) getDayOfTheWeek:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init] ;
    [dateFormatter setDateFormat:@"e"];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    return [formattedDateString intValue];
}

-(NSString *) getNepaliDay:(NSUInteger) englishDay;{
    englishDay = [self getDayOfTheWeek:[NSDate date]];
    NSString *nepaliDay = [[NSString alloc] init];
    switch (englishDay) {
        case 1:
            nepaliDay = @"आईतवार";
            break;
        case 2:
            nepaliDay = @"सोमवार";
            break;
        case 3:
            nepaliDay = @"मंगलवार";
            break;
        case 4:
            nepaliDay = @"बुधवार";
            break;
        case 5:
            nepaliDay = @"बिहीबार";
            break;
        case 6:
            nepaliDay = @"शुक्रवार";
            break;
        case 7:
            nepaliDay = @"शनिवार";
            break;
        default:
            break;
    }
    DLog(@"%d",englishDay);
    // NSLog(@"nepaliDay %@",nepaliDay);
    return nepaliDay;
}

-(NSDate *) getPreviousMonth: (NSDate *) givenDate {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:givenDate];
    NSInteger month = [components month];
    
    // How much day to add
    int addDaysCount = -daysInAMonth[month-1];
    // old error method
    //int addDaysCount = -[self noOfDaysInAMonth:givenDate];
    // NSLog(@"this month %d previous mth days %d", month ,addDaysCount);
    
    // Create and initialize date component instance
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:addDaysCount];

    // Retrieve date with increased days count
    NSDate *previousMonth = [[NSCalendar currentCalendar]
                       dateByAddingComponents:dateComponents
                       toDate:givenDate options:0];
   //  NSLog(@"previousMonth %@",previousMonth);
    return previousMonth;
}

-(NSString *) getNepaliMonth:(NSDate *) englishDate {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSUInteger englishMonth =  [components month];;
    NSUInteger englishDay =  [components day];;
    NSString *nepaliMonth = [[NSString alloc] init];
    NSInteger nepaliDay;
    
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:englishDate];
  //  NSUInteger noOfDaysInThisMonth = [self noOfDaysInAMonth:englishDate];
    NSUInteger noOfDaysInPreviousMonth = [self noOfDaysInAMonth:[self getPreviousMonth:englishDate]];
    // NSLog(@"no Of Days In previous month %d noOfDaysInThisMonth %d",noOfDaysInPreviousMonth, noOfDaysInThisMonth);
    
    switch (englishMonth) {
        /* पुष (12) Dec 16 - (1) Jan 14
         माघ (1) Jan 15 - (2) Feb 12 */
        case 1:
            if (englishDay >= 15) {
                nepaliMonth = @"माघ";
                nepaliDay = englishDay - 14;
            } else {
                nepaliMonth = @"पुष";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 15);
            }
            break;
        /* माघ (1) Jan 15 - (2) Feb 12
        फागुन   (2) Feb 13 - (3)  Mar 14 */
        case 2:
            if (englishDay >= 13) {
                nepaliMonth = @"फागुन";
                nepaliDay = englishDay - 12;
            } else {
                nepaliMonth = @"माघ";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 14);
            }
            break;
        /* फागुन   (2) Feb 13 - (3)  Mar 14
         चैत्र (3) Mar 14 - (4) Apr 13 */
        case 3:
            if (englishDay >= 14) {
                nepaliMonth = @"चैत्र";
                nepaliDay = englishDay - 13;
            } else {
                nepaliMonth = @"फागुन";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 12);
            }
            break;
        /*  चैत्र (3) Mar 14 - (4) Apr 13
        बैशाख (4) Apr 14 - (5) May 14 */
        case 4:
            if (englishDay >= 14) {
                nepaliMonth = @"बैशाख";
                nepaliDay = englishDay - 13;
            } else {
                nepaliMonth = @"चैत्र";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 13);
            }
            break;
        /* बैशाख (4) Apr 14 - (5) May 14
         जेठ (5) May 15 - (6) Jun 14 */
        case 5:
            if (englishDay >= 15) {
                nepaliMonth = @"जेठ";
                nepaliDay = englishDay - 15;
            } else {
                nepaliMonth = @"बैशाख";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 13);
            }
            break;
        /* जेठ (5) May 15 - (6) Jun 14
         असार Jun 15 - Jul 15 */
        case 6:
            if (englishDay >= 15) {
                nepaliMonth = @"असार";
                nepaliDay = englishDay - 14;
            } else {
                nepaliMonth = @"जेठ";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 15);
            }
            break;
        /* असार Jun 15 - Jul 15
         साउन Jul 16 - Aug 16 */
        case 7:
            if (englishDay >= 16) {
                nepaliMonth = @"साउन";
                nepaliDay = englishDay - 15;
            } else {
                nepaliMonth = @"असार";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 14);
            }
            break;
        /* साउन Jul 16 - Aug 16
         भदौ Aug 17 - Sep 16 */
        case 8:
            if (englishDay >= 17) {
                nepaliMonth = @"भदौ";
                nepaliDay = englishDay - 16;
            } else {
                nepaliMonth = @"साउन";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 15);
            }
            break;
        /*भदौ Aug 17 - Sep 16
         असोज Sep 17 - Oct 17*/
        case 9:
            if (englishDay >= 17) {
                nepaliMonth = @"असोज";
                nepaliDay = englishDay - 16;
            } else {
                nepaliMonth = @"भदौ";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 16);
            }
            break;
        /* असोज Sep 17 - Oct 17
         कार्तिक (10) Oct 18 - (11) Nov 15 */
        case 10:
            if (englishDay >= 18) {
                nepaliMonth = @"कार्तिक";
                nepaliDay = englishDay - 17;
            } else {
                nepaliMonth = @"असोज";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 16);
            }
            break;
        /* कार्तिक (10) Oct 18 - (11) Nov 15
         मंसिर (11) Nov 16 - (12) Dec 15 */
        case 11:
            if (englishDay >= 16) {
                nepaliMonth = @"मंसिर";
                nepaliDay = englishDay - 15;
            } else {
                nepaliMonth = @"कार्तिक";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 17);
            }
            break;
        /* मंसिर (11) Nov 16 - (12) Dec 15
         पुष (12) Dec 16 - (1) Jan 14 */
        case 12:
            if (englishDay >= 16) {
                nepaliMonth = @"पुष";
                nepaliDay = englishDay - 15;
            } else {
                nepaliMonth = @"मंसिर";
                nepaliDay = englishDay + (noOfDaysInPreviousMonth - 15);
            }
            break;
        default:
            nepaliMonth = @"";
            nepaliDay = englishDay;
            break;
    }
    NSString *nepaliDayString = [[NSString alloc] init];
    nepaliDayString = [NSString stringWithFormat:@"%d", nepaliDay];
    nepaliDayString = [nepaliDayString string2NepaliNumber];
    NSString *finalDate = [[NSString alloc] init];
    finalDate = [NSString stringWithFormat:@"%@ %@",nepaliMonth,nepaliDayString ];
    // finalDate = [finalDate stringByAppendingString:nepaliMonth];
    
   //  NSLog(@"finalDate %@", finalDate);
    
    return finalDate;
 }

@end
