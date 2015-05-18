//
//  ZGChangeUserInfoProcess.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/16/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGChangeUserInfoProcess.h"

@implementation ZGChangeUserInfoProcess


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    static ZGChangeUserInfoProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[ZGChangeUserInfoProcess alloc] init];
    });
    
    return process;
}

- (void)getAllProvinceWithParentView:(UIView *)parentView
                        progressText:(NSString *)text
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[ZGHttpClient shareClient] POST:GET_ALL_PROVINCE_URL
                          parameters:nil
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 [ZGUtility hideProgress:progress];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 [ZGUtility hideProgress:progress];
                             }];
}


- (void)getCityWithParam:(NSDictionary *)param
              ParentView:(UIView *)parentView
            progressText:(NSString *)text
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[ZGHttpClient shareClient] POST:GET_CITY_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 [ZGUtility hideProgress:progress];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 [ZGUtility hideProgress:progress];
                             }];
}


- (void)getAreaWithParam:(NSDictionary *)param
              ParentView:(UIView *)parentView
            progressText:(NSString *)text
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[ZGHttpClient shareClient] POST:GET_AREA_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 [ZGUtility hideProgress:progress];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 [ZGUtility hideProgress:progress];
                             }];
}

- (void)updateUserInfoWithParam:(NSDictionary *)param
                     ParentView:(UIView *)parentView
                   progressText:(NSString *)text
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[ZGHttpClient shareClient] POST:UPDATE_USER_INFO_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 [ZGUtility hideProgress:progress];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 [ZGUtility hideProgress:progress];
                             }];
}

- (void)getCollegeWithParam:(NSDictionary *)param
                 ParentView:(UIView *)parentView
               progressText:(NSString *)text
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[ZGHttpClient shareClient] POST:GET_COLLEGE_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 [ZGUtility hideProgress:progress];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 [ZGUtility hideProgress:progress];
                             }];
}


- (void)getDepartmentWithParam:(NSDictionary *)param
                 ParentView:(UIView *)parentView
               progressText:(NSString *)text
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[ZGHttpClient shareClient] POST:GET_DEPARTMENT_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 [ZGUtility hideProgress:progress];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 [ZGUtility hideProgress:progress];
                             }];
}

- (void)uploadUserImgWithParam:(NSDictionary *)param
                    ParentView:(UIView *)parentView
                  progressText:(NSString *)text
                           img:(UIImage *)img
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[ZGUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[ZGHttpClient shareClient] POST:UPLOAD_USER_IMG_URL parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
//        NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//        NSString *documentsDirectory=[paths objectAtIndex:0];
//        NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:TMP_USER_IMG_NAME_WITH_TYPE];
//        
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:savedImagePath] name:@"userimage" error:nil];
        [formData appendPartWithFileData:UIImagePNGRepresentation(img)
                                    name:@"userimage"
                                fileName:TMP_USER_IMG_NAME_WITH_TYPE
                                mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(operation,responseObject);
        
        [ZGUtility hideProgress:progress];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(operation,error);
        
        [ZGUtility hideProgress:progress];
        
    }];
}





@end
