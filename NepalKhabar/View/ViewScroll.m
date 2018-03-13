//
//  ViewScroll.m
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 11/07/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//
#define FACTOR .9
#define padding 10
#import "ViewScroll.h"

@implementation ViewScroll

@synthesize btnName;

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
    int x;
    int y;
    float btnHeight;
    
    btnName = [NSArray arrayWithObjects:@"btn_dark_vs_light",@"btn_font",@"btn_font",@"btn_font",@"btn_font",@"btn_font",@"btn_share",nil];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    scroll.pagingEnabled = YES;
    scroll.scrollEnabled = YES;
    [scroll setBackgroundColor:[UIColor redColor]];
    
    UIView *mainView = [[UIView alloc] init];
    [self addSubview:scroll];
    for (NSInteger i = 0; i < [btnName count]; i++) {
        if (i % 2 == 0) {
            x = 20.0f;
            y = i * 75.0f;
        } else {
            x =  160.0f;
            y = (i - 1) * 75.0f;
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *myImage = [UIImage imageNamed:[self.btnName objectAtIndex:i]];
        [button setBackgroundImage:myImage forState:UIControlStateNormal];
        button.frame = CGRectMake(x, y, 133.0f, 146.0f);
        btnHeight = button.frame.size.height;
        button.tag = i;
        [button addTarget:self action:@selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
        self.alpha = 1;
        [mainView addSubview:button];
    }
    if ([btnName count]% 2 == 0) {
        [scroll setContentSize:CGSizeMake(320, (([btnName count] / 2) * btnHeight) + 30)];
    } else {
        [scroll setContentSize:CGSizeMake(320, ((([btnName count] / 2) + 1) * btnHeight) + 50)];
        
    }
    [scroll addSubview:mainView];
}

- (void)buttonPushed:(id)sender{
    // UIButton *button = (UIButton *)sender;
}

@end
