//
//  NSNotificationCenter+URBN.h
//  URBNKit
//
//  Created by Brian Michel on 1/28/14.
//  Copyright (c) 2014 URBN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (MainQueue)

- (void)urbn_postNotification:(NSNotification *)notification onMainQueue:(BOOL)onMainQueue;
- (void)urbn_postNotificationName:(NSString *)aName object:(id)anObject onMainQueue:(BOOL)onMainQueue;
- (void)urbn_postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo onMainQueue:(BOOL)onMainQueue;

@end
