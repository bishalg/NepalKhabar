//
//  NKNewsSourceItems.h
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 5/2/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsSources : NSObject

@property(nonatomic, strong) NSMutableArray* title;        // Title of News
@property(nonatomic, strong) NSMutableArray* mainLink;  //  Description of news
@property(nonatomic, strong) NSMutableArray* language;      // Link to the orginal News
@property(nonatomic, strong) NSMutableArray* imageName;      // Guide URL
@property(nonatomic, strong) NSMutableArray* labelName;      // News Published Date
@property(nonatomic, strong) NSMutableDictionary* category;      // Media URL

- (void)initWithDictionary:(NSDictionary *)dict;

@end
