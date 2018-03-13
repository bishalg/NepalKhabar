//
//  NKLocalJSON.m
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 5/2/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import "NKLocalJSONParser.h"
#import "NKHomeVC.h"

@implementation NKLocalJSONParser

@synthesize delegate;
@synthesize currentItem;

@synthesize title;        // Title of News
@synthesize mainLink;  //  Description of news
@synthesize language;      // Link to the orginal News
@synthesize imageName;      // Guide URL
@synthesize labelName;      // News Published Date
@synthesize categoryTitle;      // Media URL
@synthesize categoryLink;
@synthesize categoryID;
@synthesize xpath;
@synthesize xpathName;

#pragma mark -
#pragma mark Object Methods
- (id) init {
    self = [super init];
    if (self) {
        title = [[NSMutableArray alloc] initWithCapacity:50];
        mainLink = [[NSMutableArray alloc] initWithCapacity:50];
        language = [[NSMutableArray alloc] initWithCapacity:50];
        imageName = [[NSMutableArray alloc] initWithCapacity:50];
        labelName = [[NSMutableArray alloc] initWithCapacity:50];
        xpath = [[NSMutableArray alloc] initWithCapacity:50];
        xpathName = [[NSMutableArray alloc] initWithCapacity:50];
        categoryTitle = [[NSMutableDictionary alloc] initWithCapacity:150];
        categoryLink = [[NSMutableDictionary alloc] initWithCapacity:150];
        categoryID = [[NSMutableArray alloc] initWithCapacity:50];
        
        [title removeAllObjects];
        [mainLink removeAllObjects];
        [imageName removeAllObjects];
        [language removeAllObjects];
        [xpath removeAllObjects];
        [xpathName removeAllObjects];
        [categoryLink removeAllObjects];
        [categoryID removeAllObjects];
        [categoryTitle removeAllObjects];
    }
    return self;
}


-(void) convertNewsSource:(NSString *)jsonFileName  {
    @try {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:jsonFileName ofType:@"json"];
        NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
        
         NSArray *arrayExhibitorList = [jsonObject objectForKey:@"newspaper"];
        for (int i=0; i<[arrayExhibitorList count]; i++) {
            NSDictionary *dictExhibitor = [arrayExhibitorList objectAtIndex:i];
         
            if ([dictExhibitor objectForKey:@"title"] == [NSNull null]) {
                [title addObject:@"title"];
            }
            else {
                [title addObject:[dictExhibitor objectForKey:@"title"]];
            }
            if ([dictExhibitor objectForKey:@"labelName"]==[NSNull null]) {
                [labelName addObject:@"labelName"];
                 
            }
            else{
                [labelName addObject:[dictExhibitor objectForKey:@"labelName"]];
            }
            
            if ([dictExhibitor objectForKey:@"mainLink"] == [NSNull null]) {
                [mainLink addObject:@"mainLink"];
            }
            else {
                [mainLink addObject:[dictExhibitor objectForKey:@"mainLink"]];
            }
            
            if ([dictExhibitor objectForKey:@"imageName"] == [NSNull null]) {
                [imageName addObject:@"imageName"];
            }
            else {
                [imageName addObject:[dictExhibitor objectForKey:@"imageName"]];
            }
           
            if ([dictExhibitor objectForKey:@"language"] == [NSNull null]) {
                [language addObject:@"language"];
            }
            else {
                [language addObject:[dictExhibitor objectForKey:@"language"]];
            }
            
            if ([dictExhibitor objectForKey:@"xpath"] == [NSNull null]) {
                [xpath addObject:@"xpath"];
            }
            else {
                [xpath addObject:[dictExhibitor objectForKey:@"xpath"]];
            }

            if ([dictExhibitor objectForKey:@"xpathName"] == [NSNull null]) {
                [xpathName addObject:@"xpathName"];
            }
            else {
                [xpathName addObject:[dictExhibitor objectForKey:@"xpathName"]];
            }
            
            NSArray* categoryLinkValue = [dictExhibitor valueForKeyPath:@"category.links"];
            NSArray* categoryTitleValue = [dictExhibitor valueForKeyPath:@"category.title"];
            
            NSString *keyID = [NSString stringWithFormat:@"%@",[dictExhibitor objectForKey:@"id"]];
            [categoryLink setObject:categoryLinkValue forKey:keyID];
            [categoryTitle setObject:categoryTitleValue forKey:keyID];
            [categoryID addObject:[dictExhibitor objectForKey:@"id"]];
        }
        if (self.delegate != nil) {
            [self.delegate jsonParserReady];
        }
    }
    @catch (NSException *exception) {
        DLog(@"error parsing local news source json");
        if (self.delegate != nil) {
            [self.delegate jsonParserConnectionFailed];
        }
    }
    @finally {
    
    }
}

@end
