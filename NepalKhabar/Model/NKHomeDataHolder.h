//
//  NKHomeDataHolder.h
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 4/07/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKHomeDataHolder : NSObject

@property (copy, nonatomic) NSString *rssURL;
@property (copy, nonatomic) NSString *rssLanguage;

@property (copy, nonatomic) NSString *xPath;
@property (copy, nonatomic) NSString *xPathName;

@property (nonatomic, assign) NSArray *categoryName;
@property (nonatomic, assign) NSArray *categoryLink;
@property (nonatomic, assign) NSString *categoryID;

@property (nonatomic, assign) NSString *newsTitle;

@end
