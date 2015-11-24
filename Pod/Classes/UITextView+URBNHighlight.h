//
//  UITextView+URBNHighlight.h
//  Pods
//
//  Created by Nick DiStefano on 11/23/15.
//
//

@interface UITextView (URBNHighlight)

+ (instancetype)urbn_highlightTextViewWithErrorColor:(UIColor *)errorColor maxLength:(NSInteger)maxLength;

@end
