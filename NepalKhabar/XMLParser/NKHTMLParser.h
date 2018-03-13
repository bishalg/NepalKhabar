//
//  NKHTMLParser.h
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 5/9/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol NKHTMLParserDelegate;

@interface NKHTMLParser : NSObject
// - (void)parse;

@property (nonatomic, assign) id<NKHTMLParserDelegate> delegate;
@property (readonly) NSInteger WOEID;
@property (nonatomic, strong) NSString *htmlValue;

- (void) parserLink:(NSString *)urlLink withXPath:(NSString *)xPath andXPathName:(NSString *)xPathName;

@end

@protocol NKHTMLParserDelegate <NSObject>
- (void)processCompleted;
// -(void)processHasErrors;

@end


