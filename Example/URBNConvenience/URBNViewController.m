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
}


@end
