//
//  UIView+URBNLayout.h
//

#import <UIKit/UIKit.h>

@interface UIView (URBNLayout)

// Position of the top-left corner in superview's coordinates
@property CGPoint position;
@property CGFloat x;
@property CGFloat y;

// Setting size keeps the position (top-left corner) constant
@property CGSize size;
@property CGFloat width;
@property CGFloat height;

// Autolayout helpers
- (void)urbn_clearAllConstraints;
- (void)urbn_clearAllConstraintsForSubView:(UIView *)view;
- (void)urbn_constrainViewEqual:(UIView *)view;

- (NSLayoutConstraint *)urbn_widthLayoutConstraint;
- (NSLayoutConstraint *)urbn_heightLayoutConstraint;
- (NSLayoutConstraint *)urbn_addHeightLayoutConstraintWithConstant:(CGFloat)constant;
- (NSLayoutConstraint *)urbn_addHeightLayoutConstraintWithConstant:(CGFloat)constant withPriority:(UILayoutPriority)priority;

+ (UIView *)urbn_viewContsrainedToSize:(CGSize)size;
- (void)urbn_layoutAndInvalidateIntrinsicSize;

/**
 *  The purpose of this is to replace the
 *
 *  ```objc
 *      UIView *container = [[UIView alloc] init];
 *      container.translatesAutoresizingMaskIntoConstraints = NO;
 *      [container addSubview: view]; 
 *
 *      NSDictionary *views = NSDictionaryOfVariableBindings(view);
 *      NSArray *h = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" 
 *                                             options:0 metrics:nil views:views];
 *      NSArray *v = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" 
 *                                             options:0 metrics:nil views:views];
 *      [container addConstraints:[h arrayByAddingObjectsFromArray:v]];
 *  ```
 *
 *  @param  container - This is an optional container that you've created.  Passing nil will 
 *                      tell this method to create the container for you.
 *  @return The containing view
 */
- (UIView *)urbn_wrapInContainerViewWithView:(UIView *)container;
- (UIView *)urbn_wrapInContainerViewWithView:(UIView *)container insets:(UIEdgeInsets)insets;

CGAffineTransform CGAffineScaleTransformForRectConversion(CGRect fromRect, CGRect toRect);
CGAffineTransform CGAffineTransformForRectConversion(CGRect fromRect, CGRect toRect);
CATransform3D CATranform3DForRectConversion(CGRect fromRect, CGRect toRect);
CGSize CGSizeAspectFit(CGSize aspectRatio, CGSize boundingSize);
float pin(float min, float value, float max);

@end

