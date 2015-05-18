//
//  ZGUtility.h
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "ZGBaseEntity.h"
#import "ZGActivityIndicator.h"
#import "ZGCommonAlertViewIphone.h"
#import "ZGSchoolmateAlertViewIphone.h"
#import "ZGFailImgAlertViewIphone.h"
#import "ZGSignInParam.h"
#import "ZGUpdateAlertView.h"
#import "ZGUpdateInfoEntity.h"

typedef enum
{
    JobType_Etiquette,
    JobType_Leaflet,
    JobType_Other,
    JobType_Promotion,
    JobType_Question,
    JobType_Traffic,
    JobType_Waiter
}JobType;

#define SHA1_DIGEST_LENGTH 20

@interface ZGUtility : NSObject

@property (nonatomic , strong) NSMutableArray *locationArr;
@property (nonatomic , strong) NSMutableArray *jobTypeArr;

+ (ZGUtility *)shareUtility;

+ (MBProgressHUD *)showProgressWithParentView:(UIView *)parentView
                                         text:(NSString *)text
                                   background:(UIColor *)color;

+ (ZGActivityIndicator *)showProgressWithParentView:(UIView *)parentView
                                         background:(UIColor *)color;
+ (ZGFailImgAlertViewIphone *)showImgAlertWithImg:(UIImage *)img frame:(CGRect)frame delegate:(id<ZGFailImgAlertViewIphoneDelegate>) delegate parentView:(UIView *)view;

+ (void)hideProgress:(MBProgressHUD *)progress;

+ (ZGCommonAlertViewIphone *)showAlertWithText:(NSString *)text parentView:(UIView *)view;

+ (ZGSchoolmateAlertViewIphone *)showSchoolmateAlertWithEntity:(ZGSchoolmateEntity *)entity parentView:(UIView *)view;

+ (ZGUpdateAlertView *)showUpdateAlertWithEntity:(ZGUpdateInfoEntity *)entity parentView:(UIView *)view;

+ (NSString*) sha1Algorithm:(NSString *)str;

- (int)reflectJobType:(NSString *)code;

- (UIImage *) getJobTypeImg:(JobType)type;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (void)view:(UIView *)view appearAt:(CGPoint)location withDalay:(CGFloat)delay duration:(CGFloat)duration;

+ (BOOL)checkTel:(NSString *)str;

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (void) saveImage:(UIImage *)currentImage;

+ (void)saveUserDefaults:(id)object key:(NSString *)key;

+ (id)readUserDefaults:(NSString *)key;

+ (void)removeUserDefaults:(NSString *)key;

+(UIImage *)getMoneyType:(NSString *)typeStr;

+(NSString *)stringWithMoneyUnite:(NSString *)str;

+(ZGSignInParam *)signInParamWithStr:(NSString *)str;

+(BOOL)isBeforePressent:(int)date;

+(BOOL)isInformationComplete;

+(NSArray *)customBarButtonItemWithNormalImg:(UIImage *)normalImg pressedImg:(UIImage *)pressedImg text:(NSString *)text target:(id)target action:(SEL)action spacing:(float)spacing;

+ (UIImage *)resizeImage:(NSString *)imageName;

@end
