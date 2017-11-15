//
//  Requst2eqweqweqwe.m
//  CCPCalendar
//
//  Created by hbh112 on 2017/11/14.
//  Copyright © 2017年 ccp. All rights reserved.
//

#import "Requst2eqweqweqwe.h"
#import "BaseBaseModel.h"

@implementation Requst2eqweqweqwe
- (CIWRequestMethod)getRequestMethod{
    return CIWRequestMethodGet;
}

- (NSString *)getURI{
    return @"https://appid-ioss.xx-app.com/frontApi/getAboutUs";//主页
    //    return @"/ybs/home/index";//主页
}

- (void)processResult{
    
    if([self.resultDic isKindOfClass:[NSDictionary class]]){
        BaseBaseModel *baseBaseModel = [[BaseBaseModel alloc] initWithDataDic:self.resultDic];

        [self.resultDic setValue:baseBaseModel forKey:@"kkkkkk"];
    }
}
@end
