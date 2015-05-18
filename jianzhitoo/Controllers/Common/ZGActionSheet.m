//
//  ZGActionSheet.m
//  jianzhitoo
//
//  Created by 李明伟 on 11/15/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "ZGActionSheet.h"


#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:106/255.00f green:106/255.00f blue:106/255.00f alpha:0.8]
#define ANIMATE_DURATION                        0.25f

#define CORNER_RADIUS                           5
#define SHAREBUTTON_BORDER_WIDTH                0.5f
#define SHAREBUTTON_BORDER_COLOR                [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8].CGColor
#define SHAREBUTTONTITLE_FONT                   [UIFont systemFontOfSize:18]

#define CANCEL_BUTTON_COLOR                     [UIColor colorWithRed:212/255.00f green:209/255.00f blue:209/255.00f alpha:1]

#define SHAREBUTTON_WIDTH                       50
#define SHAREBUTTON_HEIGHT                      50
#define SHAREBUTTON_INTERVAL_WIDTH              42.5
#define SHAREBUTTON_INTERVAL_HEIGHT             35

#define SHARETITLE_WIDTH                        50
#define SHARETITLE_HEIGHT                       20
#define SHARETITLE_INTERVAL_WIDTH               42.5
#define SHARETITLE_INTERVAL_HEIGHT              SHAREBUTTON_WIDTH+SHAREBUTTON_INTERVAL_HEIGHT
#define SHARETITLE_FONT                         [UIFont systemFontOfSize:16]

#define TITLE_INTERVAL_HEIGHT                   15
#define TITLE_HEIGHT                            35
#define TITLE_INTERVAL_WIDTH                    30
#define TITLE_WIDTH                             260
#define TITLE_FONT                              [UIFont systemFontOfSize:10]
#define SHADOW_OFFSET                           CGSizeMake(0, 0.8f)
#define TITLE_NUMBER_LINES                      2

#define BUTTON_INTERVAL_HEIGHT                  20
#define BUTTON_HEIGHT                           40
#define BUTTON_INTERVAL_WIDTH                   40
#define BUTTON_WIDTH                            (IS_IPHONE6?295:240)
#define BUTTONTITLE_FONT                        [UIFont systemFontOfSize:18]
#define BUTTON_BORDER_WIDTH                     0.5f
#define BUTTON_BORDER_COLOR                     [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8].CGColor

#define ButtonPressedColor [UIColor colorWithRed:237.0f / 255.0f green:234.0f / 255.0f blue:234.0f / 255.0f alpha:1.0f]


@interface UIImage (custom)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end


@implementation UIImage (custom)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end

@interface ZGActionSheet ()

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) NSString *actionTitle;
@property (nonatomic,assign) NSInteger postionIndexNumber;
@property (nonatomic,assign) BOOL isHadTitle;
@property (nonatomic,assign) BOOL isHadShareButton;
@property (nonatomic,assign) BOOL isHadCancelButton;
@property (nonatomic,assign) CGFloat ZGActionSheetHeight;
@property (nonatomic,assign) id<ZGActionSheetDelegate>delegate;



@end

@implementation ZGActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

#pragma mark - Public method

