//
//  CIWRequestError.h
//  HunBaSha
//
//  Created by GarrettGao on 2017/7/24.
//  Copyright © 2017年 hunbohui. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRequestErrorInterceptNotification @"kRequestErroriInterceptNotification_hbh"

@interface CIWRequestError : NSObject

/** 处理所有接口的异常码
 @ error 接口返回的状态吗
 @ return 是否发生异常(BOOL)
 */
+ (BOOL)requestIsErrorWith:(NSString *)error withCongigurationErrors:(NSArray *)errors;

@end
