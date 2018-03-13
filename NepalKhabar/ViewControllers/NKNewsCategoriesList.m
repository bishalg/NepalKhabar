//
//  NKNewsCategoriesList.m
//  NepalKhabar
//
//  Created by Bishal Ghimire on 4/18/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import "NKNewsCategoriesList.h"
#import "NKNewsListingTVC.h"
#import <UIKit/UIKit.h>
#import "NKAppDelegate.h"
#import "NKCategoryIcon.h"


@interface NKNewsCategoriesList ()
    @property NSArray *categories;
@end

@implementation NKNewsCategoriesList

@synthesize myDelegate;
@synthesize categoryName;
@synthesize categoryLink;
@synthesize lblCategoryName;

int selectedRow;

#pragma mark -
#pragma TablView

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NKAppDelegate *appDelegate= AppDelegate;

    NKCategoryIcon *categoryIcon =[NKCategoryIcon alloc];
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if ( cell  == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    UILabel *newNewsTitle = (UILabel *)[cell viewWithTag:1000];
    newNewsTitle.text = appDelegate.categoryName[indexPath.row];
    [categoryIcon iconForCategory:[appDelegate.categoryName objectAtIndex:[indexPath row]]];
    
    UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:2000];
    NSMutableString *imageName;
    imageName  = [NSMutableString stringWithFormat:@"%@", [categoryIcon iconForCategory:appDelegate.categoryName[indexPath.row]]];
    
    if (indexPath.row == selectedRow) {
        [imageName appendString:@"_active"];
        UIImage *iconImage = [UIImage imageNamed:imageName];
        imageView.image=iconImage;
    } else {
        [imageName appendString:@"_deactive"];
        UIImage *iconImage = [UIImage imageNamed:imageName];
        imageView.image=iconImage;
    }
    return cell;
}

#pragma mark - Navigate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NKAppDelegate *appDelegate= AppDelegate;
    selectedRow = indexPath.row;
    [self.tableView reloadData];
 
    appDelegate.rssURL=[appDelegate.categoryLink objectAtIndex:[indexPath row]];
    appDelegate.selectCategoryItem=[appDelegate.categoryName objectAtIndex:[indexPath row]];
    // NSLog(@"%@",appDelegate.selectCategoryItem);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"menuItemSelected"
                                                        object:self
                                                      userInfo:nil];
    
    [self.viewDeckController closeRightViewBouncing:^(IIViewDeckController *controller) {}];
}

#pragma mark
#pragma mark View
- (void)viewDidLoad{
    [super viewDidLoad];
    
    //  selected Row set -1 to make no row selected at 1st load 
    selectedRow = -1;
    UIImage *patternImage = [UIImage imageNamed:@"bg_pattern"];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:patternImage]];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    NKAppDelegate *appDelegate= AppDelegate;
    self.categories = appDelegate.categoryName;
    if ([appDelegate.rssLanguage isEqualToString:@"nepali"]) {
        lblCategoryName.text=@"वर्ग";
    }else{
        lblCategoryName.text=@"Categories";
    }
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setLblCategoryName:nil];
    [super viewDidUnload];
}
 
@end