- (id)initWithTitle:(NSString *)title delegate:(id<ZGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray frame:(CGRect)frame;
{
    self = [super init];
    if (self) {
        
        [self initBaseView:delegate frame:frame];
        
        [self creatButtonsWithTitle:title cancelButtonTitle:cancelButtonTitle shareButtonTitles:shareButtonTitlesArray withShareButtonImagesName:shareButtonImagesNameArray];
        
    }
    return self;
}

- (id)initWithTitle:(NSString *)title delegate:(id<ZGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray frame:(CGRect)frame
{
    self = [super init];
    if (self) {
        
        [self initBaseView:delegate frame:frame];
        
        [self creatButtonsWithTitle:title cancelButtonTitle:cancelButtonTitle shareButtonTitles:shareButtonTitlesArray];
        
    }
    return self;
}

- (id)initPikerTypeWithDelegate:(id<ZGActionSheetDelegate>)delegate frame:(CGRect )frame
{
    self  = [super init];
    if(self)
    {
        [self initBaseView:delegate frame:frame];
        //初始化
        self.isHadTitle = NO;
        self.isHadShareButton = NO;
        self.isHadCancelButton = NO;
        
        //初始化LXACtionView的高度为0
        self.ZGActionSheetHeight = 180;
        
        //初始化IndexNumber为0;
        self.postionIndexNumber = 0;
        
        //生成LXActionSheetView
        self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.backGroundView.backgroundColor = [UIColor whiteColor];
        
        //给LXActionSheetView添加响应事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
        [self.backGroundView addGestureRecognizer:tapGesture];
        [self addSubview:self.backGroundView];
    
        self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 50)];
        [self.backGroundView addSubview:self.pickView];
        self.pickView.showsSelectionIndicator = YES;
        self.pickView.backgroundColor = [UIColor clearColor];
        
        self.enterBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.enterBtn setTitle:@"确认" forState:UIControlStateNormal];
        [self.enterBtn setTitleColor:APP_FONT_COLOR_NORMAL forState:UIControlStateNormal];
        self.enterBtn.layer.borderColor = APP_FONT_COLOR_NORMAL.CGColor;
        self.enterBtn.layer.borderWidth = 1;
        self.enterBtn.layer.cornerRadius = 3;
        self.enterBtn.backgroundColor = [UIColor whiteColor];
        self.enterBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 10, 50, 30);
        [self.enterBtn addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self.backGroundView addSubview:self.enterBtn];
        
        self.isHadCancelButton = YES;
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelBtn.tag = self.postionIndexNumber;
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:APP_FONT_COLOR_NORMAL forState:UIControlStateNormal];
        cancelBtn.layer.borderColor = APP_FONT_COLOR_NORMAL.CGColor;
        cancelBtn.layer.borderWidth = 1;
        cancelBtn.layer.cornerRadius = 3;
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.frame = CGRectMake(10, 10, 50, 30);
        [cancelBtn addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self.backGroundView addSubview:cancelBtn];
        self.postionIndexNumber++;
        
        [UIView animateWithDuration:ANIMATE_DURATION animations:^{
            [self.backGroundView setFrame:CGRectMake(0, self.frame.size.height-self.ZGActionSheetHeight, [UIScreen mainScreen].bounds.size.width, self.ZGActionSheetHeight)];
        } completion:^(BOOL finished) {
        }];
    }
    
    
        
    
    
    return self;
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
}

#pragma mark - Praviate method

- (void)initBaseView:(id<ZGActionSheetDelegate>)delegate frame:(CGRect)frame
{
    self.frame = frame;
    self.backgroundColor = WINDOW_COLOR;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    
    if (delegate) {
        self.delegate = delegate;
    }
}

- (void)creatButtonsWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle shareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray
{
    //初始化
    self.isHadTitle = NO;
    self.isHadShareButton = NO;
    self.isHadCancelButton = NO;
    
    //初始化LXACtionView的高度为0
    self.ZGActionSheetHeight = 0;
    
    //初始化IndexNumber为0;
    self.postionIndexNumber = 0;
    
    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backGroundView.backgroundColor = [UIColor colorWithRed:229.0f / 255.0f green:229.0f / 255.0f blue:229.0f / 255.0f alpha:1.0f];
    
    //给LXActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
    
    [self addSubview:self.backGroundView];
    self.hidden = NO;
    
    if (title) {
        self.isHadTitle = YES;
        UILabel *titleLabel = [self creatTitleLabelWith:title];
        self.ZGActionSheetHeight = self.ZGActionSheetHeight + 2*TITLE_INTERVAL_HEIGHT+TITLE_HEIGHT;
        [self.backGroundView addSubview:titleLabel];
    }
    
    if (shareButtonImagesNameArray) {
        if (shareButtonImagesNameArray.count > 0) {
            self.isHadShareButton = YES;
            for (int i = 1; i < shareButtonImagesNameArray.count+1; i++) {
                //计算出行数，与列数
                int column = (int)ceil((float)(i)/3); //行
                int line = (i)%3; //列
                if (line == 0) {
                    line = 3;
                }
                UIButton *shareButton = [self creatShareButtonWithColumn:column andLine:line];
                shareButton.tag = self.postionIndexNumber;
                [shareButton addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
                
                [shareButton setBackgroundImage:[UIImage imageNamed:[shareButtonImagesNameArray objectAtIndex:i-1]] forState:UIControlStateNormal];
                //有Title的时候
                if (self.isHadTitle == YES) {
                    [shareButton setFrame:CGRectMake(SHAREBUTTON_INTERVAL_WIDTH+((line-1)*(SHAREBUTTON_INTERVAL_WIDTH+SHAREBUTTON_WIDTH)), self.ZGActionSheetHeight+((column-1)*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT)), SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
                }
                else{
                    [shareButton setFrame:CGRectMake(SHAREBUTTON_INTERVAL_WIDTH+((line-1)*(SHAREBUTTON_INTERVAL_WIDTH+SHAREBUTTON_WIDTH)), SHAREBUTTON_INTERVAL_HEIGHT+((column-1)*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT)), SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
                }
                [self.backGroundView addSubview:shareButton];
                
                self.postionIndexNumber++;
            }
        }
    }
    
    if (shareButtonTitlesArray) {
        if (shareButtonTitlesArray.count > 0 && shareButtonImagesNameArray.count > 0) {
            for (int j = 1; j < shareButtonTitlesArray.count+1; j++) {
                //计算出行数，与列数
                int column = (int)ceil((float)(j)/3); //行
                int line = (j)%3; //列
                if (line == 0) {
                    line = 3;
                }
                UILabel *shareLabel = [self creatShareLabelWithColumn:column andLine:line];
                shareLabel.text = [shareButtonTitlesArray objectAtIndex:j-1];
                //有Title的时候
                if (self.isHadTitle == YES) {
                    [shareLabel setFrame:CGRectMake(SHARETITLE_INTERVAL_WIDTH+((line-1)*(SHARETITLE_INTERVAL_WIDTH+SHARETITLE_WIDTH)), self.ZGActionSheetHeight+SHAREBUTTON_HEIGHT+((column-1)*(SHARETITLE_INTERVAL_HEIGHT)), SHARETITLE_WIDTH, SHARETITLE_HEIGHT)];
                }
                [self.backGroundView addSubview:shareLabel];
            }
        }
    }
    
    //再次计算加入shareButtons后LXActivity的高度
    if (shareButtonImagesNameArray && shareButtonImagesNameArray.count > 0) {
        int totalColumns = (int)ceil((float)(shareButtonImagesNameArray.count)/3);
        if (self.isHadTitle  == YES) {
            self.ZGActionSheetHeight = self.ZGActionSheetHeight + totalColumns*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT);
        }
        else{
            self.ZGActionSheetHeight = SHAREBUTTON_INTERVAL_HEIGHT + totalColumns*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT);
        }
    }
    
    if (cancelButtonTitle) {
        self.isHadCancelButton = YES;
        UIButton *cancelButton = [self creatCancelButtonWith:cancelButtonTitle];
        cancelButton.tag = self.postionIndexNumber;
        [cancelButton addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        //当没title destructionButton otherbuttons时
        if (self.isHadTitle == NO && self.isHadShareButton == NO) {
            self.ZGActionSheetHeight = self.ZGActionSheetHeight + cancelButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
        }
        //当有title或destructionButton或otherbuttons时
        if (self.isHadTitle == YES || self.isHadShareButton == YES) {
            [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, self.ZGActionSheetHeight, cancelButton.frame.size.width, cancelButton.frame.size.height)];
            self.ZGActionSheetHeight = self.ZGActionSheetHeight + cancelButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
        }
        [self.backGroundView addSubview:cancelButton];
        
        self.postionIndexNumber++;
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, self.frame.size.height-self.ZGActionSheetHeight, [UIScreen mainScreen].bounds.size.width, self.ZGActionSheetHeight)];
    } completion:^(BOOL finished) {
    }];
}


