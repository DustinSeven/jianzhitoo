//
//  ZGUtility.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/5/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGUtility.h"
#import <CommonCrypto/CommonDigest.h>
#import "ZGJobTypeEntity.h"
#import "ZGUserEntity.h"
#import "ZGUserInfoEntity.h"



static ZGUtility *utility;
@implementation ZGUtility

- (id)init{
    self = [super init];
    if(self){
    }
    return self;
}

+ (ZGUtility *)shareUtility
{
    @synchronized([ZGUtility class]){
        if(!utility){
            utility = [[self alloc]init];
        }
        return  utility;
    }
    return nil;
}

+ (MBProgressHUD *)showProgressWithParentView:(UIView *)parentView
                                         text:(NSString *)text
                                   background:(UIColor *)color
{
    MBProgressHUD *progress = nil;
    
    if (!parentView) {
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        window.backgroundColor = [UIColor clearColor];
        progress = [[MBProgressHUD alloc] initWithWindow:window];
        parentView = window;
    } else {
        progress = [[MBProgressHUD alloc] initWithView:parentView];
    }
    
    if (!text || text.length == 0) {
        text = @"Loading...";
    }
    
    progress.removeFromSuperViewOnHide = YES;
    progress.color = [UIColor colorWithRed:0 / 255 green:0 / 255 blue:0 / 255 alpha:0.4];
    progress.labelText = text;
//    progress.animationType = MBProgressHUDAnimationZoomIn;
    progress.mode = MBProgressHUDModeIndeterminate;
    if(color)
        progress.color = color;
    [parentView addSubview:progress];
    [progress show:YES];
    
    return progress;
}

+ (void)hideProgress:(MBProgressHUD *)progress
{
    [progress hide:YES];
}

+ (ZGActivityIndicator *)showProgressWithParentView:(UIView *)parentView
                                         background:(UIColor *)color
{
    ZGActivityIndicator *progress = nil;
    
    if (!parentView) {
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        window.backgroundColor = [UIColor clearColor];
        progress = [[ZGActivityIndicator alloc] initWithView:window];
        parentView = window;
    } else {
        progress = [[ZGActivityIndicator alloc] initWithView:parentView];
    }

    if(color)
        progress.color = color;
    [parentView addSubview:progress];
    [progress startAnimation];
    
    return progress;

}

+ (ZGCommonAlertViewIphone *)showAlertWithText:(NSString *)text parentView:(UIView *)view
{
    
    ZGCommonAlertViewIphone *alert = nil;
    
    if (!view) {
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        window.backgroundColor = [UIColor clearColor];
        alert = [[ZGCommonAlertViewIphone alloc] initWithView:window];
        view = window;
    } else {
        alert = [[ZGCommonAlertViewIphone alloc] initWithView:view];
    }
    
    [view addSubview:alert];
    [alert showAlertWithText:text];
    
    return alert;
}

+ (ZGSchoolmateAlertViewIphone *)showSchoolmateAlertWithEntity:(ZGSchoolmateEntity *)entity parentView:(UIView *)view
{
    
    ZGSchoolmateAlertViewIphone *alert = nil;
    
    if (!view) {
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        window.backgroundColor = [UIColor clearColor];
        alert = [[ZGSchoolmateAlertViewIphone alloc] initWithView:window];
        view = window;
    } else {
        alert = [[ZGSchoolmateAlertViewIphone alloc] initWithView:view];
    }
    
    [view addSubview:alert];
    [alert showAlertWithEntity:entity];
    
    return alert;
}

+ (ZGUpdateAlertView *)showUpdateAlertWithEntity:(ZGUpdateInfoEntity *)entity parentView:(UIView *)view
{
    
    ZGUpdateAlertView *alert = nil;
    
    if (!view) {
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        window.backgroundColor = [UIColor clearColor];
        alert = [[ZGUpdateAlertView alloc] initWithView:window];
        view = window;
    } else {
        alert = [[ZGUpdateAlertView alloc] initWithView:view];
    }
    
    [view addSubview:alert];
    [alert showAlertWithEntity:entity];
    
    return alert;
}


