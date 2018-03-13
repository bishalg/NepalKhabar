//
//  BAUtil.m
//  BritAsiaSuperStar
//
//  Created by Bishal Ghimire on 2/14/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//
#import "NKUtil.h"
#import "NSString+NepaliNumber.h"

@implementation NKUtil

// घण्टा  मीनेट दिन अघी  महिना
+ (NSString *) getNepaliTimeValue: (NSString *) timeValue {
    NSString *nepaliValue = [[NSString alloc] init];
    int charLength = timeValue.length;
    @try {
        for (int i=0; i < charLength; i++) {
            nepaliValue = [nepaliValue stringByAppendingString:[NKUtil returnNepaliChar:[timeValue substringWithRange:NSMakeRange(i, 1)]]];
        }
    }
    @catch (NSException *exception) {
        
    }
    
    return nepaliValue;
}

// ० १ २ ३ ४ ५ ६ ७ ८ ९ 
+ (NSString *) returnNepaliChar: (NSString *) engChar{
    NSString* unicodeChar;
    if ([engChar isEqualToString:@"1"]) {
        unicodeChar = @"१";
    }
    else if ([engChar isEqualToString:@"2"]) {
        unicodeChar = @"२";
    }
    else if ([engChar isEqualToString:@"3"]) {
        unicodeChar = @"३";
    }
    else if ([engChar isEqualToString:@"4"]) {
        unicodeChar = @"४";
    }
    else if ([engChar isEqualToString:@"5"]) {
        unicodeChar = @"५";
    }
    else if ([engChar isEqualToString:@"6"]) {
        unicodeChar = @"६";
    }
    else if ([engChar isEqualToString:@"7"]) {
        unicodeChar = @"७";
    }
    else if ([engChar isEqualToString:@"8"]) {
        unicodeChar = @"८";
    }
    else if ([engChar isEqualToString:@"9"]) {
        unicodeChar = @"९";
    }
    else if ([engChar isEqualToString:@"0"]) {
        unicodeChar = @"०";
    }
    // NSLog(@"return unicodeChar %@", unicodeChar);
    return unicodeChar;
}

+(NSString *)method005:(NSString *) dateString;
{
    NSError *error = nil;
    NSDataDetector *aDetector = [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes)NSTextCheckingTypeDate error:&error];
    NSArray *resultArray = [aDetector matchesInString:dateString
                                              options:0
                                                range:NSMakeRange(0, [dateString length])];
    __block NSDate *dateValue = nil;
    [resultArray enumerateObjectsWithOptions:NSEnumerationConcurrent
                                  usingBlock:^(id obj,NSUInteger idx,BOOL *stop){
                                      if (obj) {
                                          dateValue = [obj date];
                                      }
                                      return;
                                  }];
    // Convert GSMDate to local
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"NPT"];
    [dateFormatter setTimeZone:gmt];

    NSDate *now = [NSDate date];
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:now  toDate:dateValue  options:0];
    
    NSString *strMin = [NSString stringWithFormat:@"%d", abs((int) [conversionInfo minute])];
    NSString *strHr = [NSString stringWithFormat:@"%d", abs((int) [conversionInfo hour])];
    NSString *strDay = [NSString stringWithFormat:@"%d", abs((int) [conversionInfo day])];
    NSString *strMonth = [NSString stringWithFormat:@"%d", abs((int) [conversionInfo month])];
    
    NSString *finalValue = [[NSString alloc] init];
    if ([conversionInfo month] > 0) {
        finalValue = [[NSString alloc] initWithFormat:@"%@ month", strMonth];
    }
    else if ([conversionInfo day] > 0) {
        if ([conversionInfo day] > 1) {
            finalValue = [[NSString alloc] initWithFormat:@"%@ days", strDay];
        } else {
            finalValue = [[NSString alloc] initWithFormat:@"%@ day", strDay];
        }
        
    }
    else if ([conversionInfo hour] > 0) {
        if ([conversionInfo hour] > 1) {
            finalValue = [[NSString alloc] initWithFormat:@"%@ hours", strHr];
        } else {
            finalValue = [[NSString alloc] initWithFormat:@"%@ hour", strHr];
        }
    }
    else {
        finalValue = [[NSString alloc] initWithFormat:@"%@ mins", strMin];
    }
    return finalValue ;
    
}

+(NSString *)method004:(NSString *) dateString;
{
    NSError *error = nil;
    
    NSDataDetector *aDetector = [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes)NSTextCheckingTypeDate error:&error];
    NSArray *resultArray = [aDetector matchesInString:dateString
                                              options:0
                                                range:NSMakeRange(0, [dateString length])];
    __block NSDate *dateValue = nil;
    [resultArray enumerateObjectsWithOptions:NSEnumerationConcurrent 
                                  usingBlock:^(id obj,NSUInteger idx,BOOL *stop){
              if (obj) {
                  dateValue = [obj date];
              }
              return;
    }];
    
    // NSLog(@"dateValue %@",dateValue);
    // NSTimeInterval secondsBetween = [dateValue timeIntervalSinceDate:now];
    
