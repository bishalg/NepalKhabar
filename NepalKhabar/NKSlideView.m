//
//  NKSlideView.m
//  Nepalkhabar
//
//  Created by Rowin on 8/07/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#define PADDING 5

#import "NKSlideView.h"

@implementation NKSlideView
@synthesize mySlider;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

-(void) baseInit {
    self.backgroundColor        = [UIColor clearColor];
    UIView *upperView           = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 32)];
    upperView.backgroundColor   = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0];
    mySlider                    = [[UISlider alloc]initWithFrame:CGRectMake(25, 0, 250, 30)];
    mySlider.minimumValue       = 12;
	mySlider.maximumValue       = 20;
	mySlider.value              = 16;
	[mySlider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
    UIImage *thumbImage         = [UIImage imageNamed:@"font_adjust_handle.png"];
    
    [[UISlider appearance] setThumbImage:thumbImage
                                forState:UIControlStateNormal];
    
    UILabel *smallLabel         = [[UILabel alloc] initWithFrame:CGRectMake((mySlider.frame.origin.x)-15, 5, 20, 20)];
    smallLabel.textColor        = [UIColor whiteColor];
    [smallLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
    smallLabel.text             = @"A";
    smallLabel.backgroundColor  = [UIColor clearColor];
    [upperView addSubview:smallLabel];
    
    
    UILabel *largeLabel=[[UILabel alloc] initWithFrame:CGRectMake((mySlider.frame.origin.x)+(mySlider.frame.size.width)+5, 5, 20, 20)];
    largeLabel.textColor        = [UIColor whiteColor];
    [largeLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
    largeLabel.text             = @"A";
    largeLabel.backgroundColor  = [UIColor clearColor];
    [upperView addSubview:largeLabel];
    [upperView addSubview:mySlider];
    [self addSubview:upperView];
    
    UIImageView *imageView      = [[UIImageView alloc] initWithFrame: CGRectMake( (upperView.frame.size.width)/2, upperView.frame.size.height, 17,12 )];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setImage:[UIImage imageNamed:@"font_adjust_triangle.png"]];
    [self addSubview:imageView];
    
}
- (void)updateValue:(id)slider {
    NSInteger v = mySlider.value;
    [self.delegate slideView:self didSelectOption:v];
}
 
@end
