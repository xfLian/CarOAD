//
//  PublishArticleMainView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "PublishArticleMainView.h"

#import "UIWebView+AccessoryHiding.h"
#import "ManagePublishArticleText.h"

#import "ArticleHtmlFile.h"
#import "ArticleEdiTextContentView.h"

#define Button_Width     (self.width - 69 *Scale_Width) / 4
#define Button_Height    30 *Scale_Height
#define Add_Button_Width (self.width - 54 *Scale_Width) / 3

@interface PublishArticleMainView()<UIScrollViewDelegate, UITextViewDelegate, ArticleEdiTextContentViewDelegate>
{

    NSInteger  view_tag;
    NSArray   *imagesArray;
    CGFloat    title_font;
    NSInteger  cell_tag;

}

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSMutableArray *chooseTypeButtonArray;
@property (nonatomic, strong) NSMutableArray *articleContentDatasArray;
@property (nonatomic, strong) NSMutableArray *articleContentViewsArray;

@property (nonatomic, strong) UIScrollView   *scrollView;
@property (nonatomic, strong) UIView         *iconBackView;
@property (nonatomic, strong) UIView         *contentBackView;
@property (nonatomic, strong) UIView         *titleBackView;
@property (nonatomic, strong) UIView         *accessoryView;
@property (nonatomic, strong) ArticleEdiTextContentView   *ediTextView;

@property (nonatomic, strong) UIImage        *title_image;
@property (nonatomic, strong) UIImageView    *imageView;
@property (nonatomic, strong) UITextView     *textView;
@property (nonatomic, strong) UITableView    *tableView;

@property (nonatomic, strong) NSDictionary   *attributes;
@property (nonatomic, strong) UILabel        *firstPlaceholderLabel;

@property (nonatomic, strong) UIButton       *addButton;
@property (nonatomic, strong) UIView         *imageBackView;

@end

@implementation PublishArticleMainView

- (NSMutableArray *)buttonArray {

    if (!_buttonArray) {

        _buttonArray = [[NSMutableArray alloc] init];

    }

    return _buttonArray;

}

-(NSMutableArray *)chooseTypeButtonArray {

    if (!_chooseTypeButtonArray) {

        _chooseTypeButtonArray = [[NSMutableArray alloc] init];

    }

    return _chooseTypeButtonArray;

}

- (NSMutableArray *)articleContentDatasArray {

    if (!_articleContentDatasArray) {

        _articleContentDatasArray = [[NSMutableArray alloc] init];

    }

    return _articleContentDatasArray;

}

- (NSMutableArray *)articleContentViewsArray {

    if (!_articleContentViewsArray) {

        _articleContentViewsArray = [[NSMutableArray alloc] init];

    }

    return _articleContentViewsArray;

}

