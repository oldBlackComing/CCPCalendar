//
//  CIWAFBaseDataRequest.h
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIWRequestResult.h"
#import "CIWBaseDataRequest.h"

@class AFHTTPRequestOperationManager;
@class AFHTTPRequestSerializer;
@class AFHTTPRequestOperation;
/**
 * NOTE:BaseDataRequest will handle it`s own retain/release lifecycle management, no need to release it manually
 */
@interface CIWAFBaseDataRequest : CIWBaseDataRequest{
    
    AFHTTPRequestSerializer *_requestSerializer;
    AFHTTPRequestOperation *_requestOperation;
}

@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, strong) AFHTTPRequestSerializer *requestSerializer;
@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;

/**
 *  取消某个网络取消*/
+ (void)cancelRequestWithCancelSubject:(NSString *)cancelSubject;

- (void)requestDidReceiveReponseHeaders:(AFHTTPRequestOperationManager*)request;

/**
 * 设置网络请求配置*/
- (void)setNetWorkConfig;

/**
 * 设置需要拦截的异常码*/
- (NSArray *)getInterceptErrors;


@end
