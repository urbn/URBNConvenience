//
//  UIColor+UIColor_URBN.h
//  Pods
//
//  Created by Evan Dutcher on 12/28/15.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (URBN)

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithRGBAHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