- (void)buildsubview {

    self.backgroundColor = BackGrayColor;

    UIScrollView *scrollView   = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.height - 50 *Scale_Height - SafeAreaBottomHeight)];
    scrollView.backgroundColor = BackGrayColor;
    scrollView.delegate        = self;
    scrollView.keyboardDismissMode = NO;
    scrollView.pagingEnabled    = YES;
    scrollView.scrollEnabled    = YES;
    [self addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    self.scrollView = scrollView;

    UIView *buttonBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 90 *Scale_Height)];
    buttonBackView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:buttonBackView];
    
    if (self.buttonTitleArray.count > 4) {

        buttonBackView.frame = CGRectMake(0, 0, self.width, 90 *Scale_Height);

    } else {

        buttonBackView.frame = CGRectMake(0, 0, self.width, 50 *Scale_Height);

    }

    for (int i = 0; i < self.buttonTitleArray.count; i++) {

        NSInteger x = i % 4;
        NSInteger y = i / 4;

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(12 *Scale_Width + (Button_Width + 15 *Scale_Width) *x, 11 *Scale_Height + 39 *Scale_Height *y, Button_Width, 28 *Scale_Height)
                                                     title:self.buttonTitleArray[i]
                                           backgroundImage:nil
                                                       tag:1000 + i
                                                    target:self
                                                    action:@selector(buttonEvent:)];

        [buttonBackView addSubview:button];

        [self.buttonArray addObject:button];

        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13.f *Scale_Width];

        [button setTitleColor:TextBlackColor forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateSelected];
        button.layer.masksToBounds = YES;
        button.layer.borderWidth   = 0.7f;
        button.layer.cornerRadius  = 5 *Scale_Width;
        button.layer.borderColor   = TextGrayColor.CGColor;

        if (i == 0) {

            button.selected = YES;
            button.layer.borderColor = MainColor.CGColor;

        }

    }

    view_tag = 0;

    //  选择封面图
    {

        UIImage *image = [UIImage imageNamed:@"上传封面图"];

        UIView *iconBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, buttonBackView.height + 10 *Scale_Height, self.width, (self.width - 24 *Scale_Width) * image.size.height / image.size.width + 20 *Scale_Height)];
        iconBackView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:iconBackView];
        
        UIImageView *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(12 *Scale_Width, 10 *Scale_Height, iconBackView.width - 24 *Scale_Width,  iconBackView.height - 20 *Scale_Height)];
        imageView.image         = image;
        imageView.contentMode   = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [iconBackView addSubview:imageView];
        self.imageView = imageView;

        UIButton *button = [UIButton createButtonWithFrame:iconBackView.bounds
                                                     title:nil
                                           backgroundImage:nil
                                                       tag:2000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [iconBackView addSubview:button];
        self.iconBackView = iconBackView;

    }

    //  标题栏
    {

        UIView *titleBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.iconBackView.y + self.iconBackView.height + 10 *Scale_Height, scrollView.width, 60 *Scale_Height)];
        titleBackView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:titleBackView];
        self.titleBackView = titleBackView;
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(12 *Scale_Width, 10 *Scale_Height, self.width - 24 *Scale_Width, 40 *Scale_Height)];
        textView.textColor   = TextBlackColor;
        textView.delegate    = self;
        textView.backgroundColor = [UIColor clearColor];
        textView.keyboardType    = UIKeyboardTypeDefault;
        textView.returnKeyType   = UIReturnKeyDone;
        textView.alwaysBounceVertical = NO;
        textView.editable        = YES;
        textView.textAlignment   = NSTextAlignmentLeft;
        textView.scrollEnabled   = NO;
        textView.font            = [UIFont boldSystemFontOfSize:24];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 6;
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName:style};

        CGRect frame       = textView.frame;
        frame.origin.x    += 5 *Scale_Width;
        frame.size.height  = 30.f *Scale_Height;
        frame.origin.y    += 7 *Scale_Height;

        //  默认显示文字
        UILabel *firstPlaceholderLabel = [UILabel createLabelWithFrame:frame
                                                             labelType:kLabelNormal
                                                                  text:@"请输入文章标题 50字以内"
                                                                  font:[UIFont boldSystemFontOfSize:24]
                                                             textColor:TextGrayColor
                                                         textAlignment:NSTextAlignmentLeft
                                                                   tag:200];
        firstPlaceholderLabel.attributedText = [[NSAttributedString alloc] initWithString:@"请输入文章标题 50字以内" attributes:attribute];
        [titleBackView addSubview:firstPlaceholderLabel];
        self.firstPlaceholderLabel = firstPlaceholderLabel;

        [titleBackView addSubview:textView];
        self.textView = textView;

    }

    //  正文输入框
    {

        self.ediTextView = [[ArticleEdiTextContentView alloc] initWithFrame:CGRectMake(0, self.titleBackView.y + self.titleBackView.height + 10 *Scale_Height, scrollView.width, scrollView.height - (self.titleBackView.y + self.titleBackView.height + 10 *Scale_Height))];
        self.ediTextView.delegate = self;
        [scrollView addSubview:self.ediTextView];

    }

    scrollView.contentSize = CGSizeMake(scrollView.width, self.ediTextView.y + self.ediTextView.height);

    UIView *bottomBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 50 *Scale_Height - SafeAreaBottomHeight, self.width, 50 *Scale_Height + SafeAreaBottomHeight)];
    bottomBackView.backgroundColor = MainColor;
    [self addSubview:bottomBackView];
    
    //  创建发布按钮
    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, 0, self.width, 50 *Scale_Width)
                                                 title:@"发布"
                                       backgroundImage:nil
                                                   tag:5000
                                                target:self
                                                action:@selector(buttonEvent:)];

    button.backgroundColor = MainColor;
    button.titleLabel.font = UIFont_17;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBackView addSubview:button];

    //  创建键盘头选择输入类型页面
    {
        
        UIView *accessoryView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, Screen_Width, 50 *Scale_Height)];
        accessoryView.backgroundColor = CarOadColor(249, 233, 200);

        NSArray *titleArray = @[@"标题",@"居中",@"列表",@"粗体",@"引用",@"照片"];
        NSArray *imageArray = @[@"标题",@"居中",@"列表",@"粗体",@"引用",@"照片"];

        for (int i = 0; i < 6; i++) {

            UIButton *button = [UIButton createWithTopAndButtomButtonWithFrame:CGRectMake(Screen_Width / 6 * i, 0, Screen_Width / 6, accessoryView.height)
                                                                         title:titleArray[i]
                                                                         image:[UIImage imageNamed:imageArray[i]]
                                                                           tag:6000 + i
                                                                        target:self
                                                                        action:@selector(buttonEvent:)];
            [accessoryView addSubview:button];

            [button setTitleColor:CarOadColor(198, 153, 94) forState:UIControlStateNormal];
            [button setTitleColor:CarOadColor(215, 177, 132) forState:UIControlStateDisabled];
            [self.chooseTypeButtonArray addObject:button];

        }

        [self addSubview:accessoryView];
        self.accessoryView = accessoryView;

        for (int i = 0; i < 5; i++) {

            UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(Screen_Width / 6 * (i + 1) - 0.5f, 10 *Scale_Height, 1.f, accessoryView.height - 20 *Scale_Height)];
            lineView.backgroundColor = CarOadColor(198, 153, 94);
            [accessoryView addSubview:lineView];

        }

    }

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag >= 1000 && sender.tag < 2000) {

        //  选项卡按钮点击方法
        for (UIButton *button in self.buttonArray) {

            button.selected = NO;
            button.layer.borderColor = TextGrayColor.CGColor;

        }

        sender.selected = YES;
        sender.layer.borderColor = MainColor.CGColor;

        [_delegate chooseTypeWithTag:sender.tag - 1000];

    } else if (sender.tag >= 2000 && sender.tag < 3000) {

        //  添加图片
        [_delegate addTitleImageView];

    } else if (sender.tag >= 3000 && sender.tag < 4000) {

        //  点击图片预览


    } else if (sender.tag >= 4000 && sender.tag < 5000) {



    } else if (sender.tag >= 5000 && sender.tag < 6000) {

        //  点击发布
        NSDictionary *contentData = [self.ediTextView getTextContent];

        //  内容数组
        NSArray *contentArray = [contentData valueForKey:@"Content"];

        //  内容图片数组
        NSArray *imagesArray = [contentData valueForKey:@"Images"];

        [_delegate publishArticleWithTitle:self.textView.text titleImage:self.title_image contentArray:contentArray imagesArray:imagesArray];

    } else if (sender.tag >= 6000 && sender.tag < 7000) {

        if (sender.tag == 6000) {

            if (sender.selected == YES) {

                sender.selected = NO;

            } else {

                sender.selected = YES;

            }

            [self.ediTextView isMaxFont:sender.selected];

        } else if (sender.tag == 6001) {

            if (sender.selected == YES) {

                sender.selected = NO;

            } else {

                sender.selected = YES;

            }

            [self.ediTextView isCentre:sender.selected];

        } else if (sender.tag == 6002) {

            if (sender.selected == YES) {

                sender.selected = NO;

            } else {

                sender.selected = YES;

            }

            [self.ediTextView isAddList:sender.selected];

        } else if (sender.tag == 6003) {

            if (sender.selected == YES) {

                sender.selected = NO;

            } else {

                sender.selected = YES;

            }

            [self.ediTextView isBold:sender.selected];

        } else if (sender.tag == 6004) {

            for (UIButton *button in self.chooseTypeButtonArray) {

                if (button.tag != 6001) {

                    button.selected = NO;

                }

            }

            [self.ediTextView isAddList:NO];
            [self.ediTextView isMaxFont:NO];
            [self.ediTextView isBold:NO];

            [self.ediTextView isAddParagraph];

        } else if (sender.tag == 6005) {

            for (UIButton *button in self.chooseTypeButtonArray) {

                if (button.tag != 6001) {

                    button.selected = NO;

                }

            }

            [self.ediTextView isAddList:NO];
            [self.ediTextView isMaxFont:NO];
            [self.ediTextView isBold:NO];

            //  选择图片
            [_delegate addTextViewImage];

        }

    }

}

