//
// SCYahooWeatherParser.m
// SCYahooWeather
//
// Version History
// ----
//  * 0.1 (2011-06-25): created by sweetchili
//  * 0.2 (2013-03-18): upgraded to support ARC by josh-fuggle
//  * 0.3 (2013-03-18): added support for delegation by josh-fuggle
// 
// This file is part of SCYahooWeather.
//
// SCYahooWeather is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// SCYahooWeather is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with SCYahooWeather.  If not, see <http://www.gnu.org/licenses/>.
//

#import "SCYahooWeatherParser.h"
#import "NKUtil.h"
#import "NKConstants.h"


@interface SCYahooWeatherParser () <NSXMLParserDelegate>
@property (weak, readwrite) id <SCYahooWeatherParserDelegate> delegate;
@property (strong) NSDictionary *data;
@property (readwrite) NSInteger WOEID;
@property (readwrite) SCWeatherUnit unit;
@end

@implementation SCYahooWeatherParser

bool forcastFound;

#pragma mark - Public API
- (id)initWithWOEID:(NSInteger)WOEID weatherUnit:(SCWeatherUnit)unit delegate:(id <SCYahooWeatherParserDelegate>)delegate
{
    if (self = [super init]) {
        self.WOEID = WOEID;
        self.unit = unit;
        self.delegate = delegate;
    }
    return self;
}

- (void)parse
{
    
     // NSString *URLString= @"http://api.worldweatheronline.com/free/v1/weather.ashx?q=kathmandu&format=json&num_of_days=5&key=9r48d6cdm3p6wd75z8vuaq9c";
     
    NSString *URLString = [NSString stringWithFormat:kSCYahooWeatherRequestURL, self.WOEID, [self weatherUniString]];
    NSURL *URL = [[NSURL alloc] initWithString:URLString];
    
    // Begin parsing in a background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
        xmlParser.delegate = self;
        
        [xmlParser parse];
    });
    // NSLog(@"URL %@",URL);
}

