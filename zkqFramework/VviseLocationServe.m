//
//  VviseLocationServe.m
//  vviseLocation
//
//  Created by VVISE on 2020/3/30.
//  Copyright © 2020 vvise. All rights reserved.
//

#import "VviseLocationServe.h"
#import "AFNetworking.h"
@interface VviseLocationServe ()

@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation VviseLocationServe

-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        
        //1.设置证书模式
        NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"college.sx-sp.com_2018" ofType:@"cer"];
        NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
        //2.客户端是否信任非法证书
        _manager.securityPolicy.allowInvalidCertificates = YES;
        [_manager.securityPolicy setValidatesDomainName:NO];
        
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json",@"text/javascript", nil];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 20;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return _manager;
}



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
                     failureBlock:(FailureBlock)failureBlock{
    
    
    //1.加密
    
    //2.生成参数
    NSDictionary *parms = @{@"appId":appId,
                            @"appSecurity":appSecurity,
                            @"enterpriseSenderCode":enterpriseSenderCode,
                            @"environment":environment
    };
    //3.请求
    [self.manager POST:@"www.baidu.com" parameters:parms headers:nil constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingAllowFragments) error:nil];
        if ([dict isKindOfClass:[NSDictionary class]] && dict.count > 0) {
            
            successBlock(dict);
        }else{
            //解析失败
            NSError *error = [NSError errorWithDomain:@"error" code:-9999 userInfo:@{@"error":@"参数错误,请联系管理人员"}];
            failureBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
        
    }];
    
    
}





@end
