//
//  VviseLocationServe.h
//  vviseLocation
//
//  Created by VVISE on 2020/3/30.
//  Copyright © 2020 vvise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define debug @"debug"
#define release @"release"
typedef void(^SuccessBlock)(NSDictionary *Result);
typedef void(^FailureBlock)(NSError *Error);

@interface VviseLocationServe : NSObject

//开启定位服务
//appId                  企业平台appId
//appSecurity            企业平台appSecurity
//enterpriseSenderCode   企业唯一标识
//environment            环境：“debug”测试，“release”正式
//successBlock           请求成功的json数据
//failureBlock           请求失败NSError
-(void)vvise_OpenServiceWithAppId:(NSString *)appId
                      appSecurity:(NSString *)appSecurity
             enterpriseSenderCode:(NSString *)enterpriseSenderCode
                      environment:(NSString *)environment
                     successBlock:(SuccessBlock)successBlock
                     failureBlock:(FailureBlock)failureBlock;









@end

NS_ASSUME_NONNULL_END
