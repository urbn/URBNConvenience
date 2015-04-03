
#import "UITextField+URBNLoadingIndicator.h"
#import "UIView+URBNLayout.h"

static CGFloat kURBNTextFieldLoadingIndicatorAnimationDuration = .25f;

@implementation UITextField (URBNLoadingIndicator)

- (void)urbn_showLoading:(BOOL)loading animated:(BOOL)isAnimated {
    [self urbn_showLoading:loading animated:isAnimated spinnerRightInset:0];
}

- (void)urbn_showLoading:(BOOL)loading animated:(BOOL)isAnimated spinnerRightInset:(CGFloat)rightInset {
    //If we're already showing the loading indicator don't try showing again
    if ( loading && [self.rightView isKindOfClass:[UIActivityIndicatorView class]] ) {
        return;
    }
    
    UIActivityIndicatorView * indy = (UIActivityIndicatorView *)self.rightView;
    
    // What we want to animate here.
    void (^DisplayBlock)() = ^{
        self.rightView.alpha = loading? 1.f : 0.f;
    };
    
    void (^CompletionBlock)() = ^{
        if(!loading) {
            self.rightView = nil;
        }
    };
    
    if(loading) {
        if(!indy || ![indy isKindOfClass:[UIActivityIndicatorView class]]) {
            indy = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            UIView *newView = [UIView new];
            [indy urbn_wrapInContainerViewWithView:newView insets:UIEdgeInsetsMake(0, -(indy.frame.size.width + rightInset), 0, 0)];
            self.rightView = newView;
        }
        
        self.rightViewMode = UITextFieldViewModeAlways;
        [indy startAnimating];
    }
    
    self.rightView.alpha = loading ? 0.f : 1.f; // Hide at first.
    
    if (isAnimated) {
        [UIView animateWithDuration:kURBNTextFieldLoadingIndicatorAnimationDuration animations:DisplayBlock completion:^(BOOL finished) {
            CompletionBlock();
        }];
    }
    else {
        DisplayBlock();
        CompletionBlock();
    }
}

@end
