//
//  NKLocalJSON.h
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 5/2/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsSources;

@protocol NewsSourceDelegate <NSObject>

@required
-(void) jsonParserReady;
-(void) jsonParserConnectionFailed;
@optional

@end

@interface NKLocalJSONParser : NSObject {
    NSMutableDictionary *item;
}

@property(nonatomic, strong) NSMutableArray* title;        // Title of News
@property(nonatomic, strong) NSMutableArray* mainLink;  //  Description of news
@property(nonatomic, strong) NSMutableArray* language;      // Link to the orginal News
@property(nonatomic, strong) NSMutableArray* imageName;      // Guide URL
@property(nonatomic, strong) NSMutableArray* labelName;      // News Published Date
@property(nonatomic, strong) NSMutableDictionary* categoryTitle;      // Media URL
@property(nonatomic, strong) NSMutableDictionary* categoryLink;      // Media URL
@property(nonatomic,strong) NSMutableArray *categoryID;
@property(nonatomic, strong) NSMutableArray *xpath;                 // xPath
@property(nonatomic, strong) NSMutableArray *xpathName;             // xPathName

@property (nonatomic, unsafe_unretained) id<NewsSourceDelegate> delegate;
@property (nonatomic, retain) NewsSources *currentItem;

-(void) convertNewsSource:(NSString *)jsonFileName;

@end