+ (ZGFailImgAlertViewIphone *)showImgAlertWithImg:(UIImage *)img frame:(CGRect)frame delegate:(id<ZGFailImgAlertViewIphoneDelegate>) delegate parentView:(UIView *)view
{
    
    ZGFailImgAlertViewIphone *alert = nil;
    
    if (!view) {
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        window.backgroundColor = [UIColor clearColor];
        alert = [[ZGFailImgAlertViewIphone alloc] initWithView:window];
        view = window;
    } else {
        alert = [[ZGFailImgAlertViewIphone alloc] initWithView:view];
    }
    
    [view addSubview:alert];
    [alert showAlertWithImg:img frame:frame delegate:delegate fatherView:view];
    
    return alert;
}

+ (NSString*) sha1Algorithm:(NSString *)srcString
{
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

- (int)reflectJobType:(NSString *)code
{
    for(int i = 0;i<self.jobTypeArr.count;++i)
    {
        ZGJobTypeEntity *tmpEntity = [self.jobTypeArr objectAtIndex:i];
        if([code isEqualToString:[NSString stringWithFormat:@"%@",tmpEntity.identity]])
        {
            if([tmpEntity.name isEqualToString:@"礼仪模特"])
                return JobType_Etiquette;
            else if([tmpEntity.name isEqualToString:@"发传单"])
                return JobType_Leaflet;
            else if([tmpEntity.name isEqualToString:@"促销员"])
                return JobType_Promotion;
            else if([tmpEntity.name isEqualToString:@"问卷调查"])
                return JobType_Question;
            else if([tmpEntity.name isEqualToString:@"话务员"])
                return JobType_Traffic;
            else if([tmpEntity.name isEqualToString:@"服务员"])
                return JobType_Waiter;
        }
    }
    return JobType_Other;
    
}

- (UIImage *) getJobTypeImg:(JobType)type
{
    switch (type) {
        case JobType_Etiquette:
            return [UIImage imageNamed:@"job_type_icon_etiquette"];
            break;
        case JobType_Leaflet:
            return [UIImage imageNamed:@"job_type_icon_leaflet"];
            break;
        case JobType_Other:
            return [UIImage imageNamed:@"job_type_icon_other"];
            break;
        case JobType_Promotion:
            return [UIImage imageNamed:@"job_type_icon_promotion"];
            break;
        case JobType_Question:
            return [UIImage imageNamed:@"job_type_icon_question"];
            break;
        case JobType_Traffic:
            return [UIImage imageNamed:@"job_type_icon_traffic"];
            break;
        case JobType_Waiter:
            return [UIImage imageNamed:@"job_type_icon_waiter"];
            break;
            
        default:
            return nil;
            break;
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (void)view:(UIView *)view appearAt:(CGPoint)location withDalay:(CGFloat)delay duration:(CGFloat)duration
{
    view.center = location;
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.duration = duration;
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    scaleAnimation.calculationMode = kCAAnimationLinear;
    scaleAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:delay],[NSNumber numberWithFloat:1.0f]];
    view.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    [view.layer addAnimation:scaleAnimation forKey:@"viewAppear"];
}

+ (BOOL)checkTel:(NSString *)str

{
    NSString *regex = @"^0?(13[0-9]|15[0123456789]|18[0123456789]|17[0123456789]|14[57])[0-9]{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
        return NO;
    return YES;
}

+ (void) saveImage:(UIImage *)currentImage
{
    
    NSData *imagedata=UIImagePNGRepresentation(currentImage);
    //JEPG格式
    //NSData *imagedata=UIImageJEPGRepresentation(m_imgFore,1.0);
    
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    
    NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:TMP_USER_IMG_NAME_WITH_TYPE];
    
    [imagedata writeToFile:savedImagePath atomically:YES];
}

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

