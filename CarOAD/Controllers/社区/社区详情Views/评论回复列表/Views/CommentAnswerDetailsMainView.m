//
//  CommentAnswerDetailsMainView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommentAnswerDetailsMainView.h"

#import "CommentAnswerDetailsCell.h"
#import "CommentAnswerListCell.h"

#import "CommunityAnswerListViewModel.h"
#import "DetailsCommunityViewModel.h"

@interface CommentAnswerDetailsMainView()<UITableViewDelegate, UITableViewDataSource, CommentAnswerListCellDelegate, UITextViewDelegate, CommentAnswerDetailsCellDelegate>
{
    
    CGFloat   keyboardHeight;
    NSString *ansewerId;
    NSString *commentId;
    NSString *message;
    BOOL      isComment;

    NSString *replyContent;
    NSString *forUserName;
    
}
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UILabel       *label;

@property (nonatomic, strong) UIView        *navBackView;
@property (nonatomic, strong) UITextView    *textView;
@property (nonatomic, strong) UILabel       *firstPlaceholderLabel;
@property (nonatomic, strong) UIView        *bottomBackView;
@property (nonatomic, strong) UIButton      *button;

@property (nonatomic, strong) NSMutableDictionary *parmes;

@end

@implementation CommentAnswerDetailsMainView

- (NSMutableArray *)datasArray {
    
    if (!_datasArray) {
        
        _datasArray = [[NSMutableArray alloc] init];
    }
    
    return _datasArray;
    
}

- (NSMutableDictionary *)parmes {
    
    if (!_parmes) {
        
        _parmes = [[NSMutableDictionary alloc] init];
    }
    
    return _parmes;
    
}

- (void)buildSubview {
    
    UIView *backView         = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    UIView *navBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.width, SafeAreaTopHeight - 44)];
    navBackView.backgroundColor = MainColor;
    [backView addSubview:navBackView];
    
    self.navBackView = navBackView;
    self.navBackView.hidden = YES;
    
    {
        
        UIView *titleBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight - 44, backView.width, 44)];
        titleBackView.backgroundColor = [UIColor whiteColor];
        [backView addSubview:titleBackView];
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(5, 0, 44, 44)
                                                buttonType:kButtonNormal
                                                     title:nil
                                                     image:[UIImage imageNamed:@"回复叉叉"]
                                                  higImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [titleBackView addSubview:button];
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"0条回复"
                                                  font:UIFont_17
                                             textColor:[UIColor blackColor]
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:100];
        [titleBackView addSubview:label];
        self.label = label;
        
        [label sizeToFit];
        label.frame = CGRectMake((titleBackView.width - label.width) / 2, (titleBackView.height - label.height) / 2, label.width, label.height);
        
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, titleBackView.height - 0.5f, titleBackView.width, 0.5f)];
        lineView.backgroundColor = LineColor;
        [titleBackView addSubview:lineView];
        
    }
    
    UITableView *tableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, backView.width, backView.height - 50 *Scale_Height - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    
    tableView.delegate       = self;
    tableView.dataSource     = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview分割线
    
    [backView addSubview:tableView];
    self.tableView = tableView;
    
    [self.tableView registerClass:[CommentAnswerDetailsCell class] forCellReuseIdentifier:@"CommentAnswerDetailsCell"];
    [self.tableView registerClass:[CommentAnswerListCell class] forCellReuseIdentifier:@"CommentAnswerListCell"];
    
    //  加载gif动画数组
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    
    footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                  refreshingAction:@selector(loadMoreData)];
    
    self.tableView.mj_footer = footer;
    
    {
        
        UIView *bottomBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, backView.height - 50 *Scale_Height - SafeAreaBottomHeight, backView.width, 50 *Scale_Height + SafeAreaBottomHeight)];
        bottomBackView.backgroundColor = [UIColor whiteColor];
        [backView addSubview:bottomBackView];
        self.bottomBackView = bottomBackView;
        
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomBackView.width, 0.5f)];
        lineView.backgroundColor = LineColor;
        [bottomBackView addSubview:lineView];

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(5, 3 *Scale_Height, 44 *Scale_Height, 44 *Scale_Height)
                                                buttonType:kButtonNormal
                                                     title:nil
                                                     image:[UIImage imageNamed:@"回复"]
                                                  higImage:nil
                                                       tag:1001
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [bottomBackView addSubview:button];
        self.button = button;
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(button.x + button.width, 10 *Scale_Height, self.width - 12 *Scale_Width - button.x - button.width, 30 *Scale_Height)];
        textView.textColor   = TextBlackColor;
        textView.font        = UIFont_15;
        textView.delegate    = self;
        textView.backgroundColor = [UIColor clearColor];
        textView.keyboardType    = UIKeyboardTypeNamePhonePad;
        textView.returnKeyType   = UIReturnKeySend;
        textView.alwaysBounceVertical = NO;
        textView.editable             = YES;
        textView.enablesReturnKeyAutomatically = YES;
        
        CGRect frame       = textView.frame;
        frame.origin.x    += 5 *Scale_Width;
        frame.size.height  = 20.f *Scale_Height;
        frame.origin.y    += 7 *Scale_Height;
        
        //  默认显示文字
        UILabel *firstPlaceholderLabel = [UILabel createLabelWithFrame:frame
                                                             labelType:kLabelNormal
                                                                  text:@"回复"
                                                                  font:UIFont_15
                                                             textColor:TextGrayColor
                                                         textAlignment:NSTextAlignmentLeft
                                                                   tag:200];
        [bottomBackView addSubview:firstPlaceholderLabel];
        self.firstPlaceholderLabel = firstPlaceholderLabel;
        
        [bottomBackView addSubview:textView];
        self.textView = textView;
        
    }
    
}

