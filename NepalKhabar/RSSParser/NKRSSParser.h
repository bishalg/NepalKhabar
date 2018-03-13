//
//  NKRSSParser.h
//  NepalKhabar
//
//  Created by Bishal Ghimire on 4/16/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFXMLRequestOperation.h>

@class BlogRSS;

@protocol BlogRssParserDelegate;

@interface NKRSSParser : NSObject <NSXMLParserDelegate>
{
    NSString *gRssURL;
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *pubDate;
    NSMutableString *link;
    NSMutableString *description;
    NSString *element;
    NSString *tmpInnerTagText;
}
@property (nonatomic, retain)  AFXMLRequestOperation *operation;
@property (nonatomic, retain) BlogRSS *currentItem;
@property (readonly) NSMutableArray *rssItems;

@property (nonatomic, assign) id<BlogRssParserDelegate> delegate;
@property (nonatomic, retain) NSOperationQueue *retrieverQueue;

- (void)startProcess:(NSString *)rssURL;
@end

@protocol BlogRssParserDelegate <NSObject>
-(void)processCompleted;
-(void)processHasErrors;
@end