// Convert GSMDate to local
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"NPT"];
    [dateFormatter setTimeZone:gmt];
    // NSString *timeStamp = [dateFormatter stringFromDate:dateValue];
    //NSLog(@"Local Time %@",timeStamp);
   //  NSDate *localTime = [dateFormatter stringFromDate:timeStamp];
    
    
    NSDate *now = [NSDate date];
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];

    // Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:now  toDate:dateValue  options:0];

    NSString *strMin = [NSString stringWithFormat:@"%d", abs((int) [conversionInfo minute])];
    NSString *strHr = [NSString stringWithFormat:@"%d", abs((int) [conversionInfo hour])];
    NSString *strDay = [NSString stringWithFormat:@"%d", abs((int) [conversionInfo day])];
    NSString *strMonth = [NSString stringWithFormat:@"%d", abs((int) [conversionInfo month])];
    
    NSString *finalValue = [[NSString alloc] init];
    if ([conversionInfo month] > 0) {
        finalValue = [[NSString alloc] initWithFormat:@"%@ महिना अघी", [strMonth string2NepaliNumber]];
    }
    else if ([conversionInfo day] > 0) {
        finalValue = [[NSString alloc] initWithFormat:@"%@ दिन अघी", [strDay string2NepaliNumber]];
    }
    else if ([conversionInfo hour] > 0) {
        finalValue = [[NSString alloc] initWithFormat:@"%@ घण्टा अघी", [strHr string2NepaliNumber]];
    }
    else {
        finalValue = [[NSString alloc] initWithFormat:@"%@ मीनेट अघी", [strMin string2NepaliNumber]];
    }
    return finalValue ;

//    if (secondsBetween > (60*60)) {
//        NSLog(@"%@  Date %2.0f मीनेट अघी", dateString, secondsBetween/(60*60));
//    }
//    else if (secondsBetween > (60*60*60)) {
//         NSLog(@"%f घण्टा अघी", secondsBetween/(60*60*60) );
//    }
//    else if (secondsBetween > (24*60*60*60)) {
//        NSLog(@"1 दिन अघी ");
//    }
   // NSLog(@"%f",secondsBetween );
    
//  minutes = floor(326.4/60)
//  seconds = round(326.4 - minutes * 60)
    
    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
//                                               fromDate:dateValue
//                                                 toDate:now
//                                                options:0];
//    
//    NSLog(@"Difference in date components: %i/%i/%i", components.day, components.month, components.year);

    
}

//// https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html
//static NSDateFormatter *sUserVisibleDateFormatter = nil;
//static NSDateFormatter *sRFC3339DateFormatter = nil;
//
//+ (NSString *)userVisibleDateTimeStringForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString; {
//    
//    // If the date formatters aren't already set up, create them and cache them for reuse.
////    NSLog(@"Date to parse %@",rfc3339DateTimeString);
//    // rfc3339DateTimeString = @"Tue, 23 Apr 2013 8:51:15 GMT";
//    if (sRFC3339DateFormatter == nil) {
//        sRFC3339DateFormatter = [[NSDateFormatter alloc] init];
//        //NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//        
//        //[sRFC3339DateFormatter setLocale:enUSPOSIXLocale];
//        // [sRFC3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
//        [sRFC3339DateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
//        //[sRFC3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    }
//    
//    // Convert the RFC 3339 date time string to an NSDate.
//    NSDate *date = [sRFC3339DateFormatter dateFromString:rfc3339DateTimeString];
//    NSLog(@"date %@ ", date);
//    
//    NSString *userVisibleDateTimeString;
//    if (date != nil) {
//        if (sUserVisibleDateFormatter == nil) {
//            sUserVisibleDateFormatter = [[NSDateFormatter alloc] init];
//            [sUserVisibleDateFormatter setDateStyle:NSDateFormatterShortStyle];
//            [sUserVisibleDateFormatter setTimeStyle:NSDateFormatterShortStyle];
//        }
//        // Convert the date object to a user-visible date string.
//        userVisibleDateTimeString = [sUserVisibleDateFormatter stringFromDate:date];
//    }
//    NSLog(@"userVisibleDateTimeString %@ ", userVisibleDateTimeString);
//    
//    //
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//    [dateFormatter setLocale:locale];
//    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
//    
//    NSDate *myDate = [dateFormatter dateFromString:rfc3339DateTimeString];
//    NSLog(@" New code %@", myDate);
//    
//    //
//    
//    //NSString *myDateString = @"Tue, 23 Apr 2013 8:51:15 GMT";
//    NSError *error = nil;
//    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:&error];
//    NSArray *matches = [detector matchesInString:rfc3339DateTimeString options:0 range:NSMakeRange(0, [rfc3339DateTimeString length])];
//    for (NSTextCheckingResult *match in matches) {
//        NSLog(@"Detected Date: %@", match.date);           // => 2011-11-24 14:00:00 +0000
//        NSLog(@"Detected Time Zone: %@", match.timeZone);  // => (null)
//        NSLog(@"Detected Duration: %f", match.duration);   // => 0.000000
//    }
//    
//    return userVisibleDateTimeString;
//}


