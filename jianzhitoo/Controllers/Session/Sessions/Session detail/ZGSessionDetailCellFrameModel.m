//
//  ZGSessionDetailCellFrameModel.m
//  jianzhitoo
//
//  Created by 李明伟 on 15/1/12.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "ZGSessionDetailCellFrameModel.h"

#define timeH 40
#define padding 10
#define iconW 40
#define iconH 40
#define textW 150

@implementation ZGSessionDetailCellFrameModel


- (void)initValue
{
    if (self.isShowTime) {
        CGFloat timeFrameX = 0;
        CGFloat timeFrameY = 0;
        CGFloat timeFrameW = SCREEN_WIDTH;
        CGFloat timeFrameH = timeH;
        self.timeFrame = CGRectMake(timeFrameX, timeFrameY, timeFrameW, timeFrameH);
    }
    
    CGFloat iconFrameX = !self.isMe ? padding : (SCREEN_WIDTH - padding - iconW);
    CGFloat iconFrameY = CGRectGetMaxY(self.timeFrame);
    CGFloat iconFrameW = iconW;
    CGFloat iconFrameH = iconH;
    self.imgFrame = CGRectMake(iconFrameX, iconFrameY, iconFrameW, iconFrameH);
    
    CGSize textMaxSize = CGSizeMake(textW, MAXFLOAT);
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL]};
    CGSize textSize = [self.message boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    CGSize textRealSize = CGSizeMake(textSize.width + 15 * 2, textSize.height + 15 * 2);
    CGFloat textFrameY = iconFrameY;
    CGFloat textFrameX = !self.isMe ? (2 * padding + iconFrameW) : (SCREEN_WIDTH - (padding * 2 + iconFrameW + textRealSize.width));
    self.contentFrame = (CGRect){textFrameX, textFrameY, textRealSize};
    
    self.cellHeght = MAX(CGRectGetMaxY(self.imgFrame), CGRectGetMaxY(self.contentFrame)) + padding;
}


@end
