//
//  UIColor+UIColor_URBN.m
//  Pods
//
//  Created by Evan Dutcher on 12/28/15.
//
//

#import "UIColor+URBN.h"

@implementation UIColor (URBN)

// Note : Sourced from https://github.com/fcanas/uicolor-utilities

+ (UIColor *)urbn_colorWithHexString:(NSString *)stringToConvert {
    if ([stringToConvert hasPrefix:@"#"]) {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    
    return [UIColor urbn_colorWithRGBHex:hexNum];
}

+ (UIColor *)urbn_colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];
}

+ (UIColor *)urbn_colorWithRGBAHex:(UInt32)hex {
    int r = (hex >> 24) & 0xFF;
    int g = (hex >> 16) & 0xFF;
    int b = (hex >> 8) & 0xFF;
    int a = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a / 255.0];
}

@end
