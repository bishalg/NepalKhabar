//
//  Contributor.h
//  HTMLParsing
//
//  Created by Matt Galloway on 20/05/2012.
//  Copyright (c) 2012 Swipe Stack Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contributor : NSObject {
     NSString *name;
     NSString *url;
     NSString *imageUrl;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *imageUrl;


- (void)initWithDictionary:(NSDictionary *)dict;

@end