#pragma mark NSXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
 
    SCWeather *weather = [SCWeather new];
    if([elementName isEqualToString:kSCKeyCondition]) {
        weather.weatherString = attributeDict[kSCTagText_Condition];
        [NKUtil saveUserDefault:attributeDict[kSCTagText_Condition] forKey:kSCTagText_Condition];
        
        weather.temperature = [attributeDict[kSCTagTemp_Condition] intValue];
        [weather.conditionNow setObject:attributeDict[kSCTagTemp_Condition] forKey:kSCTagTemp_Condition];
         [NKUtil saveUserDefault:attributeDict[kSCTagTemp_Condition] forKey:kSCTagTemp_Condition];
        
        [NKUtil saveUserDefault:attributeDict[kSCTagCode_Condition] forKey:kSCTagCode_Condition];
        weather.condition = [attributeDict[kSCTagCode_Condition] intValue];
        
    } else if([elementName isEqualToString:kSCKeyAstronomy]) {
        weather.astronomy = [[NSMutableDictionary alloc] init];
        [weather.astronomy setObject:attributeDict[kSCTagSunrise_Astronomy] forKey:kSCTagSunrise_Astronomy];
        [NKUtil saveUserDefault:attributeDict[kSCTagSunrise_Astronomy] forKey:kSCTagSunrise_Astronomy];
        
        [weather.astronomy setObject:attributeDict[kSCTagSunset_Astronomy] forKey:kSCTagSunset_Astronomy];
        [NKUtil saveUserDefault:attributeDict[kSCTagSunset_Astronomy] forKey:kSCTagSunset_Astronomy];
        
    } else if([elementName isEqualToString:kSCKeyAtmosphere]) {
        weather.atmosphere = [[NSMutableDictionary alloc] init];
        [weather.atmosphere setObject:attributeDict[kSCTagHumidity_Atmosphere] forKey:kSCTagHumidity_Atmosphere];
        [NKUtil saveUserDefault:attributeDict[kSCTagHumidity_Atmosphere] forKey:kSCTagHumidity_Atmosphere];
        
        [weather.atmosphere setObject:attributeDict[kSCTagVisibility_Atmosphere] forKey:kSCTagVisibility_Atmosphere];
        [NKUtil saveUserDefault:attributeDict[kSCTagVisibility_Atmosphere] forKey:kSCTagVisibility_Atmosphere];
        
        [weather.atmosphere setObject:attributeDict[kSCTagPressure_Atmosphere] forKey:kSCTagPressure_Atmosphere];
        [NKUtil saveUserDefault:attributeDict[kSCTagPressure_Atmosphere] forKey:kSCTagPressure_Atmosphere];
        
        [weather.atmosphere setObject:attributeDict[kSCTagRising_Atmosphere] forKey:kSCTagRising_Atmosphere];
        [NKUtil saveUserDefault:attributeDict[kSCTagRising_Atmosphere] forKey:kSCTagRising_Atmosphere];
        
    } else if([elementName isEqualToString:kSCKeyWind]) {
        weather.wind = [[NSMutableDictionary alloc] init];
        [weather.wind setObject:attributeDict[kSCTagChill_Wind] forKey:kSCTagChill_Wind];
        [NKUtil saveUserDefault:attributeDict[kSCTagChill_Wind] forKey:kSCTagChill_Wind];
        
        [weather.wind setObject:attributeDict[kSCTagDitection_Wind] forKey:kSCTagDitection_Wind];
        [NKUtil saveUserDefault:attributeDict[kSCTagDitection_Wind] forKey:kSCTagDitection_Wind];
        
        [weather.wind setObject:attributeDict[kSCTagSpeed_Wind] forKey:kSCTagSpeed_Wind];
        [NKUtil saveUserDefault:attributeDict[kSCTagSpeed_Wind] forKey:kSCTagSpeed_Wind];
        
    } else if([elementName isEqualToString:kSCKeyUnits]) {
        weather.units = [[NSMutableDictionary alloc] init];
        [weather.units setObject:attributeDict[kSCTagTemperature_Units] forKey:kSCTagTemperature_Units];
        [NKUtil saveUserDefault:attributeDict[kSCTagTemperature_Units] forKey:kSCTagTemperature_Units];
        
        [weather.units setObject:attributeDict[kSCTagDistance_Unit] forKey:kSCTagDistance_Unit];
        [NKUtil saveUserDefault:attributeDict[kSCTagDistance_Unit] forKey:kSCTagDistance_Unit];
        
        [weather.units setObject:attributeDict[kSCTagPressure_Unit] forKey:kSCTagPressure_Unit];
        [NKUtil saveUserDefault:attributeDict[kSCTagPressure_Unit] forKey:kSCTagPressure_Unit];
        
        [weather.units setObject:attributeDict[kSCTagSpeed_Unit] forKey:kSCTagSpeed_Unit];
        [NKUtil saveUserDefault:attributeDict[kSCTagSpeed_Unit] forKey:kSCTagSpeed_Unit];
        
    } else if([elementName isEqualToString:kSCKeyLocation]) {
        weather.location = [[NSMutableDictionary alloc] init];
        [weather.location setObject:attributeDict[kSCTagCity_Location] forKey:kSCTagCity_Location];
        [NKUtil saveUserDefault:attributeDict[kSCTagCity_Location] forKey:kSCTagCity_Location];
        
        [weather.location setObject:attributeDict[kSCTagRegion_Location] forKey:kSCTagRegion_Location];
        [NKUtil saveUserDefault:attributeDict[kSCTagRegion_Location] forKey:kSCTagRegion_Location];
        
        [weather.location setObject:attributeDict[KSCTagCountry_Location] forKey:KSCTagCountry_Location];
        [NKUtil saveUserDefault:attributeDict[KSCTagCountry_Location] forKey:KSCTagCountry_Location];
        
    } else if([elementName isEqualToString:kSCKeyForecast]) {
        if (!forcastFound) {
            weather.forcast = [[NSMutableDictionary alloc] init];
            [weather.forcast setObject:attributeDict[kSCTagLow_Forecast] forKey:kSCTagLow_Forecast];
            [NKUtil saveUserDefault:attributeDict[kSCTagLow_Forecast] forKey:kSCTagLow_Forecast];
            
            [weather.forcast setObject:attributeDict[kSCTagHigh_Forecast] forKey:kSCTagHigh_Forecast];
            [NKUtil saveUserDefault:attributeDict[kSCTagHigh_Forecast] forKey:kSCTagHigh_Forecast];
            
            [weather.forcast setObject:attributeDict[kSCTagText_Forecast] forKey:kSCTagText_Forecast];
            [NKUtil saveUserDefault:attributeDict[kSCTagHigh_Forecast] forKey:kSCTagHigh_Forecast];
        }
        forcastFound = TRUE;
    } else {
        return;
    }
    
   dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate yahooWeatherParser:self recievedWeatherInformation:weather];
    });
}


#pragma mark - Helper Methods
- (NSString *)weatherUniString
{
    return (self.unit == SCWeatherUnitCelcius ? @"c" : @"f");
}

@end
