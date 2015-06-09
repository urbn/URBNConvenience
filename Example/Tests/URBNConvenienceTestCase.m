//
//  URBNConvenienceTestCase.m
//  URBNConvenience
//
//  Created by Demetri Miller on 12/2/14.
//  Copyright (c) 2014 jgrandelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <URBNConvenience/NSDate+URBN.h>
#import <URBNConvenience/NSString+URBN.h>
#import <XCTest/XCTest.h>


@interface URBNConvenienceTestCase : XCTestCase

@end

@implementation URBNConvenienceTestCase

- (void)testHumanReadableStrings {
    NSString *string;
    NSDate *currentDate = [NSDate date];
    
    string = [currentDate urbn_humanReadableStringForTimeSinceCurrentDate];
    XCTAssertTrue([string isEqualToString:@"now"], @"'now' test failed");
    
    string = [[currentDate dateByAddingTimeInterval:-59] urbn_humanReadableStringForTimeSinceCurrentDate];
    XCTAssertTrue([string isEqualToString:@"now"], @"'now' test failed");
    
    string = [[currentDate dateByAddingTimeInterval:-70] urbn_humanReadableStringForTimeSinceCurrentDate];
    XCTAssertTrue([string isEqualToString:@"1m"], @"'minute' test failed");
    
    string = [[currentDate dateByAddingTimeInterval:-3599] urbn_humanReadableStringForTimeSinceCurrentDate];
    XCTAssertTrue([string isEqualToString:@"59m"], @"'minute' test failed");
    
    string = [[currentDate dateByAddingTimeInterval:-3700] urbn_humanReadableStringForTimeSinceCurrentDate];
    XCTAssertTrue([string isEqualToString:@"1h"], @"'hour' test failed");
    
    string = [[currentDate dateByAddingTimeInterval:-84399] urbn_humanReadableStringForTimeSinceCurrentDate];
    XCTAssertTrue([string isEqualToString:@"23h"], @"'hour' test failed");
    
    string = [[currentDate dateByAddingTimeInterval:-86500] urbn_humanReadableStringForTimeSinceCurrentDate];
    XCTAssertTrue([string isEqualToString:@"1d"], @"'day' test failed");
    
    string = [[currentDate dateByAddingTimeInterval:-604799] urbn_humanReadableStringForTimeSinceCurrentDate];
    XCTAssertTrue([string isEqualToString:@"6d"], @"'day' test failed");
    
    string = [[currentDate dateByAddingTimeInterval:-604900] urbn_humanReadableStringForTimeSinceCurrentDate];
    XCTAssertTrue([string isEqualToString:@"1w"], @"'week' test failed");
    
    string = [[currentDate dateByAddingTimeInterval:-1209800] urbn_humanReadableStringForTimeSinceCurrentDate];
    XCTAssertTrue([string isEqualToString:@"2w"], @"'week' test failed");
}

- (void)testContainsString {
    NSString *refString = @"This is a test string";
    
    XCTAssertTrue([refString urbn_containsString:@"This"], @"Case sensistive case failed for present string");
    
    XCTAssertFalse([refString urbn_containsString:@"Stuff"], @"Case sensitive case failed for absent string");
    
    XCTAssertTrue([refString urbn_containsCaseInsensitiveString:@"this"], @"Case insensistive case failed for present string");
    
    XCTAssertFalse([refString urbn_containsCaseInsensitiveString:@"more stuff"], @"Case insensistive case failed for absent string");
}

@end
