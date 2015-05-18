//
//  ZGBaseNavigationController.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseNavigationController.h"

@implementation ZGBaseNavigationController

-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if(self)
    {
        self.navigationBarHidden = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [ZGUtility imageWithColor:HeadViewBackground size:CGSizeMake(SCREEN_WIDTH, HeadViewHeight)];
    UIEdgeInsets edgeInsets;
    edgeInsets.left = 0.0f;
    edgeInsets.top = 0.0f;
    edgeInsets.right = 0.0f;
    edgeInsets.bottom = 0.0f;
    image = [image resizableImageWithCapInsets:edgeInsets];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     @{ NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL + 5]}];
    
//    self.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
}

@end
