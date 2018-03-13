//
//  NKNewsCategoriesList.h
//  NepalKhabar
//
//  Created by Bishal Ghimire on 4/18/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoriesDelegate <NSObject>
@required
-(void) categoriesListDismissed:(NSString *)categorieName withLink:(NSString *)categorieLink;
@end

@interface NKNewsCategoriesList : UIViewController
<UITableViewDelegate, UITableViewDataSource> {
   //  id myDelegate;
}

@property (nonatomic, assign) NSArray *categoryName;
@property (nonatomic, assign) NSArray *categoryLink;
@property (nonatomic, assign) NSString *categoryID;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoryName;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, assign) id<CategoriesDelegate> myDelegate;

@end
