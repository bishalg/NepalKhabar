//
//  NKSlideView.h
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 8/07/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NKSlideView;

@protocol SlideViewDelegate
- (void)slideView:(NKSlideView *)slideView didSelectOption:(NSInteger)slideValue;
@end

@interface NKSlideView : UIView

@property (nonatomic, strong) UISlider *mySlider;
@property (assign) id <SlideViewDelegate> delegate;

@end
