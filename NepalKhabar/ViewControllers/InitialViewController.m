/*
 * ----------------------------------------------------------------------------
 * "THE BOOZE-WARE LICENSE"
 * Simon Rice wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me an alcoholic beverage in return.
 *
 * Simon Rice
 * ----------------------------------------------------------------------------
 */

#import "InitialViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard_iPhone" bundle:nil];
    
    self.viewDeckController.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToCloseBouncing;
    
    self = [super initWithCenterViewController:[storyboard instantiateViewControllerWithIdentifier:@"NKNewsListingTVC"]
                            rightViewController:[storyboard instantiateViewControllerWithIdentifier:@"NKNewsCategoriesList"]];
    if (self) {
        // Add any extra init code here
    }
    return self;
}


@end
