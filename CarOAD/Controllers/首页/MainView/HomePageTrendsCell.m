//
//  HomePageTrendsCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/11/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "HomePageTrendsCell.h"

#import "AutoScrollTableViewCell.h"

@interface HomePageTrendsCell()<UITableViewDelegate, UITableViewDataSource, AutoScrollTableViewCellDelegate>

@property (nonatomic, strong) UITableView   *autoScrollTableView;
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (assign, nonatomic) int count;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSArray        *autoScrollData;

@end

@implementation HomePageTrendsCell

- (NSMutableArray *)dataArray {

    if (!_dataArray) {

        _dataArray = [[NSMutableArray alloc] init];
    }

    return _dataArray;

}

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.autoScrollTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.autoScrollTableView.backgroundColor = [UIColor clearColor];
    self.autoScrollTableView.delegate        = self;
    self.autoScrollTableView.dataSource      = self;
    self.autoScrollTableView.showsHorizontalScrollIndicator = NO;
    self.autoScrollTableView.showsVerticalScrollIndicator   = NO;
    self.autoScrollTableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview分割线
    [self.contentView addSubview:self.autoScrollTableView];
    self.autoScrollTableView.scrollEnabled = NO;
    [self.autoScrollTableView setContentOffset:CGPointMake(0, 0) animated:YES];

    [self.autoScrollTableView registerClass:[AutoScrollTableViewCell class] forCellReuseIdentifier:@"AutoScrollTableViewCell"];

}

- (void) layoutSubviews {

    self.autoScrollTableView.frame = CGRectMake(15 *Scale_Width, 0, self.contentView.width - 15 *Scale_Width, self.contentView.height);

}

- (void) loadContent {

    NSArray *autoScrollDataArray = self.data;
    
    if (autoScrollDataArray.count > 10) {
        
        NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 10; i++) {
            
            NSDictionary *model = autoScrollDataArray[i];
            
            [tmpDataArray addObject:model];
            
        }
        
        self.autoScrollData = [tmpDataArray copy];
        
    } else {
        
        self.autoScrollData = [autoScrollDataArray copy];
        
    }
    
    if (self.dataArray.count > 0) {
        
        [self.dataArray removeAllObjects];
        
    }
    
    for (int i = 0; i < self.autoScrollData.count *2; i++) {
        
        if (i < self.autoScrollData.count) {
            
            NSDictionary *data = self.autoScrollData[i];
            
            [self.dataArray addObject:data];
            
        } else {
            
            NSDictionary *data = self.autoScrollData[i - self.autoScrollData.count];
            
            [self.dataArray addObject:data];
            
        }
        
    }
    
    [self.autoScrollTableView reloadData];
    
    self.count = 0;
    
    [self.displayLink invalidate];
    self.displayLink = nil;
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];

}

//CADisplayLink 定时器 系统默认每秒调用60次
- (void) tick:(CADisplayLink *)displayLink {

    self.count ++;
    //(25.0 / 30.0) * (float)self.count) ---> (tableview需要滚动的contentOffset / 一共调用的次数) * 第几次调用
    //比如该demo中 contentOffset最大值为 = cell的高度 * cell的个数 ,5秒执行一个循环则调用次数为 300,没1/60秒 count计数器加1,当count=300时,重置count为0,实现循环滚动.
    [self.autoScrollTableView setContentOffset:CGPointMake(0, (((90 / 3) / 120.0) * (float)self.count)) animated:NO];

    if (self.count >= 120 *self.autoScrollData.count) {

        self.count = 0;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AutoScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutoScrollTableViewCell" forIndexPath:indexPath];

    if (cell == nil) {

        cell = [[AutoScrollTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AutoScrollTableViewCell"];
    }
    cell.delegate = self;
    cell.data     = self.dataArray[indexPath.row];
    [cell loadContent];
    cell.backgroundColor = [UIColor redColor];

    return cell;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 90 / 3;
}

- (void) dealloc {

    [self.displayLink invalidate];
    self.displayLink = nil;

}

- (void) clickChankDetailsWithData:(id)data; {

    [self.delegate clickChankDetailsWithData:data];

}

@end
