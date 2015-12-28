//
//  UIColor+UIColor_URBN.h
//  Pods
//
//  Created by Evan Dutcher on 12/28/15.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (URBN)

+ (UIColor *)urbn_colorWithRGBHex:(UInt32)hex;
+ (UIColor *)urbn_colorWithRGBAHex:(UInt32)hex;
+ (UIColor *)urbn_colorWithHexString:(NSString *)stringToConvert;

@end
