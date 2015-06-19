//
//  URBNProcessEditingTextStorage.h
//  Pods
//
//  Created by Nick DiStefano on 6/18/15.
//
//

#import <UIKit/UIKit.h>

@interface URBNExtraTextHighlightedTextStorage : NSTextStorage

- (instancetype)initWithErrorTextColor:(UIColor *)errorTextColor maxLength:(NSInteger)maxLength;

@end
