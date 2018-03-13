//
//  NKRSSParser.m
//  NepalKhabar
//
//  Created by Bishal Ghimire on 4/16/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import "NKRSSParser.h"
#import "BlogRss.h"
#import <AFHTTPClient.h>
#import "NKUtil.h"


@implementation NKRSSParser{

}

@synthesize currentItem;
@synthesize rssItems = _rssItems;
@synthesize delegate = _delegate;
@synthesize retrieverQueue = _retrieverQueue;
@synthesize operation;

- (id)init{
	if(![super init]){
		return nil;
	}
	_rssItems = [[NSMutableArray alloc]init];
	return self;
}

- (NSOperationQueue *)retrieverQueue {
	if(nil == _retrieverQueue) {
		_retrieverQueue = [[NSOperationQueue alloc] init];
		_retrieverQueue.maxConcurrentOperationCount = 1;
	}
	return _retrieverQueue;
}

- (void)startProcess:(NSString *)rssURL{
    gRssURL = rssURL;
//    [self fetchAndParseRss:rssURL];
	SEL method = @selector(fetchAndParseRss:);
	[[self rssItems] removeAllObjects];
	NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self
																	 selector:method
																	   object:nil];
	[self.retrieverQueue addOperation:op];
}

-(BOOL) shouldRefresh {
    BOOL downloadFromServer = NO;
    
    NSURL *url = [NSURL URLWithString:gRssURL];
    NSString *lastModifiedString = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"HEAD"];
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: NULL];
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        lastModifiedString = [[response allHeaderFields] objectForKey:@"Last-Modified"];
    }
   // NSLog(@"all header fields %@",[response allHeaderFields]);
    
    NSDate *lastModifiedServer = nil;
    @try {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
        df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        lastModifiedServer = [df dateFromString:lastModifiedString];
    }
    @catch (NSException * e) {
        DLog(@"Error parsing last modified date: %@ - %@", lastModifiedString, [e description]);
    }
    // DLog(@"lastModifiedServer: %@", lastModifiedServer);
    
    return downloadFromServer;
}


-(BOOL)fetchAndParseRss:(NSString *)rssURL{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    BOOL success = NO;
    
    /// gRssURL = @"http://guntree.co.za/index.php?option=com_listbingoapp&task=front.mainconfig";
      NSURL *url = [NSURL URLWithString:gRssURL];
    [[NSURLCache sharedURLCache] setMemoryCapacity:4*1024*1024];
    [[NSURLCache sharedURLCache] setDiskCapacity:20*1024*1024];
    
    [self shouldRefresh];
        
   //  NSLog(@"ParseRss %@",url);
    @try {
        
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //dispatch_async(dispatch_get_main_queue(), ^{
            // feeds = [[NSMutableArray alloc] init];
//            parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
//            [parser setDelegate:self];
//            [parser setShouldResolveExternalEntities:NO];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
         operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
             
            XMLParser.delegate = self;
            [XMLParser parse];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [(id)[self delegate] performSelectorOnMainThread:@selector(processHasErrors)
                                                  withObject:nil
                                               waitUntilDone:NO];
            
//            NSString *errorMessage = [[NSString alloc] initWithFormat:@"%@" ,error.localizedDescription];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                            message:errorMessage
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            [alert show];
//            DLog(@"failure with error %@",error.localizedDescription);
        }];
        [operation start];
        //});
        success = [parser parse];
    }
    @catch (NSException *exception) {
        DLog(@"error in fetchAndParseRss");
    }
    @finally {
        
    }
	//To suppress the leak in NSXMLParser
    return success;
}

#pragma mark - Parsing lifecycle


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    @try {
        element = elementName;
        if ([[element lowercaseString] isEqualToString:@"item"]) {
            currentItem = [[BlogRSS alloc] init];
            item    = [[NSMutableDictionary alloc] init];
            title   = [[NSMutableString alloc] init];
            link    = [[NSMutableString alloc] init];
            pubDate = [[NSMutableString alloc] init];
            description = [[NSMutableString alloc] init];
        }
    }
    @catch (NSException *exception) {
        DLog(@"error didStartElement");
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    @try {
        if ([[elementName lowercaseString] isEqualToString:@"item"]) {
            [item setObject:title   forKey:@"title"];
            [item setObject:link forKey:@"link"];
            [item setObject:pubDate forKey:@"pubDate"];
            [item setObject:description forKey:@"description"];
            // [feeds addObject:[item copy]];
            [[self rssItems] addObject:[item copy]];
        }
    }
    @catch (NSException *exception) {
        DLog(@"error didEndElement");
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    @try {
        if ([[element lowercaseString] isEqualToString:@"title"]) {
            [title appendString:string];
        }
        else if ([[element lowercaseString] isEqualToString:@"link"]) {
            [link appendString:string];
        }
        else if ([element  isEqualToString:@"pubDate"]) {
            [pubDate appendString:string];
        }
        else if ([element  isEqualToString:@"description"]) {
            [description appendString:string];
        }
    }
    @catch (NSException *exception) {
         DLog(@"error foundCharacters ");
    }
    @finally {
       
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    DLog(@"parseErrorOccurred");
    @try {
        if(parseError.code != NSXMLParserDelegateAbortedParseError) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [(id)[self delegate] performSelectorOnMainThread:@selector(processHasErrors)
                                                  withObject:nil
                                               waitUntilDone:NO];
        }
    }
    @catch (NSException *exception) {
        DLog(@"parseError Occurred on catch");
    }
    @finally {
        
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    @try {
        [(id)[self delegate] performSelectorOnMainThread:@selector(processCompleted)
                                              withObject:nil
                                           waitUntilDone:NO];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    @catch (NSException *exception) {
        DLog(@"error parserDidEndDocument");
    }
    @finally {
        
    }
}

@end
