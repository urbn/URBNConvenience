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

- (UIImage * _Nullable)urbn_tintedImageWithColor:(UIColor *)color __attribute((deprecated("Use methods in UIImageConvenience.swift")));
+ (UIImage * _Nullable)urbn_imageDrawnWithKey:(NSString *)key size:(CGSize)size drawBlock:(_Nullable URBNConvenienceImageDrawBlock)drawBlock __attribute((deprecated("Use methods in UIImageConvenience.swift")));
+ (UIImage * _Nullable)urbn_screenShotOfView:(UIView *)view afterScreenUpdates:(BOOL)afterScreenUpdates __attribute((deprecated("Use methods in UIImageConvenience.swift")));

@end

NS_ASSUME_NONNULL_END
