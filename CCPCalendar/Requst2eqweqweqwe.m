//
//  Requst2eqweqweqwe.m
//  CCPCalendar
//
//  Created by hbh112 on 2017/11/14.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "Requst2eqweqweqwe.h"

@implementation Requst2eqweqweqwe
- (CIWRequestMethod)getRequestMethod{
    return CIWRequestMethodGet;
}

- (NSString *)getURI{
    return @"https://appid-ioss.xx-app.com/frontApi/getAboutUs?";//主页
    //    return @"/ybs/home/index";//主页
}

- (void)processResult{
    
    NSDictionary *result = [self.resultDic objectForKey:@"data"];
    
    if([result isKindOfClass:[NSDictionary class]]){
//        [self.resultDic setValue:homeData forKey:KEY_MODEL];
    }
}
@end
