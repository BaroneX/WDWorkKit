//
//  WDNetWork.m
//  WDNetWork
//
//  Created by Blake on 15/3/30.
//  Copyright (c) 2015年 Blake. All rights reserved.
//

#import "WDNetWork.h"

@interface WDNetWork ()

@property(nonatomic,strong)AFHTTPSessionManager* operation;
@property(nonatomic, assign)NSInteger timeInternal;



@end

@implementation WDNetWork

static WDNetWork* shareInstance;

+ (WDNetWork *)sharedInstance {
	
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareInstance = [[WDNetWork alloc]init];
        [shareInstance setTimeInternal:30];
        
    });
    
    return shareInstance;
}

- (void)getDataWithUrl:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(WDSuccessResponseBlock)success
                   failure:(WDFailResponseBlock)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:self.timeInternal];
    [manager GET:URLString
                       parameters:parameters
                          success:^(NSURLSessionTask *task, id responseObject) {
                              success(task, responseObject);
                          }
                          failure:^(NSURLSessionTask *task, NSError *error) {
                              failure(error);
                          }];
}

- (void)getJSONDataWithUrl:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(WDSuccessResponseBlock)success
                   failure:(WDFailResponseBlock)failure {
    
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:self.timeInternal];
    
//    if ([URLString isEqualToString:@"http://121.42.143.214:8080/shundrapi/cargo/getCargoInfoByCargoId"]) {
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    }

    self.operation = [manager GET:URLString
                       parameters:parameters
                          success:^(NSURLSessionTask *operation, id responseObject) {
                              success(operation, responseObject);
                          }
                          failure:^(NSURLSessionTask *operation, NSError *error) {
                              failure(error);
                          }];
}

- (void)postDataWithUrl:(NSString *)URLString
                 parameters:(NSDictionary *)parameters
                    success:(WDSuccessResponseBlock)success
                    failure:(WDFailResponseBlock)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:self.timeInternal];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.operation = [manager POST:URLString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionTask *task, NSError *error) {
        failure(error);
    }];
}

- (void)postJSONDataWithUrl:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(WDSuccessResponseBlock)success
                   failure:(WDFailResponseBlock)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:self.timeInternal];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    self.operation = [manager POST:URLString parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
        success(task,responseObject);
        
    } failure:^(NSURLSessionTask *task, NSError *error) {
        failure(error);
    }];
    
}

//- (void)postMultiFormDataWithUrl:(NSString*)URLString
//                        FormData:(NSData*)data
//                         success:(WDSuccessResponseBlock)success
//                         failure:(WDFailResponseBlock)failure {
//    NSMutableURLRequest *request = nil;
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setTimeoutInterval:self.timeInternal];
//    request = [manager.requestSerializer multipartFormRequestWithMethod:@"POST"
//                                                              URLString:URLString
//                                                             parameters:nil
//                                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//                                                  [formData appendPartWithFileData:data
//                                                                              name:@"file"
//                                                                          fileName:@"file.jpeg"
//                                                                          mimeType:@"image/jpeg"];
//                                              }
//                                                                  error:nil];
//    NSURLSessionTask *task = [manager HTTPRequestOperationWithRequest:request
//                                                                         success:success
//                                                                         failure:^(NSURLSessionTask *task, NSError *error){
//                                                                             failure(error);
//                                                                         }];
//    [manager.operationQueue addOperation:operation];
//}

-(void)setValidationTimeInternal:(NSInteger)time
{
    self.timeInternal = time;
}

- (void)cancelAFURLRequest
{
    if (self.operation != nil) {
        if (![self.operation isCancelled]) {
            [self.operation cancel];
            self.operation = nil;
        }
    }
}

@end
