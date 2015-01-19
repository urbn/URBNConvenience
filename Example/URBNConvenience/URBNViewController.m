//
//  URBNViewController.m
//  URBNConvenience
//
//  Created by jgrandelli on 11/11/2014.
//  Copyright (c) 2014 jgrandelli. All rights reserved.
//

#import <URBNConvenience/URBNConvenience.h>
#import "URBNViewController.h"

@interface URBNViewController ()
@property(nonatomic, strong) UIImageView *imageView1;
@property(nonatomic, strong) UIImageView *imageView2;
@end

@implementation URBNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize size = CGSizeMake(100, 100);
    self.imageView1 = [[UIImageView alloc] init];
    self.imageView1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.imageView1];
    
    [self.imageView1 urbn_addConstraintForAttribute:NSLayoutAttributeTop withItem:self.view withConstant:100.f withPriority:UILayoutPriorityDefaultHigh];
    [self.imageView1 urbn_addWidthLayoutConstraingWithConstant:100.f];
    [self.imageView1 urbn_addHeightLayoutConstraintWithConstant:100.f];
    self.imageView1.backgroundColor = [UIColor clearColor];

    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(150, 100, 100, 100)];
    self.imageView2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.imageView2];
    
    UIImage *image = [UIImage urbn_imageDrawnWithKey:@"imageKey" size:size drawBlock:^(CGRect rect, CGContextRef context) {
        CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
        CGContextFillRect(context, rect);
    }];
    
    self.imageView1.image = image;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImage *delayImage = [UIImage urbn_imageDrawnWithKey:@"imageKey" size:size drawBlock:nil];
        self.imageView2.image = delayImage;
        
        // This shows access to the top constraint we added above.
        [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:0 animations:^{
            [self.imageView1 urbn_constraintForAttribute:NSLayoutAttributeTop].constant += 100.f;
            [self.imageView1 urbn_constraintForAttribute:NSLayoutAttributeWidth].constant += 50.f;
            [self.imageView1 urbn_constraintForAttribute:NSLayoutAttributeHeight].constant += 50.f;
            [self.view layoutIfNeeded];
        } completion:nil];
    });

    //This code proves Github Issue #9 has been fixed. (https://github.com/urbn/URBNConvenience/issues/9)
    UILabel* errorLabel = [[UILabel alloc] init];
    errorLabel.text = @"There should be a red box here.";
    errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:errorLabel];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[errorLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(errorLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[errorLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(errorLabel)]];

    UILabel* label = [[UILabel alloc] init];
    label.text = @"This label should appear in front of a red box.";
    label.numberOfLines = 2;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [label urbn_addHeightLayoutConstraintWithConstant:70.0f];
    [label urbn_addWidthLayoutConstraingWithConstant:320.0f];

    UIView* redBox = [[UIView alloc] init];
    redBox.clipsToBounds = NO;
    redBox.translatesAutoresizingMaskIntoConstraints = NO;
    redBox.backgroundColor = [UIColor redColor];

    [redBox urbn_addHeightLayoutConstraintWithConstant:label.urbn_heightLayoutConstraint.constant]; //These are the key lines of code in this example. If Issue #9 exists, the constants will be 0
    [redBox urbn_addWidthLayoutConstraingWithConstant:label.urbn_widthLayoutConstraint.constant];

    [redBox addSubview:label];
    [redBox addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    [redBox addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];

    [self.view addSubview:redBox];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[redBox]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(redBox)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[redBox]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(redBox)]];
    /// End of Issue #9 code
}


@end