- (void) changeViewHeight:(CGFloat)height; {

    CGRect frame           = self.ediTextView.frame;
    frame.size.height      = height;
    self.ediTextView.frame = frame;

    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, self.ediTextView.y + self.ediTextView.height);

    CGFloat offset = self.scrollView.contentSize.height - self.scrollView.bounds.size.height;
    if (offset > 0)
    {
        [self.scrollView setContentOffset:CGPointMake(0, offset) animated:YES];
    }

}

- (void) addTitleImageWithImage:(UIImage *)image; {

    self.imageView.image = image;
    self.title_image     = image;

}

- (void) addImageForTextViewWithImage:(UIImage *)image; {

    [self.ediTextView addImageForTextViewWithImage:image];

}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;{
    
    for (UIButton *button in self.chooseTypeButtonArray) {

        button.enabled = NO;

    }

    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;{

    for (UIButton *button in self.chooseTypeButtonArray) {

        button.enabled = YES;

    }

    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView;{

}

- (void)textViewDidEndEditing:(UITextView *)textView;{

}

- (void) textViewDidChange:(UITextView *)textView;{

    if (textView.text.length == 0) {

        [self.firstPlaceholderLabel setHidden:NO];

    } else {

        [self.firstPlaceholderLabel setHidden:YES];

    }

    [ManagePublishArticleText getTitleTextViewHeightWithTextView:self.textView finish:^(CGFloat view_height) {

        CGRect textBackViewRect      = self.titleBackView.frame;
        textBackViewRect.size.height = view_height + 20 *Scale_Height;
        self.titleBackView.frame     = textBackViewRect;

        CGRect webViewRect      = self.ediTextView.frame;
        webViewRect.origin.y    = textBackViewRect.origin.y + textBackViewRect.size.height + 10 *Scale_Height;
        webViewRect.size.height = 500 *Scale_Height;
        self.ediTextView.frame  = webViewRect;

        self.scrollView.contentSize = CGSizeMake(self.scrollView.width, webViewRect.origin.y + webViewRect.size.height);

    } maxTextNumber:^(BOOL isOverstepMaxTextNumber) {

        CarOadLog(@"isOverstepMaxTextNumber --- %d",isOverstepMaxTextNumber);

    }];

}

- (void) textViewDidChangeSelection:(UITextView *)textView;{



}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text rangeOfString:@"\n"].location != NSNotFound) {

        [textView resignFirstResponder];

        return NO;

    }

    return YES;

}