+ (void)saveUserDefaults:(id)object key:(NSString *)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    //transform data
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [userDefault setObject:data
                    forKey:key];
    [userDefault synchronize];
}

+ (id)readUserDefaults:(NSString *)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    id obj = [userDefault objectForKey:key];
    //transform object
    if (obj) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    } else {
        return nil;
    }
}

+ (void)removeUserDefaults:(NSString *)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:key];
    [userDefault synchronize];
}

+(UIImage *)getMoneyType:(NSString *)typeStr
{
    if([typeStr isEqualToString:@"end_day"])
        return [UIImage imageNamed:@"job_detail_money_paid_by_day_icon"];
    if([typeStr isEqualToString:@"end_week"])
        return [UIImage imageNamed:@"job_detail_money_paid_by_week_icon"];
    if([typeStr isEqualToString:@"end_month"])
        return [UIImage imageNamed:@"job_detail_money_paid_by_month_icon"];
    if([typeStr isEqualToString:@"end_finish"])
        return [UIImage imageNamed:@"job_detail_money_paid_by_end_icon"];
    return nil;
}

+(NSString *)stringWithMoneyUnite:(NSString *)str
{
    if([str isEqualToString:@"hour"])
        return @"小时";
    if([str isEqualToString:@"day"])
        return @"天";
    if([str isEqualToString:@"month"])
        return @"月";
    return nil;
    
}

+(ZGSignInParam *)signInParamWithStr:(NSString *)str
{
    ZGSignInParam *param = [[ZGSignInParam alloc]init];
    
    NSArray *arr = [str componentsSeparatedByString:@"^"];
    if(arr.count != 3)
        return nil;
    
    NSString *head = [arr objectAtIndex:0];
    if(![head isEqualToString:@"action:checkin"])
        return nil;
    
    NSString *jobId = [arr objectAtIndex:1];
    NSArray *jobIdArr = [jobId componentsSeparatedByString:@":"];
    if(jobIdArr.count != 2)
        return nil;
    param.jobId = [[jobIdArr objectAtIndex:1]integerValue];
    
    NSString *checkCode = [arr objectAtIndex:2];
    NSArray *checkCodeArr = [checkCode componentsSeparatedByString:@":"];
    if(checkCodeArr.count != 2)
        return nil;
    param.checkCode = [checkCodeArr objectAtIndex:1];
    
    return param;
}


+(BOOL)isBeforePressent:(int)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    int current = [currentDateStr intValue];
    if(current > date)
        return NO;
    return YES;
}

+(BOOL)isInformationComplete
{
    ZGUserInfoEntity *userInfoEntity = [ZGUtility readUserDefaults:USERDEFAULTS_USER_INFO_KEY];
    
    if(!userInfoEntity.account)
        return NO;
    if(!userInfoEntity.sex)
        return NO;
    if(!userInfoEntity.schoolYear)
        return NO;
    if(!userInfoEntity.college)
        return NO;
    if(!userInfoEntity.depatment)
        return NO;
    if(!userInfoEntity.specialty)
        return NO;
    
    return YES;
}

+(NSArray *)customBarButtonItemWithNormalImg:(UIImage *)normalImg pressedImg:(UIImage *)pressedImg text:(NSString *)text target:(id)target action:(SEL)action spacing:(float)spacing
{
    UIBarButtonItem *btn;
    
    UIButton *btnCus = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCus.frame = CGRectMake(0, 0, NavLeftBtnWidth, NavLeftBtnHeight);
    
    [btnCus setImage:normalImg forState:UIControlStateNormal];
    [btnCus setImage:pressedImg forState:UIControlStateHighlighted];
    [btnCus setTitle:text forState:UIControlStateNormal];
    [btnCus addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn = [[UIBarButtonItem alloc]initWithCustomView:btnCus];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = spacing;
    return @[negativeSpacer, btn];
   }

+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
}

@end
