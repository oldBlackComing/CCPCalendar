//
//  NetRequest.h
//  MeiLiCity
//
//  Created by kwsdzjx on 15/4/27.
//  Copyright (c) 2015年 周佳兴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface NetRequest : NSObject


@property (strong, nonatomic)id MBShowView;

@property (strong, nonatomic)    AFHTTPSessionManager *manager;
/**
 网络请求类方法
 */
+(void)requestUrl:(NSString *)Url andParamas:(id)params andReturnBlock:( void(^)(NSData *data, NSError *error) )cb;
/**
 网络请求GET
 */
-(void)requestUrl:(NSString *)Url andParamas:(id)params andReturnBlock:( void(^)(NSData *data, NSError *error) )cb;

/**
 照片请求类方法 传入文件名
 */
+(void)postPictures:(NSData *)pic Url:(NSString *)url andFieldName:(NSString *)fieldName andReturnBlock:(void(^)(NSData *progress, NSError *error))cb andFloatProsess:(void(^)(CGFloat prosess))prosess;


@end
