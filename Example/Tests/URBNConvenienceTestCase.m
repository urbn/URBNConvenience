//
//  URBNConvenienceTestCase.m
//  URBNConvenience
//
//  Created by Demetri Miller on 12/2/14.
//  Copyright (c) 2014 jgrandelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <URBNConvenience/URBNConvenience.h>
#import <XCTest/XCTest.h>


@interface URBNConvenienceTestCase : XCTestCase

@end

@implementation URBNConvenienceTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHumanReadableStrings {
    NSString *string;
    NSDate *currentDate = [NSDate date];
    
    string = [URBNConvenience humanReadableStringForTimeSinceDate:currentDate];
    XCTAssertTrue([string isEqualToString:@"now"], @"'now' test failed");
    
    string = [URBNConvenience humanReadableStringForTimeSinceDate:[currentDate dateByAddingTimeInterval:59]];
    XCTAssertTrue([string isEqualToString:@"now"], @"'now' test failed");
    
    string = [URBNConvenience humanReadableStringForTimeSinceDate:[currentDate dateByAddingTimeInterval:70]];
    XCTAssertTrue([string isEqualToString:@"1m"], @"'minute' test failed");
    
    string = [URBNConvenience humanReadableStringForTimeSinceDate:[currentDate dateByAddingTimeInterval:3599]];
    XCTAssertTrue([string isEqualToString:@"59m"], @"'minute' test failed");
    
    string = [URBNConvenience humanReadableStringForTimeSinceDate:[currentDate dateByAddingTimeInterval:3700]];
    XCTAssertTrue([string isEqualToString:@"1h"], @"'hour' test failed");
    
    string = [URBNConvenience humanReadableStringForTimeSinceDate:[currentDate dateByAddingTimeInterval:84399]];
    XCTAssertTrue([string isEqualToString:@"23h"], @"'hour' test failed");
    
    string = [URBNConvenience humanReadableStringForTimeSinceDate:[currentDate dateByAddingTimeInterval:86500]];
    XCTAssertTrue([string isEqualToString:@"1d"], @"'day' test failed");
    
    string = [URBNConvenience humanReadableStringForTimeSinceDate:[currentDate dateByAddingTimeInterval:604799]];
    XCTAssertTrue([string isEqualToString:@"6d"], @"'day' test failed");
    
    string = [URBNConvenience humanReadableStringForTimeSinceDate:[currentDate dateByAddingTimeInterval:604900]];
    XCTAssertTrue([string isEqualToString:@"1w"], @"'week' test failed");
    
    string = [URBNConvenience humanReadableStringForTimeSinceDate:[currentDate dateByAddingTimeInterval:1209800]];
    XCTAssertTrue([string isEqualToString:@"2w"], @"'week' test failed");
}

@end
