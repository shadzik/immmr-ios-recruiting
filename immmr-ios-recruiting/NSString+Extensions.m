//
//  NSString+Extensions.m
//  immmr-ios-recruiting
//
//  Created by Bartosz Świątek on 20/02/2017.
//  Copyright © 2017 Immmr GmbH. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

- (NSString *)getInitials {
    NSArray *array =
    [self componentsSeparatedByCharactersInSet:[NSCharacterSet
                                                whitespaceCharacterSet]];
    array = [array
             filteredArrayUsingPredicate:[NSPredicate
                                          predicateWithFormat:@"SELF != ''"]];
    if (array.count == 0) {
        return @"";
    }
    NSString *firstNameInitial = [[array objectAtIndex:0] substringToIndex:1];
    NSString *lastNameInitial = @"";
    
    if ([array count] > 1) {
        lastNameInitial = [[array objectAtIndex:1] substringToIndex:1];
    }
    
    return [NSString stringWithFormat:@"%@%@", firstNameInitial, lastNameInitial];
}

@end
