//
//  URBNProcessEditingTextStorage.h
//  Pods
//
//  Created by Nick DiStefano on 6/18/15.
//
//

#import <UIKit/UIKit.h>

@interface URBNExtraTextHighlightedTextStorage : NSTextStorage

- (instancetype)initWithAttributes:(NSDictionary *)attributes errorTextColor:(UIColor *)errorTextColor maxLength:(NSInteger)maxLength;

- (instancetype)initWithString:(NSString *)string attributes:(NSDictionary *)attributes errorTextColor:(UIColor *)errorTextColor maxLength:(NSInteger)maxLength NS_DESIGNATED_INITIALIZER;

@end
