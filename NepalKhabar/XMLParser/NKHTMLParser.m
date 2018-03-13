//
//  NKHTMLParser.m
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 5/9/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import "NKHTMLParser.h"
#import "HTMLParser.h"
#import "TFHpple.h"

@interface NKHTMLParser () <NSXMLParserDelegate>
@end

@implementation NKHTMLParser
@synthesize htmlValue;

- (void) parserLink:(NSString *)urlLink withXPath:(NSString *)xPath andXPathName:(NSString *)xPathName; {
    // DLog(@"urlLink %@ xPath %@ xPathName %@",urlLink, xPath, xPathName);
    //urlLink = @"http://www.himalkhabar.com/?p=28860";
    
    // [self rayHTMLParser];
    
    urlLink = [urlLink stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSError *error = nil;
    NSURL *tutorialsUrl = [NSURL URLWithString:urlLink];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
   // NSData  * data      = [NSData dataWithContentsOfFile:@"index.html"];
    // TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:tutorialsHtmlData];
    // NSArray * elements  = [doc search:@"//a[@class='sponsor']"];

    NSString* responseString;
    responseString = [[NSString alloc] initWithData:tutorialsHtmlData encoding:NSUTF8StringEncoding];
    if (!responseString) {
        DLog(@"eror encoding ");
        responseString = [[NSString alloc] initWithData:tutorialsHtmlData encoding:NSASCIIStringEncoding];
    }
    
//    NSString* responseString;
//    responseString = [[NSString alloc] initWithData:tutorialsHtmlData encoding:NSUTF8StringEncoding];
//    if (!responseString) {
//        NSLog(@"use ASCI encoding");
//        responseString = [[NSString alloc] initWithData:tutorialsHtmlData encoding:NSASCIIStringEncoding];
//    }
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:responseString error:&error];
    if (error) {
        DLog(@"Error: %@", error);
    } else {
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            HTMLNode *bodyNode = [parser body];
            NSArray *spanNodes = [bodyNode findChildTags:@"div"];
            NSString *newsFinalString = [[NSString alloc] init];
            for (HTMLNode *spanNode in spanNodes) {
                if ([[spanNode getAttributeNamed:xPathName] isEqualToString:xPath]) {
                    
                    for (HTMLNode *newsContents in [spanNode findChildTags:@"p"]) {
                        newsFinalString = [newsFinalString stringByAppendingString:[newsContents rawContents]];
                    }
                    
//                    NSArray *toolBoxs = [spanNode findChildTags:@"div"];
//                    for (HTMLNode *mySpanNode in toolBoxs) {
//                        if ([[mySpanNode getAttributeNamed:xPathName] isEqualToString:@"addthis_toolbox addthis_default_style "]) {
//                            NSLog(@"found");
//                            
//                        }
//                    }
                } // if
            } // for
            htmlValue = newsFinalString ;
            [self.delegate processCompleted];
        }); // dispatch
    } // else
} // void

-(void) rayHTMLParser {
    
    // 1
    NSURL *tutorialsUrl = [NSURL URLWithString:@"http://www.raywenderlich.com/tutorials"];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    // 2
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    // 3
    NSString *tutorialsXpathQueryString = @"//div[@class='entry']/ul/li/a";
    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
    
    // 4
    // NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in tutorialsNodes) {
        // 5
//        Tutorial *tutorial = [[Tutorial alloc] init];
//        [newTutorials addObject:tutorial];
        
        // 6
//        tutorial.title = [[element firstChild] content];
        
        // 7
//        tutorial.url = [element objectForKey:@"href"];
        // NSLog(@"title %@ url %@", [[element firstChild] content],[element objectForKey:@"href"]);
    }
    
}




-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
}


@end
