//
//  SearchRecruitListView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "SearchRecruitListView.h"

#import "SearchRecruitListCell.h"

@interface SearchRecruitListView()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{

    NSArray *datasArray;

}
@property (nonatomic, strong) UIWindow *windows;
@property (nonatomic, strong) UIView   *backView;
@property (nonatomic, strong) UIView   *maskView;
@property (nonatomic, strong) UIView   *navTitleView;
@property (nonatomic, strong) UIView   *searchBackView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton    *search_delete_button;

@property (nonatomic, assign) CGRect startRect;
@property (nonatomic, assign) CGRect endRect;

@end

@implementation SearchRecruitListView

- (void)buildView {

    //  获取目前页面窗口
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    self.windows      = windows;

    //  创建背景view
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windows.width,  windows.height)];

    //  创建容器view
    UIView *maskView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.width,  backView.height)];
    maskView.backgroundColor = [UIColor grayColor];
    maskView.alpha           = 0.6f;
    [backView addSubview:maskView];
    self.maskView = maskView;

    {

        UIButton *button = [UIButton createButtonWithFrame:maskView.bounds
                                                     title:nil
                                           backgroundImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [maskView addSubview:button];

    }
    
    UIView *navTitleView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.width,  SafeAreaTopHeight)];
    navTitleView.backgroundColor = MainColor;
    [backView addSubview:navTitleView];
    self.navTitleView = navTitleView;

    {

        UIView *searchBackView             = [[UIView alloc] initWithFrame:CGRectMake(12, SafeAreaTopHeight - 37, backView.width - 24, 30)];
        searchBackView.backgroundColor     = [UIColor whiteColor];
        searchBackView.layer.masksToBounds = YES;
        searchBackView.layer.cornerRadius  = searchBackView.height / 2;
        [navTitleView addSubview:searchBackView];
        self.searchBackView = searchBackView;
        self.endRect = searchBackView.frame;

        {

            UIButton *button = [UIButton createButtonWithFrame:CGRectMake(searchBackView.width - 30, 0, searchBackView.height, searchBackView.height)
                                                    buttonType:kButtonNormal
                                                         title:nil
                                                         image:[UIImage imageNamed:@"search_delete"]
                                                      higImage:nil
                                                           tag:1001
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            [searchBackView addSubview:button];
            self.search_delete_button = button;
            self.search_delete_button.hidden = YES;

        }

        {

            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, searchBackView.width - 60, searchBackView.height)];
            textField.delegate      = self;
            textField.font          = UIFont_15;
            textField.textColor     = TextBlackColor;
            textField.textAlignment = NSTextAlignmentLeft;
            textField.returnKeyType = UIReturnKeySearch;
            textField.placeholder   = @"请输入关键字";
            textField.backgroundColor = [UIColor whiteColor];
            textField.keyboardType = UIKeyboardTypeDefault;
            [searchBackView addSubview:textField];
            self.textField = textField;

        }

        CGRect frame     = searchBackView.frame;
        frame.origin.x   = backView.width - 42;
        frame.size.width = 30;
        searchBackView.frame = frame;
        self.startRect = frame;

        {

            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 16, 16)];
            imageView.image        = [UIImage imageNamed:@"Search_gray"];
            imageView.contentMode  = UIViewContentModeScaleAspectFit;
            imageView.backgroundColor = [UIColor whiteColor];
            [searchBackView addSubview:imageView];

        }

    }

    UITableView *tableView    = [[UITableView alloc] initWithFrame:CGRectMake(0, navTitleView.height, backView.width, 0) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    tableView.tag             = 100;
    [backView addSubview:tableView];
    self.tableView = tableView;

    [tableView registerClass:[SearchRecruitListCell class] forCellReuseIdentifier:@"SearchRecruitListCell"];

    [windows addSubview:backView];
    self.backView = backView;
    self.backView.alpha = 0.f;

}

