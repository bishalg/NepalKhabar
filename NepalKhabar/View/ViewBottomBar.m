//
//  LBview.m
//  Listbingo
//
//  Created by Bishal Ghimire on 8/07/13.
//  Copyright (c) 2013 Bishal Ghimire. All rights reserved.
//

#define padding 10

#import "ViewBottomBar.h"

@implementation ViewBottomBar

@synthesize btnName;
@synthesize delegate;

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

- (void)baseInit {
    int x = 32;
    
    btnName = [NSArray arrayWithObjects:@"btn_dark_vs_light",@"btn_font",@"btn_share", nil];
    delegate = nil;
    
    for (NSInteger i = 0; i < [btnName count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *myImage = [UIImage imageNamed:[self.btnName objectAtIndex:i]];
        [button setBackgroundImage:myImage forState:UIControlStateNormal];
        button.frame = CGRectMake(x, 0, 44, 44);
        if (i == 0) {
            x = 0 + padding;
        } else if (i == 1){
            x = 160 - button.frame.size.width / 2;
        } else if(i == 2) {
            x = 320 - (padding + button.frame.size.width);
        }
        button.frame = CGRectMake(x, 0, 44, 44);
        button.tag = i;
        [button addTarget:self action:@selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
        self.alpha = 1;
        [self addSubview:button];
    }
}

- (void)buttonPushed:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self.delegate viewBottomBar:self didSelectOption:button.tag];
}

@end
