//
//  NKConstants.h
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 5/8/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSCYahooWeatherRequestURL @"http://weather.yahooapis.com/forecastrss?w=%d&u=%@"

#define kSCKeyLocation                  @"yweather:location"
#define kSCTagCity_Location             @"city"
#define kSCTagRegion_Location           @"region"
#define KSCTagCountry_Location          @"country"

#define kSCKeyUnits                 @"yweather:units"
#define kSCTagTemperature_Units     @"temperature"
#define kSCTagDistance_Unit         @"distance"
#define kSCTagPressure_Unit         @"pressure"
#define kSCTagSpeed_Unit            @"speed"

#define kSCKeyWind                  @"yweather:wind"
#define kSCTagChill_Wind            @"chill"
#define kSCTagDitection_Wind        @"direction"
#define kSCTagSpeed_Wind            @"speed"

#define kSCKeyAtmosphere                @"yweather:atmosphere"
#define kSCTagHumidity_Atmosphere       @"humidity"
#define kSCTagVisibility_Atmosphere     @"visibility"
#define kSCTagPressure_Atmosphere       @"pressure"
#define kSCTagRising_Atmosphere         @"rising"

#define kSCKeyAstronomy                 @"yweather:astronomy"
#define kSCTagSunrise_Astronomy         @"sunrise"
#define kSCTagSunset_Astronomy          @"sunset"

#define kSCKeyCondition                 @"yweather:condition"
#define kSCTagTemp_Condition            @"temp"
#define kSCTagText_Condition            @"text"
#define kSCTagCode_Condition            @"code"

#define kSCKeyForecast                  @"yweather:forecast"
#define kSCTagDay_Forecast              @"day"
#define kSCTagDate_Forecast             @"date"
#define kSCTagLow_Forecast              @"low"
#define kSCTagHigh_Forecast             @"high"
#define kSCTagText_Forecast             @"text"


@interface NKConstants : NSObject

@end
