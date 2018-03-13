//
//  BlogRSS.h
//  NepalKhabar
//
//  Created by Bishal Ghimire on 4/16/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogRSS : NSObject {
    NSString* title;        // Title of News
    NSString* description;  //  Description of news
    NSString* linkUrl;      // Link to the orginal News
    NSString* guidUrl;      // Guide URL
    NSDate* pubDate;      // News Published Date
    NSString* mediaUrl;      // Media URL
}

@property(nonatomic, strong) NSString* title;        // Title of News
@property(nonatomic, strong) NSString* description;  //  Description of news
@property(nonatomic, strong) NSString* linkUrl;      // Link to the orginal News
@property(nonatomic, strong) NSString* guidUrl;      // Guide URL
@property(nonatomic, strong) NSDate* pubDate;      // News Published Date
@property(nonatomic, strong) NSString* mediaUrl;      // Media URL

- (void)initWithDictionary:(NSDictionary *)dict;

@end
