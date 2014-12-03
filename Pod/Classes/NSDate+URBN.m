//
//  NSDate+URBN.m
//  Pods
//
//  Created by Demetri Miller on 12/3/14.
//
//

#import "NSDate+URBN.h"

// In seconds
static const NSTimeInterval URBNConvenienceMinuteThreshold = 60;      // < 1 min
static const NSTimeInterval URBNConvenienceHourThreshold   = 3600;    // < 60 min
static const NSTimeInterval URBNConvenienceDayThreshold    = 86400;   // < 24 hours
static const NSTimeInterval URBNConvenienceWeekThreshold   = 604800;  // < 1 week


@implementation NSDate (URBN)

- (NSString *)humanReadableStringForTimeSinceCurrentDate {
    static NSDateComponentsFormatter *_componentsFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _componentsFormatter = [[NSDateComponentsFormatter alloc] init];
        _componentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
        _componentsFormatter.maximumUnitCount = 1;
    });
    
    NSString *string;
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeSince = [self timeIntervalSinceDate:currentDate];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    if (timeSince < URBNConvenienceMinuteThreshold) {
        string = NSLocalizedString(@"urbnconvenience.now", nil);
    }
    else if (timeSince < URBNConvenienceHourThreshold) {
        components.minute = (timeSince / URBNConvenienceMinuteThreshold);
    }
    else if (timeSince < URBNConvenienceDayThreshold) {
        components.hour = (timeSince / URBNConvenienceHourThreshold);
    }
    else if (timeSince < URBNConvenienceWeekThreshold) {
        components.day = (timeSince / URBNConvenienceDayThreshold);
    }
    else {
        // NSDateComponentsFormatter doesn't support "number of weeks since a date" formatting
        // so we do it ourselves.
        NSInteger numWeeks = ((timeSince / URBNConvenienceDayThreshold) / 7);
        string = [NSString stringWithFormat:@"%ld%@", (long)numWeeks, NSLocalizedString(@"urbnconvenience.week", nil)];
    }
    
    // Default to the componentsFormatter if we don't have a string yet (beyond threshold or no localized key).
    if (!string) {
        string = [_componentsFormatter stringFromDateComponents:components];
    }
    
    return string;
}

@end
