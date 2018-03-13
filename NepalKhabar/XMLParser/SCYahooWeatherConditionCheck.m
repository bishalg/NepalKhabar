//
//  SCYahooWeatherConditionCheck.m
//  Nepalkhabar
//
//  Created by Rowin on 24/06/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//
//छिटपुट बर्षा , भारी बर्षा , आन्सिक बर्षा , सफा मौसम , आन्सिक बादल , हुरी बतास, 
//हल्का बर्षा-9,  असिन बर्षा-17-18,         

/* Raining */
#define MIXEDRAINANDSNOW [code isEqualToString:@"5"]
#define MIXEDRAINANDSLEET [code isEqualToString:@"6"]
#define MIXEDSNOWANDSLEET [code isEqualToString:@"7"]
#define FEXXINGDRIZZLE [code isEqualToString:@"8"]
#define DRIZZLE [code isEqualToString:@"9"]
#define FREZINGRAIN [code isEqualToString:@"10"]
#define SHOWERS11 [code isEqualToString:@"11"]
#define SHOWERS12 [code isEqualToString:@"12"]
#define SNOWFLURRIES [code isEqualToString:@"13"]
#define LIGHTSNOWSHOWERS [code isEqualToString:@"14"]
#define BLOWINGSNOW [code isEqualToString:@"15"]
#define SNOW [code isEqualToString:@"16"]
#define HAIL [code isEqualToString:@"17"]
#define SLEET [code isEqualToString:@"18"]
#define MIXEDRAINANDHAIL [code isEqualToString:@"35"]
#define HEAVYSNOW43 [code isEqualToString:@"43"]
#define SCATTEREDSNOWSHOWERS [code isEqualToString:@"42"]
#define HEAVYSNOW41 [code isEqualToString:@"41"]
#define SNOWSHOWERS [code isEqualToString:@"46"]
#define SCATTEREDSHOWERS [code isEqualToString:@"40"]
#define RAINING @"raining"
#define NPRAINING @"बर्षा"

/* tornado */
#define TORNADO [code isEqualToString:@"0"]
#define TROPICALSTROM [code isEqualToString:@"1"]
#define HURRICANE [code isEqualToString:@"2"]
#define TORNADO1 @"tornado"
#define NPTORNADO @"हुरी बतास"

/* Thunderstorm */
#define THUNDERSTROMS [code isEqualToString:@"3"]
#define ISOLATEDTHUNDERSTORMS [code isEqualToString:@"37"]
#define SCATTEREDTHUNDERSTORMS38 [code isEqualToString:@"38"]
#define SCATTEREDTHUNDERSTORMS39 [code isEqualToString:@"39"]
#define THUNDERSHOWERS [code isEqualToString:@"45"]
#define THUNDERSTORMS [code isEqualToString:@"4"]
#define ISOLATEDTHUNDERSHOWERS [code isEqualToString:@"47"]
#define THUNDERSTROM @"thunderstorm"
#define NPTHUNDERSTROM @"गड गडाहट बर्षा"

/*  cloudy */
#define DUST [code isEqualToString:@"19"]
#define FOGGY [code isEqualToString:@"20"]
#define HAZE [code isEqualToString:@"21"]
#define SMOKY [code isEqualToString:@"22"]
#define BLUSTERY [code isEqualToString:@"23"]
#define WINDY [code isEqualToString:@"24"]
#define COLD [code isEqualToString:@"25"]
#define CLOUDY [code isEqualToString:@"26"]
#define CLOUDYNIGHT27 [code isEqualToString:@"27"]
#define CLOUDYDAY28 [code isEqualToString:@"28"]
#define CLOUDY1 @"cloudy"
#define NPCLOUDY1 @"आन्सिक बादल"
/* sunnyday */
#define SUNNY [code isEqualToString:@"32"]
#define HOT [code isEqualToString:@"36"]
#define FAIRDAY [code isEqualToString:@"34"]
#define SUNNYDAY @"sunnyday"
#define NPSUNNYDAY @"सफा मौसम"

/* Clear nite */
#define CLEARNIGHT [code isEqualToString:@"31"]
#define FAIRNIGHT [code isEqualToString:@"33"]
#define CLEAR_NITE @"clear_nite"
#define NPCLEAR_NITE @"सफा मौसम"

/* partially_sunnyday */
#define CLOUDYNIGHT29 [code isEqualToString:@"29"]
#define CLOUDYDAY30 [code isEqualToString:@"30"]
#define PARTLYCLOUDY [code isEqualToString:@"44"]
#define PARTIALLY_SUNNYDAY @"partially_sunnyday"
#define NPPARTIALLY_SUNNYDAY @"आन्सिक बादल"


#import "SCYahooWeatherConditionCheck.h"

@implementation SCYahooWeatherConditionCheck
-(NSArray*)yahooWeatherConditionCheck:(NSString*)code{
  // NSLog(@"code: %@",code);
    NSArray *myArray;      
    if (MIXEDRAINANDSNOW || MIXEDRAINANDSLEET || MIXEDSNOWANDSLEET || FEXXINGDRIZZLE || DRIZZLE || FREZINGRAIN ||SHOWERS11 || SHOWERS12 || SNOWFLURRIES || LIGHTSNOWSHOWERS || BLOWINGSNOW || SNOW || HAIL || SLEET || MIXEDRAINANDHAIL || HEAVYSNOW43 || SCATTEREDSNOWSHOWERS || HEAVYSNOW41 || SNOWSHOWERS || SCATTEREDSHOWERS) {
       myArray = [NSArray arrayWithObjects:RAINING, NPRAINING, nil];
    }
    else if (TORNADO||TROPICALSTROM||HURRICANE) {
         myArray = [NSArray arrayWithObjects:TORNADO1, NPTORNADO, nil];
    }
    else if (THUNDERSTROMS||ISOLATEDTHUNDERSTORMS||SCATTEREDTHUNDERSTORMS38||SCATTEREDTHUNDERSTORMS39||THUNDERSHOWERS||THUNDERSTORMS||ISOLATEDTHUNDERSHOWERS) {
         myArray = [NSArray arrayWithObjects:THUNDERSTROM, NPTHUNDERSTROM, nil];
    }
    else if (DUST || FOGGY || HAZE || SMOKY || BLUSTERY || WINDY || COLD || CLOUDY || CLOUDYNIGHT27 || CLOUDYDAY28) {
          myArray = [NSArray arrayWithObjects:CLOUDY1, NPCLOUDY1, nil];
    }
    else if (SUNNY || HOT || FAIRDAY) {
         myArray = [NSArray arrayWithObjects:SUNNYDAY, NPSUNNYDAY, nil];
    }
    else if (CLEARNIGHT || FAIRNIGHT) {
          myArray = [NSArray arrayWithObjects:CLEAR_NITE, NPCLEAR_NITE, nil];
    }
    else if (CLOUDYNIGHT29 || CLOUDYDAY30 || PARTLYCLOUDY) {
         myArray = [NSArray arrayWithObjects:PARTIALLY_SUNNYDAY, NPPARTIALLY_SUNNYDAY, nil];
    }
    return myArray;
}

@end
