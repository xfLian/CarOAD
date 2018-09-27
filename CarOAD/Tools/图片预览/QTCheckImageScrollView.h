//
//  QTCheckImageScrollView.h
//  LinJiaMaMa
//
//  Created by qiantang on 16/12/13.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTCheckImageScrollView : UIView

 
@property (nonatomic, strong) NSMutableArray *imagesArray;

- (void) showwithTag:(NSInteger)tag;

@end
