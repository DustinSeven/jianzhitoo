//
//  ZGMainNavigationController.m
//  jianzhitoo
//
//  Created by Lee Mingwei on 11/3/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGMainNavigationController.h"

@implementation ZGMainNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if(self)
    {
        self.navigationBarHidden = YES;
    }
    return self;
}

@end
