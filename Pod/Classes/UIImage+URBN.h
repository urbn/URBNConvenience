//
//  UIImage+URBN.h
//  Pods
//
//  Created by Demetri Miller on 12/5/14.
//
//

#import <UIKit/UIKit.h>
#import "UIImage+ImageEffects.h"

typedef void(^URBNConvenienceImageDrawBlock)(CGRect rect,_Nonnull CGContextRef context);

@interface UIImage (URBN)

- (UIImage * _Nullable)urbn_tintedImageWithColor:(UIColor * _Nonnull)color;
+ (UIImage * _Nullable)urbn_imageDrawnWithKey:(NSString * _Nonnull)key size:(CGSize)size drawBlock:(_Nullable URBNConvenienceImageDrawBlock)drawBlock;
+ (UIImage * _Nullable)urbn_screenShotOfView:(UIView * _Nonnull)view afterScreenUpdates:(BOOL)afterScreenUpdates;

@end
