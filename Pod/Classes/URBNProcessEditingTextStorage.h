//
//  URBNProcessEditingTextStorage.h
//  Pods
//
//  Created by Nick DiStefano on 6/18/15.
//
//

#import <UIKit/UIKit.h>

@interface URBNProcessEditingTextStorage : NSTextStorage

- (instancetype)initWithFont:(UIFont *)font withForegroundTextColor:(UIColor *)foregroundTextColor withErrorTextColor:(UIColor *)errorTextColor withMaxLength:(NSInteger)maxLength;

@end
