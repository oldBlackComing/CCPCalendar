//
//  User.m
//  weddingBusiness
//
//  Created by GarrettGao on 15/1/9.
//  Copyright (c) 2015年 HunBoHui. All rights reserved.
//

#import "User.h"

@implementation User

- (NSDictionary *)attributeMapDictionary{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"all_score",   @"allScore",
            @"bwc_score",   @"bwcScore",
            @"bw_yc_score", @"bwcYcScore",
            @"yc_score",    @"ptYcScore",
            @"avatar",      @"headImages",
            @"uid",         @"userId",
            @"uname",       @"name",
            @"bind_status", @"bindStatus",
            @"phone",       @"phone",
            @"source",      @"source",
            @"u_level",     @"uLevel",
            @"qrcode_img",  @"qrcodeImg",
            @"u_level_url", @"uLevelUrl",
            @"live_city",   @"liveCity",    
            @"gender",      @"gender",
            @"qq",          @"qq",
            
//            @"baby_operation_status",          @"babyOperationStatus",
//            @"baby_show_status",               @"babyShowStatus",
//            @"baby_id",                        @"babyId",
//            @"stage_type",                     @"stageType",
            
            nil];
}


- (NSString *)headSmall{
    return [_headImages objectForKey:@"small"];
}

- (NSString *)headBig{
    return [_headImages objectForKey:@"medium"];
}

- (NSString *)headOrigin{
    return [_headImages objectForKey:@"origin"];
}

//- (NSString *)myBgImageSmall{
//    if (_myBgImages.count > 0) {
//        return [_myBgImages[0] objectForKey:@"small"];
//    }
//    return @"";
//}
//
//- (NSString *)myBgImageBig{
//    if (_myBgImages.count > 0) {
//        return [_myBgImages[0] objectForKey:@"medium"];
//    }
//    return @"";
//}
//
//- (NSString *)myBgImageOrigin{
//    if (_myBgImages.count > 0) {
//        return [_myBgImages[0] objectForKey:@"origin"];
//    }
//    return @"";
//}


@end

