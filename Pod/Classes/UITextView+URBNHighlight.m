//
//  UITextView+URBNHighlight.m
//  Pods
//
//  Created by Nick DiStefano on 11/23/15.
//
//

#import "UITextView+URBNHighlight.h"
#import "URBNHighlightTextStorage.h"

@implementation UITextView (URBNHighlight)

+ (instancetype)urbn_highlightTextViewWithErrorColor:(UIColor *)errorColor maxLength:(NSInteger)maxLength {
    NSTextStorage *textStorage = [[URBNHighlightTextStorage alloc] initWithErrorTextColor:errorColor maxLength:maxLength];
    NSLayoutManager *textLayout = [NSLayoutManager new];
    [textStorage addLayoutManager:textLayout];
    NSTextContainer *textContainer = [NSTextContainer new];
    [textLayout addTextContainer:textContainer];
    UITextView *textEntryView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:textContainer];
    
    return textEntryView;
}

@end
