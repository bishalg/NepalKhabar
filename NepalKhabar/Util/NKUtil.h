//
//  BAUtil.h
//  BritAsiaSuperStar
//
//  Created by Bishal Ghimire on 2/14/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NKUtil : NSObject

+(NSString *)method005:(NSString *) dateString;
+(NSString *)method004:(NSString *) dateString;
+ (NSString *) getNepaliTimeValue: (NSString *) timeValue;
+(NSString *) returnNepaliChar: (NSString *) engChar;
// + (NSString *)userVisibleDateTimeStringForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString;
+ (NSDate *) dateWithDayDateMonthYearGMT:(NSString *) dateString;
+ (void) getTimeDifferenceIn:(NSString *)language;
+ (void) showMessageBoxTitle:(NSString *)msgTitle andMessage: (NSString *)msgMessage;
+ (NSString *) getUUID;
+ (BOOL) openSafariWithLink: (NSString *) urlLink;
+ (BOOL) makePhoneCallWithNumber: (NSString *) phoneNumber;
+ (BOOL) sendEmailTo:(NSString *)emailID withSubject:(NSString *)eSubject andBody:(NSString *)eBody;
+ (BOOL) saveUserDefault:(NSString *)stringObject forKey:(NSString *)keyString ;
+ (NSString *) getUserDefault:(NSString *)itemKey;
+ (NSString *) getOverlayImageName;
+ (BOOL)validateEmailWithString:(NSString*)email;

@end
