
#import <Foundation/Foundation.h>

//Categories
#import "NSDate+URBN.h"
#import "NSNotificationCenter+URBN.h"
#import "UIView+URBNLayout.h"
#import "UIView+URBNAnimations.h"
#import "UITextField+URBNLoadingIndicator.h"

//Subclasses
#import "URBNTextField.h"

//Functions & Macros
#import "URBNFunctions.h"
#import "URBNMacros.h"

typedef void(^URBNConvenienceImageDrawBlock)(CGRect rect, CGContextRef context);

/**
 Umbrella framework header file, any files addded to the framework
 should be added here to be included when people #import "URBNConvenience.h"
 */

@interface URBNConvenience : NSObject

+ (UIImage *)imageDrawnWithKey:(NSString *)key size:(CGSize)size drawBlock:(URBNConvenienceImageDrawBlock)drawBlock;
- (NSString *)version;

@end
