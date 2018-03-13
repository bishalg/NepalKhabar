//
//  LBview.h
//  Listbingo
//
//  Created by Rowin on 8/07/13.
//  Copyright (c) 2013 Bishal Ghimire. All rights reserved.
//

#import <UIKit/UIKit.h>
 

@class ViewBottomBar;

@protocol BottomViewDelegate
-(void)tabView:(ViewBottomBar *)tabBtmView didSelectOption:(NSInteger)btnTag;
@end

@interface ViewBottomBar : UIView
@property(strong, nonatomic) NSArray *btnName;

@property (assign) id <BottomViewDelegate> delegate;
@end