- (void)buttonEvent:(UIButton *)sender {
    
    if (sender.tag == 1000) {
        
        [_delegate clickCloseButton];
        
    } else {
        
        [self.textView becomeFirstResponder];
        commentId = @"";

    }
    
}

- (void) showNavBackView {
    
    self.navBackView.hidden = NO;
    
}

- (void) hideNavBackView {
    
    self.navBackView.hidden = YES;
    
}

- (void) hideMJ {
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

- (void) loadNewData {
    
    [_delegate loadNewData];
    
}

- (void) loadMoreData {
    
    [_delegate loadMoreData];
    
}

- (void)loadContent {
    
    DetailsCommunityViewModel *model = self.detailsData;
    
    self.label.text = [NSString stringWithFormat:@"%@条回复",model.ansNum];

    [self.label sizeToFit];

    CGRect frame = self.label.frame;
    frame.size.width = self.label.width;
    frame.origin.x   = (self.navBackView.width - self.label.width) / 2;
    self.label.frame = frame;
    
    [self.tableView reloadData];
    
}

- (void) loadFirstSectionData; {

    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];

}

- (void) clickDetailsLikeButton; {

    [_delegate clickDetailsLikeButton];

}

- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag; {

    [_delegate clickChankImageWithImageArray:array tag:tag];

}

