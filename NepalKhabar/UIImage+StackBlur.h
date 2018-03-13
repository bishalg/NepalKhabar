//
//  UIImage+StackBlur.h
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 4/29/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (StackBlur)

- (UIImage *)imageWithGaussianBlur9;
- (UIImage*) stackBlur:(NSUInteger)radius;
- (UIImage *) normalize ;
+ (void) applyStackBlurToBuffer:(UInt8*)targetBuffer width:(const int)w height:(const int)h withRadius:(NSUInteger)inradius;


@end
