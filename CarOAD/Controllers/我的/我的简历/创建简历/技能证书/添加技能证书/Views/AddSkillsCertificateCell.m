//
//  AddSkillsCertificateCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AddSkillsCertificateCell.h"

@interface AddSkillsCertificateCell()
{
    
    NSInteger  view_tag;
    NSArray   *imagesArray;
    
}
@property (nonatomic, strong) QTCheckImageScrollView *checkImageScrollView;
@property (nonatomic, strong) NSMutableArray         *imageMutableArray;

@property (nonatomic, strong) UILabel  *typeLabel;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIView   *lineView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView   *imageBackView;

@end

@implementation AddSkillsCertificateCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.typeLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@"*"
                                              font:UIFont_15
                                         textColor:CarOadColor(210, 33, 33)
                                     textAlignment:NSTextAlignmentLeft
                                               tag:100];
    [self.contentView addSubview:self.typeLabel];
    
    [self.typeLabel sizeToFit];
    self.typeLabel.frame = CGRectMake(15 *Scale_Width, (40 *Scale_Height - self.typeLabel.height) / 2, self.typeLabel.width, self.typeLabel.height);
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_16
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(self.typeLabel.x + self.typeLabel.width + 5 *Scale_Width, 0, Screen_Width - (self.typeLabel.x + self.typeLabel.width + 20 *Scale_Width), 40 *Scale_Height);

    UIView *imageBackView = [[UIView alloc] initWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.y + self.titleLabel.height, Screen_Width - self.titleLabel.x *2, (Screen_Width - self.titleLabel.x *2 - 20 *Scale_Width) / 3)];
    imageBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:imageBackView];
    self.imageBackView = imageBackView;
    
}

- (void) addImageForContentViewWithImageArray:(NSArray *)imageArray {
    
    imagesArray = [imageArray mutableCopy];
    
    for (UIView *subView in self.imageBackView.subviews) {
        
        [subView removeFromSuperview];
        
    }
    
    CGRect frame      = CGRectZero;
    frame.size.width  = (Screen_Width - self.titleLabel.x *2 - 20 *Scale_Width) / 3;
    frame.size.height = (Screen_Width - self.titleLabel.x *2 - 20 *Scale_Width) / 3;
    
    for (int i = 0; i < imageArray.count; i++) {
        
        if (i < 3) {
            
            frame.origin.x = (frame.size.width + 10 *Scale_Height) *i;
            frame.origin.y = 0;
            
        } else if (i >= 3 && i < 6) {
            
            frame.origin.x = (frame.size.width + 10 *Scale_Height) *(i - 3);
            frame.origin.y = frame.size.height + 10 *Scale_Height;
            
        } else {
            
            frame.origin.x = (frame.size.width + 10 *Scale_Height) *(i - 6);
            frame.origin.y = (frame.size.height + 10 *Scale_Height) *2;
            
        }
        
        NSString *imageString = imageArray[i];
        
        UIView *imageView = [self createImageViewWithFrame:frame imageString:imageString tag:i + 3000];
        [self.imageBackView addSubview:imageView];
        
        self.checkImageScrollView.imagesArray = [imageArray copy];
        
    }
    
    {
        
        if (imageArray.count < 3) {
            
            CGRect buttonRect      = CGRectZero;
            buttonRect.size.width  = frame.size.width - 10 *Scale_Height;
            buttonRect.size.height = frame.size.width - 10 *Scale_Height;
            
            buttonRect.origin.x = (frame.size.height + 10 *Scale_Height) *imageArray.count;
            buttonRect.origin.y = 10 *Scale_Height;
            
            UIButton *button = [UIButton createButtonWithFrame:buttonRect
                                                         title:nil
                                               backgroundImage:[UIImage imageNamed:@"添加照片"]
                                                           tag:2000
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            
            button.backgroundColor = MainColor;
            
            [self.imageBackView addSubview:button];
            
        }
        
    }
    
}

- (UIView *) createImageViewWithFrame:(CGRect)frame imageString:(NSString *)imageString tag:(NSInteger)tag {
    
    UIView *imageBackView         = [[UIView alloc] initWithFrame:frame];
    imageBackView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10 *Scale_Width, frame.size.width - 10 *Scale_Width, frame.size.width - 10 *Scale_Width)];
    imageView.contentMode  = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageBackView addSubview:imageView];
    
    [QTDownloadWebImage downloadImageForImageView:imageView
                                         imageUrl:[NSURL URLWithString:imageString]
                                 placeholderImage:@"contact_off_gray"
                                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                             
                                         }
                                          success:^(UIImage *finishImage) {
                                              
                                          }];
    
    UIButton *button = [UIButton createButtonWithFrame:imageBackView.bounds
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:tag
                                                target:self
                                                action:@selector(buttonEvent:)];
    [imageBackView addSubview:button];
    
    UIButton *deleteButton = [UIButton createButtonWithFrame:CGRectMake(frame.size.width - 20 *Scale_Width, 0, 20 *Scale_Width, 20 *Scale_Width)
                                                       title:nil
                                             backgroundImage:[UIImage imageNamed:@"4张照片-删除"]
                                                         tag:tag + 1000
                                                      target:self
                                                      action:@selector(buttonEvent:)];
    [imageBackView addSubview:deleteButton];
    
    return imageBackView;
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    if (sender.tag == 2000) {
        
        //  添加图片
        NSDictionary *model   = self.data;
        NSString     *content = model[@"content"];
        
        if (content.length > 0) {
            
            NSArray *imageStringArray = [content componentsSeparatedByString:@","];
            [self.delegate addImageWithImageStringArray:imageStringArray];
            
        } else {
            
            [self.delegate addImageWithImageStringArray:nil];
            
        }
        
    } else if (sender.tag >= 3000 && sender.tag < 4000) {
        
        //  点击图片预览
        [self.checkImageScrollView showwithTag:sender.tag - 3000];
        
    } else if (sender.tag >= 4000 && sender.tag < 5000) {
        
        //  删除图片
        NSMutableArray *imageStringMutabArray = [NSMutableArray array];
        NSDictionary *model           = self.data;
        NSString     *content         = model[@"content"];
        NSArray *imageStringArray = [content componentsSeparatedByString:@","];
        for (NSString *imageString in imageStringArray) {
            
            [imageStringMutabArray addObject:imageString];
            
        }
        
        [imageStringMutabArray removeObjectAtIndex:sender.tag - 4000];
        [self.delegate deleteImageWithImageStringArray:imageStringMutabArray];
        
    }
    
}

- (void) loadContent; {
    
    NSDictionary *model           = self.data;
    NSString     *title           = model[@"title"];
    NSString     *content         = model[@"content"];
    NSString     *isHideTypeLabel = model[@"isHideTypeLabel"];
    
    if (isHideTypeLabel.length > 0 && [isHideTypeLabel integerValue] == 1) {
        
        self.typeLabel.hidden = YES;
        
    } else {
        
        self.typeLabel.hidden = NO;
        
    }
    
    if (title.length > 0) {
        
        self.titleLabel.text = title;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (content.length > 0) {
        
        NSArray *imageStringArray = [content componentsSeparatedByString:@","];
        
        [self addImageForContentViewWithImageArray:imageStringArray];
        
    } else {
        
        [self addImageForContentViewWithImageArray:nil];
        
    }
    
}

@end
