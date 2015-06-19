//
//  URBNProcessEditingTextStorage.m
//  Pods
//
//  Created by Nick DiStefano on 6/18/15.
//
//

#import "URBNExtraTextHighlightedTextStorage.h"

@interface URBNExtraTextHighlightedTextStorage ()

@property (nonatomic, strong) NSMutableAttributedString *backingStore;
@property (nonatomic, strong) UIColor *errorTextColor;
@property (nonatomic, assign) NSInteger maxLength;

@end

@implementation URBNExtraTextHighlightedTextStorage

- (instancetype)init {
    return [self initWithString:@""];
}

- (instancetype)initWithString:(NSString *)str {
    return [self initWithString:str attributes:nil];
}

- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary *)attrs {
    return [self initWithString:str attributes:attrs errorTextColor:[UIColor redColor] maxLength:10];
}

- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr {
    self = [self initWithString:@"" attributes:nil errorTextColor:[UIColor redColor] maxLength:10];
    self.backingStore = [attrStr mutableCopy];
    
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes errorTextColor:(UIColor *)errorTextColor maxLength:(NSInteger)maxLength {
    return [self initWithString:@"" attributes:attributes errorTextColor:errorTextColor maxLength:maxLength];
}

- (instancetype)initWithString:(NSString *)string attributes:(NSDictionary *)attributes errorTextColor:(UIColor *)errorTextColor maxLength:(NSInteger)maxLength {
    self = [super init];
    
    if (self) {
        _backingStore = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
        _errorTextColor = errorTextColor;
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
    [super processEditing];
}

@end