- (void)creatButtonsWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle shareButtonTitles:(NSArray *)shareButtonTitlesArray
{
    //初始化
    self.isHadTitle = NO;
    self.isHadShareButton = NO;
    self.isHadCancelButton = NO;
    
    //初始化LXACtionView的高度为0
    self.ZGActionSheetHeight = 0;
    
    //初始化IndexNumber为0;
    self.postionIndexNumber = 0;
    
    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backGroundView.backgroundColor = [UIColor colorWithRed:239.0f / 255.0f green:239.0f / 255.0f blue:239.0f / 255.0f alpha:1.0f];
    
    //给LXActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
    
    [self addSubview:self.backGroundView];
    self.hidden = NO;
    
    if (title) {
        self.isHadTitle = YES;
        UILabel *titleLabel = [self creatTitleLabelWith:title];
        self.ZGActionSheetHeight = self.ZGActionSheetHeight + 2*TITLE_INTERVAL_HEIGHT+TITLE_HEIGHT;
        [self.backGroundView addSubview:titleLabel];
    }
    
    if (shareButtonTitlesArray) {
        
        self.isHadShareButton = YES;
        for (int i = 0; i < shareButtonTitlesArray.count; i++)
        {
            
            UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
            shareButton.tag = self.postionIndexNumber;
            [shareButton addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
            shareButton.layer.borderWidth = 0.5;
            shareButton.layer.borderColor = [UIColor colorWithRed:203 / 255 green:203 / 255 blue:203 / 255 alpha:0.2].CGColor;
            
            [shareButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [shareButton setBackgroundImage:[UIImage imageWithColor:ButtonPressedColor] forState:UIControlStateHighlighted];
            
            [shareButton setTitle:[shareButtonTitlesArray objectAtIndex:i] forState:UIControlStateNormal];
            [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            shareButton.titleLabel.textColor = APP_FONT_COLOR_NORMAL;
            
            shareButton.layer.cornerRadius = 3;
            shareButton.layer.masksToBounds = YES;
            
            if (self.isHadTitle == YES)
            {
                [shareButton setFrame:CGRectMake(SHAREBUTTON_INTERVAL_WIDTH - 3, 50 + i * (BUTTON_HEIGHT + 10), BUTTON_WIDTH, BUTTON_HEIGHT)];
                self.ZGActionSheetHeight =  (shareButtonTitlesArray.count + 1)*(10 +BUTTON_HEIGHT) + 20;
            }
            else
            {
                [shareButton setFrame:CGRectMake(SHAREBUTTON_INTERVAL_WIDTH - 3, i * (BUTTON_HEIGHT + 10) + 30, BUTTON_WIDTH, BUTTON_HEIGHT)];
                self.ZGActionSheetHeight =  (shareButtonTitlesArray.count + 1)*(10 +BUTTON_HEIGHT) + 10;
                
            }
            [self.backGroundView addSubview:shareButton];
            
            self.postionIndexNumber++;
        }
        
    }
    
    if (cancelButtonTitle) {
        self.isHadCancelButton = YES;
        UIButton *cancelButton = [self creatCancelButtonWith:cancelButtonTitle];
        cancelButton.tag = self.postionIndexNumber;
        [cancelButton addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        //当没title destructionButton otherbuttons时
        if (self.isHadTitle == NO && self.isHadShareButton == NO) {
            self.ZGActionSheetHeight = self.ZGActionSheetHeight + cancelButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
        }
        //当有title或destructionButton或otherbuttons时
        if (self.isHadTitle == YES || self.isHadShareButton == YES) {
            [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, self.ZGActionSheetHeight, cancelButton.frame.size.width, cancelButton.frame.size.height)];
            self.ZGActionSheetHeight = self.ZGActionSheetHeight + cancelButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
        }
        [self.backGroundView addSubview:cancelButton];
        
        self.postionIndexNumber++;
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, self.frame.size.height-self.ZGActionSheetHeight, [UIScreen mainScreen].bounds.size.width, self.ZGActionSheetHeight)];
    } completion:^(BOOL finished) {
    }];
}


