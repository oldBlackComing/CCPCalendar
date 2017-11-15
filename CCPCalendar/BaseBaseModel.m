//
//  BaseBaseModel.m
//  __PRODUCTNAME__
//
//  Created by hbh112 on 17/11/15
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "BaseBaseModel.h"

@implementation BaseBaseModel

- (NSDictionary *)attributeMapDictionary{
    return @{
	@"status":@"status",
	@"wapurl":@"wapurl",
	@"appid":@"appid",
	@"appname":@"appname",
	@"desc":@"desc",
	@"isshowwap":@"isshowwap",
	};
}

@end
