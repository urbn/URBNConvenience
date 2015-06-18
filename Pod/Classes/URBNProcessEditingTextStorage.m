//
//  URBNProcessEditingTextStorage.m
//  Pods
//
//  Created by Nick DiStefano on 6/18/15.
//
//

#import "URBNProcessEditingTextStorage.h"

@interface URBNProcessEditingTextStorage ()

@property (nonatomic, strong) NSMutableAttributedString *backingStore;
@property (nonatomic, strong) UIColor *foregroundTextColor;
@property (nonatomic, strong) UIColor *errorTextColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSInteger maxLength;

@end

@implementation URBNProcessEditingTextStorage

- (instancetype)initWithFont:(UIFont *)font withForegroundTextColor:(UIColor *)foregroundTextColor withErrorTextColor:(UIColor *)errorTextColor withMaxLength:(NSInteger)maxLength {
    self = [super init];
    
    if (self) {
        _backingStore = [NSMutableAttributedString new];
        _foregroundTextColor = foregroundTextColor;
        _errorTextColor = errorTextColor;
        _font = font;
        _maxLength = maxLength;
    }
    
    return self;
}

- (NSString *)string {
    return [self.backingStore string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    return [self.backingStore attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [self beginEditing];
    [self.backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters | NSTextStorageEditedAttributes range:range changeInLength:str.length - range.length];
    [self endEditing];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range {
    [self beginEditing];
    [self.backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

- (void)processEditing {
    NSInteger stringLength = self.string.length;
    [self removeAttribute:NSBackgroundColorAttributeName range:NSMakeRange(0, stringLength)];

    if (stringLength > self.maxLength) {
        [self addAttribute:NSBackgroundColorAttributeName value:self.errorTextColor range:NSMakeRange(self.maxLength, stringLength - self.maxLength)];
    }
    
    [self addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, stringLength)];
    [self addAttribute:NSForegroundColorAttributeName value:self.foregroundTextColor range:NSMakeRange(0, stringLength)];
    [super processEditing];
}

@end