- (void) show; {

    [self buildView];

    self.backView.alpha = 1.f;

    [UIView animateWithDuration:0.3f animations:^{

        self.searchBackView.frame = self.endRect;

    } completion:^(BOOL finished) {

        NSString *path     = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [path stringByAppendingPathComponent:@"searchRecruitListText.plist"];

        NSArray *result = [NSArray arrayWithContentsOfFile:fileName];
        datasArray = [result copy];

        [self.tableView reloadData];

        CGRect frame = self.tableView.frame;

        if ((datasArray.count + 1) *40 *Scale_Height > self.backView.height - self.navTitleView.height - 200) {

            frame.size.height = self.backView.height - self.navTitleView.height - 200;

        } else {

            frame.size.height = (datasArray.count + 1) *40 *Scale_Height;

        }

        [UIView animateWithDuration:0.3f animations:^{

            self.tableView.frame = frame;

        } completion:^(BOOL finished) {



        }];

    }];

}

- (void) hide; {

    CGRect frame      = self.tableView.frame;
    frame.size.height = 0;

    [UIView animateWithDuration:0.3f animations:^{

        self.tableView.frame      = frame;
        self.searchBackView.frame = self.startRect;

    } completion:^(BOOL finished) {

        [UIView animateWithDuration:0.3f animations:^{

            self.backView.alpha = 0.f;

        }];

        for (UIView *view in self.backView.subviews) {

            [view removeFromSuperview];

        }

        [self.backView removeFromSuperview];

    }];

}

#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 40 *Scale_Height;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *backView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40 *Scale_Height)];
    backView.backgroundColor = BackGrayColor;

    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, 0, backView.width, backView.height)
                                                 title:@"删除历史搜索记录"
                                       backgroundImage:nil
                                                   tag:1002
                                                target:self
                                                action:@selector(buttonEvent:)];
    button.titleLabel.font = UIFont_16;
    [button setTitleColor:MainColor forState:UIControlStateNormal];
    [backView addSubview:button];

    return backView;

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        [self hide];

    } else if (sender.tag == 1001) {

        [self.textField resignFirstResponder];

    }  else if (sender.tag == 1002) {
        
        NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
        NSArray        *array        = [tmpDataArray copy];
        
        //  保存数据到本地
        NSString *path     = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [path stringByAppendingPathComponent:@"searchRecruitListText.plist"];
        
        [array writeToFile:fileName atomically:YES];

        datasArray = [array copy];

        [self.tableView reloadData];

    }

}

#pragma mark - UITableViewDataSource
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;

}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return datasArray.count;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40 *Scale_Height;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SearchRecruitListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchRecruitListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (datasArray.count > 0) {

        cell.data = datasArray[indexPath.row];
        [cell loadContent];

    }
    return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.textField resignFirstResponder];
    [self hide];

    NSString *text = datasArray[indexPath.row];
    [_delegate searchRecruitListWithText:text];

}

#pragma mark - textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    self.search_delete_button.hidden = NO;

    return YES;

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    self.search_delete_button.hidden = YES;

    return YES;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {


}

- (void)textFieldDidEndEditing:(UITextField *)textField {



}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    //  限制输入字数
    if ([string rangeOfString:@"\n"].location != NSNotFound) {

        [textField resignFirstResponder];

        return NO;

    }

    return YES;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    BOOL isHaveText = NO;

    for (NSString *text in datasArray) {
        
        if ([text isEqualToString:textField.text]) {

            isHaveText = YES;

        }

    }

    if (isHaveText == NO) {

        NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
        for (NSString *text in datasArray) {

            [tmpDataArray addObject:text];

        }

        if (textField.text.length > 0) {

            [tmpDataArray addObject:textField.text];

        }

        NSArray *array = [tmpDataArray copy];

        //  保存数据到本地
        NSString *path     = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [path stringByAppendingPathComponent:@"searchRecruitListText.plist"];

        [array writeToFile:fileName atomically:YES];

    }

    [textField resignFirstResponder];

    [self hide];

    [_delegate searchRecruitListWithText:textField.text];

    return YES;

}

@end
