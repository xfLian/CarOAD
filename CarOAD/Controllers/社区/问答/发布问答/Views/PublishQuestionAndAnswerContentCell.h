//
//  PublishQuestionAndAnswerContentCell.h
//  CarOAD
//
//  Created by xf_Lian on 2018/1/7.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol PublishQuestionAndAnswerContentCellDelegate <NSObject>

- (void) getTextViewText:(NSString *)text;

- (void) showErrorMessage:(NSString *)message;

- (void) addImageWithImageArray:(NSArray *)imageArray;
- (void) deleteImageWithImageArray:(NSArray *)imageArray;

@end

@interface PublishQuestionAndAnswerContentCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<PublishQuestionAndAnswerContentCellDelegate> subCellDelegate;

@end
