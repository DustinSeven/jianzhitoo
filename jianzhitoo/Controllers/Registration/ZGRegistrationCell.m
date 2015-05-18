//
//  ZGRegistrationCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/14/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGRegistrationCell.h"

@implementation ZGRegistrationCell

- (id)init
{
    self = [super init];
    if(self)
    {
        self.cellType = RegistrationCellType_add;
        
        self.textLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, RegistrationCellWithHeight, RegistrationCellWithHeight)];
        self.textLab.layer.cornerRadius = RegistrationCellWithHeight / 2;
        self.textLab.layer.borderWidth = 2;
        self.textLab.layer.masksToBounds = YES;
        self.textLab.textAlignment = NSTextAlignmentCenter;
        self.textLab.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLab.numberOfLines = 0;
        self.textLab.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textLab];
        
        self.statusImg = [[UIImageView alloc]initWithFrame:CGRectMake(RegistrationCellWithHeight - 11, 5, 11, 11)];
        self.statusImg.backgroundColor = [UIColor clearColor];
        [self addSubview:self.statusImg];
    }
    return self;
}

- (void)chooseStatus:(RegistrationCellType ) type
{
    if(type == RegistrationCellType_add)
    {
        self.textLab.backgroundColor = [UIColor clearColor];
        self.textLab.layer.borderColor = GridViewCellBackgroundNormal.CGColor;
        self.textLab.textColor = GridViewCellBackgroundNormal;
        self.statusImg.image = [UIImage imageNamed:@"registration_add_icon"];
        
        self.cellType = RegistrationCellType_add;
    }
    
    if(type == RegistrationCellType_added)
    {
        self.textLab.backgroundColor = GridViewCellBackgroundNormal;
        self.textLab.layer.borderColor = GridViewCellBackgroundNormal.CGColor;
        self.textLab.textColor = [UIColor whiteColor];
        self.statusImg.image = [UIImage imageNamed:@"registration_added_icon"];
        
        self.cellType = RegistrationCellType_added;
    }
    
    if(type == RegistrationCellType_cancel)
    {
        self.textLab.backgroundColor = [UIColor clearColor];
        self.textLab.layer.borderColor = GridViewCellBackgroundCancel.CGColor;
        self.textLab.textColor = GridViewCellBackgroundCancel;
        self.statusImg.image = [UIImage imageNamed:@"registration_cancel_icon"];
        
        self.cellType = RegistrationCellType_cancel;
    }
}

@end