#pragma mark -
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
        
    } else {
        
        return self.datasArray.count;
        
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        DetailsCommunityViewModel *model = self.detailsData;
        
        if (model.ansContent.length > 0) {
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:0];
            style.lineSpacing = 4;
            NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
            
            CGFloat labelHeight = [model.ansContent heightWithStringAttribute:attribute fixedWidth:Screen_Width - 64 *Scale_Width - 10];
            
            if (model.reImgURL.length > 0) {
                
                return 100 *Scale_Height + (self.width - 44 *Scale_Width) / 9 *2 + labelHeight;
                
            } else {
                
                return 90 *Scale_Height + labelHeight;
                
            }
            
        } else {
            
            if (model.reImgURL.length > 0) {
                
                return 90 *Scale_Height + (self.width - 44 *Scale_Width) / 9 *2;
                
            } else {
                
                return 0;
                
            }
            
        }
        
    } else {
        
        if (self.datasArray.count > 0) {
            
            CommunityAnswerListViewModel *model = self.datasArray[indexPath.row];
            
            if (model.ansContent.length > 0) {
                
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:0];
                style.lineSpacing = 4;
                NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
                
                CGFloat labelHeight = [model.ansContent heightWithStringAttribute:attribute fixedWidth:Screen_Width - 64 *Scale_Width];
                
                if (labelHeight > 62 *Scale_Height) {

                    if (model.isClickChackButton == YES) {


                    } else {

                        labelHeight = 62 *Scale_Height;

                    }

                    return 120 *Scale_Height + labelHeight;
                    
                } else {

                    return 90 *Scale_Height + labelHeight;

                }

            } else {
                
                return 0;
                
            }
            
        } else {
            
            return 0;
            
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    footerView.backgroundColor = [UIColor whiteColor];
    
    if (section == 0) {
        
        footerView.frame = CGRectMake(0, 0, tableView.width, 30 *Scale_Height);
        
        if (footerView.subviews) {
            
            for (UIView *subView in footerView.subviews) {
                
                [subView removeFromSuperview];
                
            }
            
        }
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"全部评论"
                                                  font:UIFont_15
                                             textColor:TextBlackColor
                                         textAlignment:NSTextAlignmentLeft
                                                   tag:100];
        [footerView addSubview:label];
        [label sizeToFit];
        label.frame = CGRectMake(12 *Scale_Width, (footerView.height - label.height) / 2 - 0.5f, label.width, 20 *Scale_Height);
        
        UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectMake(12 *Scale_Width, 0, footerView.width - 12 *Scale_Width, 1.f)];
        leftLineView.backgroundColor = TextGrayColor;
        [footerView addSubview:leftLineView];
        
    } else {
        
        footerView.frame = CGRectMake(0, 0, tableView.width, 0);
        
    }
    
    return footerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 30 *Scale_Height;
        
    } else {
        
        return 0.01;
        
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        CommentAnswerDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentAnswerDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle            = UITableViewCellSelectionStyleNone;
        cell.delegate                  = self;

        DetailsCommunityViewModel *model = self.detailsData;
        
        cell.data = model;
        [cell loadContent];
        
        return cell;
        
    } else {
        
        CommentAnswerListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentAnswerListCell" forIndexPath:indexPath];
        cell.selectionStyle         = UITableViewCellSelectionStyleNone;
        cell.delegate               = self;
        cell.tag                    = indexPath.row;
        
        if (self.datasArray.count > 0) {
            
            CommunityAnswerListViewModel *model = self.datasArray[indexPath.row];

            model.cell_row = indexPath.row;
            cell.data = model;
            [cell loadContent];
            
        }
        
        return cell;
        
    }
    
}

- (void) commentReplyWithData:(id)data; {
    
    isComment = YES;
    
    [self.textView becomeFirstResponder];
    
    CommunityAnswerListViewModel *model = data;

    commentId = model.replyId;

    forUserName = [NSString stringWithFormat:@"@%@://",model.userName];

    self.textView.text = [NSString stringWithFormat:@"@%@://",model.userName];
    
}

- (void) clickChankAllMessageWithData:(id)data; {

    CommunityAnswerListViewModel *model = data;

    if (model.isClickChackButton == YES) {

        model.isClickChackButton = NO;

    } else {

        model.isClickChackButton = YES;

    }

    [self.tableView reloadData];

}

- (void) showhideKeyboardWithKeyRect:(CGRect)keyRect duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options; {
    
    CGRect frameOfSubView   = self.bottomBackView.frame;
    frameOfSubView.origin.y = \
    self.height - keyRect.size.height - frameOfSubView.size.height;
    
    keyboardHeight = keyRect.size.height;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:options
                     animations:^{
                         
                         self.bottomBackView.frame = frameOfSubView;
                         
                     } completion:nil];
    
}

