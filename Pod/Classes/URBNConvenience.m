
#import "URBNConvenience.h"

@implementation URBNConvenience

+ (UIImage *)imageDrawnWithKey:(NSString *)key size:(CGSize)size drawBlock:(URBNConvenienceImageDrawBlock)drawBlock {
    NSAssert((key != nil), @"Key must be non-nil");
    NSAssert((size.width > 0) && (size.height > 0), @"Invalid image size (both dimensions must be greater than zero");
    static NSCache *_imageCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imageCache = [[NSCache alloc] init];
    });
    
    UIImage *image = [_imageCache objectForKey:key];
    if (!image && drawBlock) {
        UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale); {
            CGContextRef context = UIGraphicsGetCurrentContext();
            drawBlock(CGRectMake(0, 0, size.width, size.height), context);
            image = UIGraphicsGetImageFromCurrentImageContext();
            [_imageCache setObject:image forKey:key];
        } UIGraphicsEndImageContext();
    }

    return image;
}

- (NSString *)version {
    return @"0.1";
}

@end
