//
//  ZGActionSheet.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/15/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGBaseView.h"
#import "ZGHeadView.h"

@protocol ZGActionSheetDelegate <NSObject>
- (void)didClickOnImageIndex:(long int)imageIndex;
@optional
- (void)didClickOnCancelButton;
@end

@interface ZGActionSheet : ZGBaseView

@property (nonatomic , strong) UIPickerView *pickView;
@property (nonatomic , strong) UIButton *enterBtn;

- (id)initWithTitle:(NSString *)title delegate:(id<ZGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray frame:(CGRect)frame ;
- (id)initWithTitle:(NSString *)title delegate:(id<ZGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray frame:(CGRect)frame;
- (id)initPikerTypeWithDelegate:(id<ZGActionSheetDelegate>)delegate frame:(CGRect )frame;
- (void)showInView:(UIView *)view;
- (void)dismissed;

@end
