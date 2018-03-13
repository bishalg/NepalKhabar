//
//  NKYahooWeather.m
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 5/5/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import "YahooWeatherParser.h"
#import "NKUtil.h"

@implementation YahooWeatherParser {
    NSMutableArray *forecasts;
    NSMutableArray *location;
    NSMutableArray *condition;
    NSMutableArray *wind;
    NSMutableArray *atmosphere;
    NSMutableArray *astronomy;
    NSXMLParser *parser;
    NSString *element;
}

-(void) parseWeather {
//    weatherSection.frame=CGRectMake(0, 0, self.view.frame.size.width, 25);
    NSURL *url = [NSURL URLWithString:@"http://weather.yahooapis.com/forecastrss?w=23706799&u=c"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    // [parser setDelegate:self];
    // [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    // NSLog(@"Parser Done");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    // NSLog(@" Result: %@", element);

//    if ([element isEqualToString:@"yweather:forecast"]) {
//        [forecasts addObject:attributeDict];
//       NSLog(@"High Temp : %@",[[forecasts objectAtIndex:0]  objectForKey:@"high"]);
//        
//        NSString *high = [NKUtil getNepaliTimeValue:[[forecasts objectAtIndex:0]  objectForKey:@"high"]];
//        NSString *ht =[NSString stringWithFormat:@"↑%@°",high];
//        // [htemp setText:ht];
//       
//        NSString *low = [NKUtil getNepaliTimeValue:[[forecasts objectAtIndex:0]  objectForKey:@"low"]];
//        NSString *lt =[NSString stringWithFormat:@"↓%@°",low];
////       [Ltemp setText:lt];
//        
//    }
//    if ([element isEqualToString:@"yweather:location"]) {
//        [location addObject:attributeDict];
//        NSLog(@"Location  %@",location);
//    }
//    if ([element isEqualToString:@"yweather:condition"]) {
//        [condition addObject:attributeDict];
//        NSLog(@"Location  %@",condition);
//        
//       NSString *test = [NKUtil getNepaliTimeValue:[[condition objectAtIndex:0]  objectForKey:@"temp"]];
//       NSString *ctemp =[NSString stringWithFormat:@"%@°c",test];
//      
////        [lbltemp setFrame:CGRectMake(250, 110, 84, 43)];
////        [lbltemp setText:ctemp];
//       
//    }
//   if ([element isEqualToString:@"yweather:wind"]) {
//        [wind addObject:attributeDict];
//       NSLog(@"Location  %@",wind);
//    }
//    if ([element isEqualToString:@"yweather:atmosphere"]) {
//       [atmosphere addObject:attributeDict];
//        NSString *h = [NKUtil getNepaliTimeValue:[[atmosphere objectAtIndex:0]  objectForKey:@"humidity"]];
//        NSString *hu =[NSString stringWithFormat:@"H:%@",h];
////        [lblhum setText:hu];
//        
//        NSString *v = [NKUtil getNepaliTimeValue:[[atmosphere objectAtIndex:0]  objectForKey:@"visibility"]];
//        NSString *vi =[NSString stringWithFormat:@"V:%@",v];
////        [lblvisi setText:vi];
////        
//    }
//    if ([element isEqualToString:@"yweather:astronomy"]) {
//        [astronomy addObject:attributeDict];
//        NSLog(@"Location  %@",astronomy);
//         NSString *sr =[NSString stringWithFormat:@"☼↑%@",[[astronomy objectAtIndex:0]  objectForKey:@"sunrise"] ];
////        // [lblsunr setText:sr];
//
//        NSString *sur = [NKUtil getNepaliTimeValue:[[astronomy objectAtIndex:0]  objectForKey:@"sunrise"]];
//        NSString *sunrise =[NSString stringWithFormat:@"☼↑%@",sur];
////        [lblsunr setText:sunrise];
//        
//        NSString *sus = [NKUtil getNepaliTimeValue:[[astronomy objectAtIndex:0]  objectForKey:@"sunset"]];
//        NSString *sunset =[NSString stringWithFormat:@"☼↓%@",sus];
////        [lblsuns setText:sunset];
//       NSString *ss =[NSString stringWithFormat:@"☼↓%@",[[astronomy objectAtIndex:0]  objectForKey:@"sunset"] ];
////        //        [lblsuns setText:ss];
//  }
}
    
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    forecasts=[NSMutableArray array];
    location=[NSMutableArray array];
    condition=[NSMutableArray array];
    wind=[NSMutableArray array];
    atmosphere=[NSMutableArray array];
    astronomy=[NSMutableArray array];
}


@end