#pragma mark - 键盘通知
- (void) showhideKeyboardWithKeyRect:(CGRect)keyRect duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options; {

    CGRect frameOfSubView      = self.scrollView.frame;
    frameOfSubView.size.height = self.height - keyRect.size.height - 50 *Scale_Height;

    CGRect frame   = self.accessoryView.frame;
    frame.origin.y = self.height - keyRect.size.height - 50 *Scale_Height;

    [UIView animateWithDuration:duration
                          delay:0
                        options:options
                     animations:^{

                         self.accessoryView.frame = frame;
                         self.scrollView.frame    = frameOfSubView;

                     } completion:nil];

    CGFloat offset = self.scrollView.contentSize.height - self.scrollView.bounds.size.height;
    if (offset > 0)
    {
        [self.scrollView setContentOffset:CGPointMake(0, offset) animated:YES];
    }

}

- (void) hidehideKeyboardWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options; {

    CGRect frameOfSubView      = self.scrollView.frame;
    frameOfSubView.size.height = self.height - 50 *Scale_Height;

    CGRect frame   = self.accessoryView.frame;
    frame.origin.y = self.height;

    [UIView animateWithDuration:duration
                          delay:0
                        options:options
                     animations:^{

                         self.accessoryView.frame = frame;
                         self.scrollView.frame    = frameOfSubView;

                     } completion:nil];

}

#pragma mark - UIScrollViewDelegate
- (UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView{

    return nil;

}

@end
