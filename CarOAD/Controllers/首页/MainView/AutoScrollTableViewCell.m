//
//  AutoScrollTableViewCell.m
//  CM-v1.0
//
//  Created by xf_Lian on 2017/11/10.
//  Copyright © 2017年 caroad. All rights reserved.
//

#import "AutoScrollTableViewCell.h"

@interface AutoScrollTableViewCell()

@property (nonatomic, strong) UILabel  *contentLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView   *lineView;

@end

@implementation AutoScrollTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];

    if (self) {

        [self initSubViews];

    }

    return self;

}

- (void) initSubViews {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.font          = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor     = [UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.contentLabel];

    self.lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.lineView];

    UIButton *button = [[UIButton alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:button];
    self.button = button;
    [self.button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchDown];

}

- (void) buttonEvent:(UIButton *)sender {

    [_delegate clickChankDetailsWithData:self.data];

}

- (void) layoutSubviews {

    self.contentLabel.frame = CGRectMake(0, 0, self.contentView.width - 15 *Scale_Width, self.contentView.height);

    self.lineView.frame = CGRectMake(0, self.contentView.height - 0.5f, self.contentView.frame.size.width, 0.5f);

    self.button.frame = self.contentView.bounds;

}

- (void) loadContent {
    
    NSDictionary *model = self.data;
    
    NSString *date     = model[@"publicDate"];
    NSString *userName = model[@"userName"];
    NSString *content  = model[@"timeNews"];
    
    self.contentLabel.attributedText = [self accessWithFirstString:date secondString:userName thildString:content];
    
}

#pragma mark - 给文字添加不同的color
- (NSAttributedString *) accessWithFirstString:(NSString *)firstString secondString:(NSString *)secondString thildString:(NSString *)thildString {
    NSString *totalStr = nil;
    UIFont   *font     = UIFont_13;

    totalStr = [NSString stringWithFormat:@"%@ %@ 发布需求：%@", firstString, secondString, thildString];

    NSRange totalRange  = [totalStr range];                  //  全局的区域
    NSRange secondRange = [secondString rangeFrom:totalStr]; //  %的区域
    NSRange thildRange  = [thildString rangeFrom:totalStr];  //  %的区域

    return [totalStr createAttributedStringAndConfig:@[
                                                       //   全局设置
                                                       [ConfigAttributedString font:font range:totalRange],

                                                       [ConfigAttributedString foregroundColor:TextBlackColor
                                                                                         range:totalRange],

                                                       //   局部设置
                                                       [ConfigAttributedString foregroundColor:MainColor
                                                                                         range:secondRange],

                                                       [ConfigAttributedString foregroundColor:MainColor
                                                                                         range:thildRange],

                                                       ]];
}

@end
