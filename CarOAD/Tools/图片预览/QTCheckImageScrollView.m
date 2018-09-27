//
//  QTCheckImageScrollView.m
//  LinJiaMaMa
//
//  Created by qiantang on 16/12/13.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import "QTCheckImageScrollView.h"
#import "ImgScrollView.h"

@interface QTCheckImageScrollView()<UIScrollViewDelegate, ImgScrollViewDelegate>
{
    
    NSInteger currentIndex;
    NSInteger count;
    
    UIView        *backView;
    UIView        *markView;
    UIView        *scrollPanel;
    UIScrollView  *myScrollView;
    UIPageControl *pageControl;
    
}

@property (nonatomic, strong) UIView   *messageView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIWindow *windows;

@end

@implementation QTCheckImageScrollView

- (NSMutableArray *)imagesArray {
    
    if (!_imagesArray) {
        
        _imagesArray = [NSMutableArray array];
        
    }
    
    return _imagesArray;
    
}

- (void)buildViewwithTag:(NSInteger)tag {
    
    //  获取目前页面窗口
    UIWindow *windows   = [UIApplication sharedApplication].keyWindow;
    self.windows        = windows;
    
    //  创建背景view
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windows.width, windows.height)];
    
    scrollPanel      = [[UIView alloc] initWithFrame:backView.bounds];
    scrollPanel.backgroundColor = [UIColor clearColor];
    [backView addSubview:scrollPanel];
    
    markView                 = [[UIView alloc] initWithFrame:backView.bounds];
    markView.backgroundColor = [UIColor blackColor];
    [backView addSubview:markView];
    
    myScrollView          = [[UIScrollView alloc] initWithFrame:markView.bounds];
    myScrollView.delegate = self;
    [markView addSubview:myScrollView];
    myScrollView.pagingEnabled = YES;
    
    pageControl = \
    [[UIPageControl alloc] initWithFrame:CGRectMake(Screen_Width / 2 - 50,
                                                    myScrollView.height - 70,
                                                    100,
                                                    30)];
    //分页，pagingEnabled是scrollView的一个属性
    pageControl.pageIndicatorTintColor        = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = MainColor;
    
    //设置页数控制器总页数，即按钮数
    pageControl.numberOfPages = self.imagesArray.count;
    [backView addSubview:pageControl];
    
    CGSize contentSize = myScrollView.contentSize;
    contentSize.height = backView.bounds.size.height;
    contentSize.width  = Screen_Width *self.imagesArray.count;
    myScrollView.contentSize = contentSize;
    
    [myScrollView setContentOffset:CGPointMake(tag *Screen_Width, 0) animated:YES];
    
    [windows addSubview:backView];
    
    backView.alpha    = 0.f;
    pageControl.alpha = 0.f;
    markView.alpha    = 0.f;
    scrollPanel.alpha = 0.f;
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    pageControl.currentPage =
    (myScrollView.frame.size.width *0.5 + myScrollView.contentOffset.x) / myScrollView.frame.size.width;
    
}

- (void)loadData {
 
    NSLog(@"self.imagesArray.count +++ %ld",self.imagesArray.count);
    
    if (self.imagesArray.count == 0) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, myScrollView.width, myScrollView.height)];
        imageView.contentMode  = UIViewContentModeScaleAspectFit;
        imageView.image        = [UIImage imageNamed:@"logo_back_image_big"];
        
        //转换后的rect
        CGRect convertRect = [[imageView superview] convertRect:imageView.frame toView:backView];
        
        ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){0, 0, myScrollView.bounds.size}];
        [tmpImgScrollView setContentWithFrame:convertRect];
        [tmpImgScrollView setImage:imageView.image];
        [myScrollView addSubview:tmpImgScrollView];
        tmpImgScrollView.i_delegate = self;
        
        [tmpImgScrollView setAnimationRect];
        
    } else {
        
        for (int i = 0; i < self.imagesArray.count; i++) {
            
            id image = self.imagesArray[i];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i *Screen_Width, 0, myScrollView.width, myScrollView.height)];
            imageView.contentMode  = UIViewContentModeScaleAspectFit;
            imageView.image        = [UIImage imageNamed:@"logo_back_image_big"];
            
            if ([image isKindOfClass:[NSString class]]) {
                
                //  下载图片
                NSURL *downloudImageUrl = [NSURL URLWithString:image];
                
                [QTDownloadWebImage downloadImageForImageView:imageView
                                                     imageUrl:downloudImageUrl
                                             placeholderImage:@"logo_back_image_big"
                                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                         
                                                     }
                                                      success:^(UIImage *finishImage) {
                                                          
                                                          imageView.image = finishImage;
                                                          
                                                          //转换后的rect
                                                          CGRect convertRect = [[imageView superview] convertRect:imageView.frame toView:backView];
                                                          
                                                          ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){i *myScrollView.bounds.size.width, 0, myScrollView.bounds.size}];
                                                          [tmpImgScrollView setContentWithFrame:convertRect];
                                                          [tmpImgScrollView setImage:imageView.image];
                                                          [myScrollView addSubview:tmpImgScrollView];
                                                          tmpImgScrollView.i_delegate = self;
                                                          
                                                          [tmpImgScrollView setAnimationRect];
                                                          
                                                      }];
            
            } else if ([image isKindOfClass:[UIImage class]]) {
                
                imageView.image = image;
                
                //转换后的rect
                CGRect convertRect = [[imageView superview] convertRect:imageView.frame toView:backView];
                
                ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){i *myScrollView.bounds.size.width, 0, myScrollView.bounds.size}];
                [tmpImgScrollView setContentWithFrame:convertRect];
                [tmpImgScrollView setImage:imageView.image];
                [myScrollView addSubview:tmpImgScrollView];
                tmpImgScrollView.i_delegate = self;
                
                [tmpImgScrollView setAnimationRect];
                
            }
            
        }
    
    }

}

- (void) tapImageViewTappedWithObject:(id)sender {
    
    pageControl.alpha = 0.f;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        markView.alpha    = 0.f;
        scrollPanel.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        backView.alpha = 0.f;
        
        for (UIView *view in backView.subviews) {
            
            [view removeFromSuperview];
            
        }
        
        [backView removeFromSuperview];
        
    }];
    
}

- (void) showwithTag:(NSInteger)tag {
    
    [self buildViewwithTag:tag];
    
    [self loadData];
    
    backView.alpha    = 1.f;
    scrollPanel.alpha = 1.f;
    
    [UIView animateWithDuration:0.3 animations:^{

        markView.alpha    = 1.f;
        pageControl.alpha = 1.f;
        
    } completion:^(BOOL finished) {

        
        
    }];

}

@end