- (UIButton *)creatCancelButtonWith:(NSString *)cancelButtonTitle
{
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT);
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = CORNER_RADIUS;
    cancelButton.layer.borderWidth = 0.5;
    cancelButton.layer.borderColor = [UIColor colorWithRed:203 / 255 green:203 / 255 blue:203 / 255 alpha:0.2].CGColor;
    
    //    cancelButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    //    cancelButton.layer.borderColor = BUTTON_BORDER_COLOR;
    
    UIImage *image = [UIImage imageWithColor:CANCEL_BUTTON_COLOR];
    [cancelButton setBackgroundImage:image forState:UIControlStateNormal];
    
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = BUTTONTITLE_FONT;
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return cancelButton;
}

- (UIButton *)creatShareButtonWithColumn:(int)column andLine:(int)line
{
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(SHAREBUTTON_INTERVAL_WIDTH+((line-1)*(SHAREBUTTON_INTERVAL_WIDTH+SHAREBUTTON_WIDTH)), SHAREBUTTON_INTERVAL_HEIGHT+((column-1)*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT)), SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
    return shareButton;
}

- (UILabel *)creatShareLabelWithColumn:(int)column andLine:(int)line
{
    UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(SHARETITLE_INTERVAL_WIDTH+((line-1)*(SHARETITLE_INTERVAL_WIDTH+SHARETITLE_WIDTH)), SHARETITLE_INTERVAL_HEIGHT+((column-1)*(SHARETITLE_INTERVAL_HEIGHT)), SHARETITLE_WIDTH, SHARETITLE_HEIGHT)];
    
    shareLabel.backgroundColor = [UIColor clearColor];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.font = TITLE_FONT;
    shareLabel.textColor = [UIColor blackColor];
    return shareLabel;
}

- (UILabel *)creatTitleLabelWith:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_INTERVAL_WIDTH, TITLE_INTERVAL_HEIGHT, TITLE_WIDTH, TITLE_HEIGHT)];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = SHARETITLE_FONT;
    titlelabel.text = title;
    titlelabel.textColor = APP_FONT_COLOR_NORMAL;
    titlelabel.numberOfLines = TITLE_NUMBER_LINES;
    return titlelabel;
}

- (void)didClickOnImageIndex:(UIButton *)button
{
    if (self.delegate) {
        if (button.tag != self.postionIndexNumber-1) {
            if ([self.delegate respondsToSelector:@selector(didClickOnImageIndex:)] == YES) {
                [self.delegate didClickOnImageIndex:button.tag];
            }
        }
        else{
            if ([self.delegate respondsToSelector:@selector(didClickOnCancelButton)] == YES){
                [self.delegate didClickOnCancelButton];
            }
        }
    }
    [self tappedCancel];
}

- (void)tappedCancel
{
    [self dismissed];
}

- (void)dismissed
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.hidden = YES;
        }
    }];
}

- (void)tappedBackGroundView
{
    //
    
}

@end

