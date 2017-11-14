//
//  CIWRequestError.m
//  HunBaSha
//
//  Created by GarrettGao on 2017/7/24.
//  Copyright © 2017年 hunbohui. All rights reserved.
//

#import "CIWRequestError.h"

@implementation CIWRequestError

+ (BOOL)requestIsErrorWith:(NSString *)error withCongigurationErrors:(NSArray *)errors{
    
    if([error isKindOfClass:[NSString class]] && [errors isKindOfClass:[NSArray class]]){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@",error];
        NSArray *screenOuts = [errors filteredArrayUsingPredicate:predicate];
        if(screenOuts.count){
            [[NSNotificationCenter defaultCenter] postNotificationName:kRequestErrorInterceptNotification object:screenOuts.lastObject];
            return YES;
        }
    }
    return NO;
}


@end
