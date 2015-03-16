//
//  URBNBorderViewController.m
//  URBNConvenience
//
//  Created by Joseph Ridenour on 3/13/15.
//  Copyright (c) 2015 jgrandelli. All rights reserved.
//

#import "URBNBorderViewController.h"
#import <URBNConvenience/UIView+URBNBorders.h>

@implementation URBNBorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %@", indexPath];
    
    [cell urbn_resetBorders];
    
    NSInteger row = indexPath.row % 4;
    if (row == 0) {
        cell.urbn_topBorder.insets = UIEdgeInsetsMake(5.f, 5.f, 5.f, 5.f);
        cell.urbn_topBorder.width = 1.f;
        cell.urbn_topBorder.color = [UIColor greenColor];
    }
    else if (row == 1) {
        cell.urbn_rightBorder.insets = UIEdgeInsetsMake(5, 5, 5, 5);
        cell.urbn_rightBorder.width = 1.f;
    }
    else if (row == 2) {
        cell.urbn_leftBorder.insets = UIEdgeInsetsMake(5, 5, 5, 5);
        cell.urbn_leftBorder.width = 1.f;
    }
    else {
        cell.urbn_bottomBorder.insets = UIEdgeInsetsMake(5, 5, 5, 5);
        cell.urbn_bottomBorder.width = 1.f;
    }
    
    return cell;
}

@end
