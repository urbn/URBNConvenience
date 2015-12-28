//
//  UIImage+URBN.h
//  Pods
//
//  Created by Demetri Miller on 12/5/14.
//
//

#import <UIKit/UIKit.h>
#import "UIImage+ImageEffects.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^URBNConvenienceImageDrawBlock)(CGRect rect, CGContextRef context);

@interface UIImage (URBN)

- (UIImage *)urbn_tintedImageWithColor:(UIColor *)color;
+ (UIImage *)urbn_imageDrawnWithKey:(NSString *)key size:(CGSize)size drawBlock:(URBNConvenienceImageDrawBlock)drawBlock;
+ (UIImage *)urbn_screenShotOfView:(UIView *)view afterScreenUpdates:(BOOL)afterScreenUpdates;

@end

NS_ASSUME_NONNULL_END
