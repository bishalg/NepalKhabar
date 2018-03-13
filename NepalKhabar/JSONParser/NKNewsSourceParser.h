//
//  NKNewsSourceParser.h
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 4/25/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsSourceParserDelegate <NSObject>
@required
-(void) jsonParserReady;
@end

@interface NKNewsSourceParser : NSObject

@property (nonatomic, strong) NSMutableArray *newspaperTitle;
@property (nonatomic, strong) NSMutableArray *paperCoverImage;
@property (nonatomic, strong) NSMutableArray *paperName;
@property (nonatomic, strong) NSMutableArray* newspaperMainLink;
@property (nonatomic, strong) NSMutableArray *languageCategory;
@property (nonatomic, strong) NSMutableDictionary* newsCategory;

@property (nonatomic, strong) NSMutableData *receivedData;

@property (nonatomic, unsafe_unretained) id<NewsSourceParserDelegate> delegate;

@end
