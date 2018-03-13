//
//  Tutorial.h
//  HTMLParsing
//
//  Created by Matt Galloway on 20/05/2012.
//  Copyright (c) 2012 Swipe Stack Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tutorial : NSObject {
     NSString *title;
     NSString *url;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;

- (void)initWithDictionary:(NSDictionary *)dict;

@end
