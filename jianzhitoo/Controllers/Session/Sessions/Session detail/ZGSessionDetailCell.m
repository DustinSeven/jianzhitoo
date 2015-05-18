//
//  ZGSessionDetailCell.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/12.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGSessionDetailCell.h"

@implementation ZGSessionDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        
        self.timeLab = [[UILabel alloc] init];
        self.timeLab.textAlignment = NSTextAlignmentCenter;
        self.timeLab.textColor = [UIColor grayColor];
        self.timeLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.timeLab];
        
        self.userImg = [[UIImageView alloc] init];
        [self.contentView addSubview:self.userImg];
        
        self.chatContent = [UIButton buttonWithType:UIButtonTypeCustom];
        self.chatContent.backgroundColor = [UIColor clearColor];
        self.chatContent.titleLabel.numberOfLines = 0;
        self.chatContent.titleLabel.font = [UIFont systemFontOfSize:13];
        self.chatContent.contentEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
        [self.contentView addSubview:self.chatContent];
    }
    return self;
}

- (void)setFrameModel:(ZGSessionDetailCellFrameModel *)frameModel
{
    self.timeLab.frame = frameModel.timeFrame;
    self.timeLab.text = frameModel.timeStr;
    
    self.userImg.frame = frameModel.imgFrame;
    if(frameModel.imgStr)
    {
        [self.userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,frameModel.imgStr]] placeholderImage:[UIImage imageNamed:@"user_img_default_80px"] isScaleToCustomSize:NO];
    }
    else
        self.userImg.image = [UIImage imageNamed:@"user_img_default_80px"];
    
    self.chatContent.frame = frameModel.contentFrame;
    NSString *textBg = !frameModel.isMe ? @"chat_recive_nor" : @"chat_send_nor";
    UIColor *textColor = !frameModel.isMe ? [UIColor blackColor] : [UIColor whiteColor];
    [self.chatContent setBackgroundImage:[ZGUtility resizeImage:textBg] forState:UIControlStateNormal];
    [self.chatContent setTitleColor:textColor forState:UIControlStateNormal];
    [self.chatContent setTitle:frameModel.message forState:UIControlStateNormal];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