// Tue, 23 Apr 2013 9:29:43 GMT
+(NSDate *) dateWithDayDateMonthYearGMT:(NSString *) dateString; {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"E, d M yyyy H:m:s Z"];
    // NSDate *myDate = [dateFormatter dateFromString:@"Sun, 06 Nov 1994 08:49:37 GMT"];
    NSDate *myDate = [dateFormatter dateFromString:@"Tue, 23 Apr 2013 8:51:15 GMT"];
    
    // Tue, 23 Apr 2013 8:51:15 GMT
	//NSDate *myDate = [dateFormatter dateFromString:dateString];
	
    //NSLog(@"dateString to %@ nsdate %@ ", dateString, myDate);
    return myDate;
}

+ (NSString *) getUniqueKey: (NSDate *) dateValue
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYMMddHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    return dateString;
}

+ (NSString *) getDateOnly: (NSDate *) dateValue
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *myDayString = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateValue]];
    return myDayString;
}

+ (NSString *) stringFromDate: (NSDate *) dateValue
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:dateValue];
    // NSLog(@"stringFromDate %@",strDate);
    return strDate;
}

+ (NSString *)getUTCFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone =  [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

+ (NSString *)localDate_hhmmaMMMMdd:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone =  [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"hh:mma, MMMM dd"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

+(void) getTimeDifferenceIn:(NSString *)language{
    NSString *str = [NSString stringWithFormat:@"2011-01-13T17:00:00+11:00"];

    // convert to date
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss'+11:00'"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"Australia/Melbourne"]];
    // NSDate *dte = [dateFormat dateFromString:str];
   //  NSLog(@"Date: %@", dte);
    
    if ([[language lowercaseString] isEqualToString:@"english"]) {
        
    }
    else {
        
    }
}


+(NSString *) getFirstWord:(NSString *)strWord;{
    @try {
        NSRange whiteSpaceRange = [strWord rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
        if (whiteSpaceRange.location > 1) {
            return [strWord substringToIndex:whiteSpaceRange.location];
        }
        else {
            return strWord;
        }
    }
    @catch (NSException *exception) {
        return strWord;
    }
}


+(void) showMessageBoxTitle:(NSString *)msgTitle andMessage: (NSString *)msgMessage {
    UIAlertView *messageBox = [[UIAlertView alloc] initWithTitle:msgTitle
                                                         message:msgMessage delegate:nil
                                               cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [messageBox show];
}

+ (BOOL)validateEmailWithString:(NSString*)email; {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSString *) getUUID; {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        // This is will run if it is iOS6
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return @"error";
}

+ (BOOL) openSafariWithLink: (NSString *) urlLink {
    NSURL *url = [NSURL URLWithString:urlLink];
    [[UIApplication sharedApplication] openURL:url];
    return TRUE;
}

+ (BOOL) makePhoneCallWithNumber: (NSString *) phoneNumber;
{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
//    NSString *URLString = [@"tel:" stringByAppendingString:phoneNumber];
//    NSURL *URL = [NSURL URLWithString:URLString];
//    [[UIApplication sharedApplication] openURL:URL];
    return TRUE;
}

+ (BOOL) sendEmailTo:(NSString *)emailID withSubject:(NSString *)eSubject andBody:(NSString *)eBody; {
    NSString *email = @"mailto:";
    email = [email stringByAppendingString:emailID];
//    email = [email stringByAppendingString:@"&subject=%@"];
//    email = [email stringByAppendingString:eSubject];
//    email = [email stringByAppendingString:@"&body="];
//    email = [email stringByAppendingString:eBody];
    
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    return TRUE;
}

+ (BOOL) saveUserDefault:(NSString *)stringObject forKey:(NSString *)keyString ; {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:stringObject forKey:keyString];
    [userDefaults synchronize];
    return TRUE;
}

+ (NSString *) getUserDefault:(NSString *)itemKey; {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:itemKey];
}

+ (NSString *) getOverlayImageName; {
    int deviceHeight;
    deviceHeight = (int)[[UIScreen mainScreen] bounds].size.height;
    
    NSString *imageName = [[NSString alloc] init];
    if (deviceHeight==568) {
        imageName = @"CameraOverlay_iPhone5";
    }
    else {
        imageName = @"CameraOverlay";
    }

    return imageName;
}

@end