- (void) hidehideKeyboardWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options; {
    
    CGRect frameOfSubView   = self.bottomBackView.frame;
    frameOfSubView.origin.y = \
    self.height - 50 *Scale_Height;

    [UIView animateWithDuration:duration
                          delay:0
                        options:options
                     animations:^{
                         
                         self.bottomBackView.frame = frameOfSubView;
                         
                     } completion:nil];
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;{

    [self.parmes removeAllObjects];

    [self.firstPlaceholderLabel setHidden:YES];

    if (isComment == NO) {
        
        commentId = @"";
        
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;{

    textView.text = @"";

    [self.firstPlaceholderLabel setHidden:NO];
    
    [textView resignFirstResponder];
    
    isComment = NO;
    
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
    
    [self heightOfBackViewWithTextView:textView text:textView.text];
    
}

- (void) textViewDidChangeSelection:(UITextView *)textView;{
    
    
    
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text rangeOfString:@"\n"].location != NSNotFound) {

        message = textView.text;

        if (isComment == YES) {

            message = [textView.text substringWithRange:NSMakeRange(forUserName.length,textView.text.length - forUserName.length)];
            [self.parmes setObject:commentId forKey:@"commentId"];
        }
        
        DetailsCommunityViewModel *model = self.detailsData;
        
        [self.parmes setObject:model.answerId forKey:@"answerId"];
        [self.parmes setObject:message forKey:@"replyInfo"];
        
        [_delegate publishCommentWithData:self.parmes isComment:isComment];
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}

#pragma mark - UITextViewDelegate
- (void) heightOfBackViewWithTextView:(UITextView *)textView text:(NSString *)text {
    
    //  textView的frame
    CGRect frame = textView.frame;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    style.lineSpacing              = 4;
    NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
    
    CGFloat labelHeight = [textView.text heightWithStringAttribute:attribute fixedWidth:textView.width - 10];
    
    //  对是否有高亮文字进行处理
    NSString *toBeString = textView.text;
    NSString *lang = [(UITextInputMode*)[[UITextInputMode activeInputModes] firstObject] primaryLanguage]; // 键盘输入模式
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        
        UITextRange *selectedRange = [textView markedTextRange];
        
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        if (!position) {
            
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (labelHeight > 62 *Scale_Height) {
                
                frame.size.height      = 81.7 *Scale_Height;
                textView.scrollEnabled = YES;
                
            } else if (labelHeight <= 22 *Scale_Height) {
                
                frame.size.height      = 30 *Scale_Height;
                textView.scrollEnabled = NO;
                
            } else {
                
                frame.size.height      = labelHeight + 20 *Scale_Height;
                textView.scrollEnabled = NO;
                
            }
            
            //  重写textView的frame
            textView.frame = frame;
            
            textView.attributedText = [[NSAttributedString alloc] initWithString:toBeString attributes:attribute];
            
        } else {
            
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            
        }
        
    } else{
        
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (labelHeight > 62 *Scale_Height) {
            
            frame.size.height      = 81.7 *Scale_Height;
            textView.scrollEnabled = YES;
            
        } else if (labelHeight <= 22 *Scale_Height) {
            
            frame.size.height      = 30 *Scale_Height;
            textView.scrollEnabled = NO;
            
        } else {
            
            frame.size.height      = labelHeight + 20 *Scale_Height;
            textView.scrollEnabled = NO;
            
        }
        
        //  重写textView的frame
        textView.frame = frame;
        
        textView.attributedText = [[NSAttributedString alloc] initWithString:toBeString attributes:attribute];
        
    }
    
    CGRect bottomBackViewRect      = self.bottomBackView.frame;
    bottomBackViewRect.origin.y    = self.height - keyboardHeight - frame.size.height - 20 *Scale_Height;
    bottomBackViewRect.size.height = frame.size.height + 20 *Scale_Height;
    
    self.bottomBackView.frame = bottomBackViewRect;
    
    CGRect buttonFrame = self.button.frame;
    buttonFrame.origin.y = self.bottomBackView.height - 47 *Scale_Height;
    self.button.frame = buttonFrame;
    
}

@end
