//
//  NKDateConverter.h
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 4/26/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKDateConverter : NSObject

- (int) getDayOfTheWeek:(NSDate *)date;
-(NSString *) getNepaliDay:(NSUInteger) englishDay;
-(NSString *) getNepaliMonth:(NSDate *) englishDate;

@end
