//
//  NKAppDelegate.h
//  NepalKhabar
//
//  Created by Bishal Ghimire on 4/16/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//


#import <UIKit/UIKit.h>
#define AppDelegate (NKAppDelegate *)[[UIApplication sharedApplication] delegate]
@interface NKAppDelegate : UIResponder <UIApplicationDelegate>


// HomeData
@property (copy, nonatomic) NSString *rssURL;
@property (copy, nonatomic) NSString *rssLanguage;

@property (copy, nonatomic) NSString *xPath;
@property (copy, nonatomic) NSString *xPathName;

@property (nonatomic, assign) NSArray *categoryName;
@property (nonatomic, assign) NSArray *categoryLink;
@property (retain, nonatomic) NSString *categoryID;
@property (retain, nonatomic) NSString *newsPaperName;
@property(retain,nonatomic) NSString *selectCategoryItem;

@property (nonatomic, assign) NSString *newsTitle;

//
@property (strong, nonatomic) UIWindow *window;

//@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//
//- (void)saveContext;
//- (NSURL *)applicationDocumentsDirectory;

@end
