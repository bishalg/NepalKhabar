//
//  NKNewsSourceParser.m
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 4/25/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import "NKNewsSourceParser.h"
#import "NKUtil.h"

@implementation NKNewsSourceParser

@synthesize newspaperTitle;
@synthesize paperCoverImage;
@synthesize paperName;
@synthesize newspaperMainLink;
@synthesize newsCategory;
@synthesize languageCategory;

@synthesize receivedData;
@synthesize delegate;


- (void) getNewsSource {
    @try {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"exibtor" ofType:@"json"];
        NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *arrayExhibitorList = [jsonObject objectForKey:@"exhibitorList"];
        for (int i=0; i<[arrayExhibitorList count]; i++) {
            NSDictionary *dictExhibitor = [arrayExhibitorList objectAtIndex:i];
            
            if ([dictExhibitor objectForKey:@"labelName"] == [NSNull null]) {
                [self.paperName addObject:@"labelName"];
            }
            else {
                [self.paperName addObject:[dictExhibitor objectForKey:@"labelName"]];
            }
            
            if ([dictExhibitor objectForKey:@"title"] == [NSNull null]) {
                [self.newspaperTitle addObject:@"title"];
            }
            else {
                [self.newspaperTitle addObject:[dictExhibitor objectForKey:@"title"]];
            }
            
            if ([dictExhibitor objectForKey:@"language"] == [NSNull null]) {
                [self.languageCategory addObject:@"language"];
            }
            else {
                [self.languageCategory addObject:[dictExhibitor objectForKey:@"language"]];
            }
            
            if ([dictExhibitor objectForKey:@"mainLink"] == [NSNull null]) {
                [self.newspaperMainLink addObject:@"mainLink"];
            }
            else {
                [self.newspaperMainLink addObject:[dictExhibitor objectForKey:@"mainLink"]];
            }
            
            if ([dictExhibitor objectForKey:@"imageName"] == [NSNull null]) {
                [self.paperCoverImage addObject:@"imageName"];
            }
            else {
                [self.paperCoverImage addObject:[dictExhibitor objectForKey:@"imageName"]];
            }
            
            NSArray* dictProductImages = [dictExhibitor valueForKeyPath:@"images.img"] ;
            NSString *keyID = [NSString stringWithFormat:@"%@",[dictExhibitor objectForKey:@"id"]];
            [self.newsCategory setObject:dictProductImages forKey:keyID];
        }
                // [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (self.delegate != nil) {
            [self.delegate jsonParserReady];
        }
    }
    @catch (NSException *exception) {
        [NKUtil showMessageBoxTitle:@"Error !" andMessage:@"Exhibitor Parsing Error"];
    }
    @finally {
        
    }
}


@end
