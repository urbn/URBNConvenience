//
//  URBNProcessEditingTextStorage.m
//  Pods
//
//  Created by Nick DiStefano on 6/18/15.
//
//

#import "URBNProcessEditingTextStorage.h"

static NSInteger const maxLengthBeforeWarning = 83;
static NSInteger const maxLength = 133;

@interface URBNProcessEditingTextStorage ()

@property (nonatomic, strong) NSMutableAttributedString *backingStore;

@end

@implementation URBNProcessEditingTextStorage

- (instancetype)init {
    if (self = [super init]) {
        _backingStore = [NSMutableAttributedString new];
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

@end
