//
//  User.h
//  weddingBusiness
//
//  Created by GarrettGao on 15/1/9.
//  Copyright (c) 2015年 HunBoHui. All rights reserved.
//

#import "BaseModel.h"

@class BabyFollowBean;
@interface User : BaseModel

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *allScore;
@property (nonatomic, strong) NSString *bwcScore;
@property (nonatomic, strong) NSString *ptYcScore;
@property (nonatomic, strong) NSString *bwcYcScore;
@property (nonatomic, strong) NSDictionary *headImages;
//@property (nonatomic, strong) NSArray *myBgImages;
@property (nonatomic, readonly) NSString *headSmall;
@property (nonatomic, readonly) NSString *headBig;
@property (nonatomic, readonly) NSString *headOrigin;
//@property (nonatomic, readonly) NSString *myBgImageSmall;
//@property (nonatomic, readonly) NSString *myBgImageBig;
//@property (nonatomic, readonly) NSString *myBgImageOrigin;
@property (nonatomic, strong) NSString *bindStatus;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *source;

@property (nonatomic, strong) NSString *uLevel;
@property (nonatomic, strong) NSString *qrcodeImg;
@property (nonatomic, strong) NSString *uLevelUrl;
@property (nonatomic, strong) NSString *liveCity;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *qq;

//@property (nonatomic, strong) NSString *babyOperationStatus;//宝贝出生啦>
//@property (nonatomic, strong) NSString *babyShowStatus;//怀孕中 预产期2016年12月11日
//@property (nonatomic, strong) NSString *babyId;//2227
//@property (nonatomic, strong) NSString *stageType;//2

@end
