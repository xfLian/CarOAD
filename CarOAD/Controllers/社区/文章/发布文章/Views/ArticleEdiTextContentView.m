//
//  ArticleEdiTextContentView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/31.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ArticleEdiTextContentView.h"

#import "ImageTextAttachment.h"
#import "PictureModel.h"
#import "NSAttributedString+html.h"
#import "NSAttributedString+RichText.h"

#define IMAGE_MAX_SIZE (self.width - 24 *Scale_Width)

#define TEXT_MAX_SIZE 22
#define TEXT_MIN_SIZE 17

#define ImageTag (@"[UIImageView]")

#define Text_Back_Height  50 *Scale_Height
#define Image_One_Height  (self.width - 24 *Scale_Width) / 3 *2
#define Image_More_Height (self.width - 44 *Scale_Width) / 9 *2

@interface ArticleEdiTextContentView()<UITextViewDelegate>
{

    NSInteger list_tag;
    CGFloat   cell_height;

}

@property (nonatomic, assign) BOOL                       isDelete;
@property (nonatomic, assign) CGFloat                    lineSapce;
@property (nonatomic, assign) CGFloat                    paragraphSpacing;
@property (nonatomic, assign) CGFloat                    font;
@property (nonatomic, assign) BOOL                       isCentre;
@property (nonatomic, assign) BOOL                       isAddParagrap;
@property (nonatomic, assign) BOOL                       isAddList;
@property (nonatomic, assign) BOOL                       isBold;
@property (nonatomic, strong) NSMutableAttributedString *locationStr;
@property (nonatomic, assign) NSRange                    newRange;
@property (nonatomic, strong) NSString                  *newstr;

@property (nonatomic, strong) NSMutableArray            *attributesImagesArray;

@property (nonatomic, strong) UITextView  *textView;
@property (nonatomic, strong) UILabel     *firstPlaceholderLabel;

@property (nonatomic, strong) NSArray            *contentArray;
@property (nonatomic, strong) NSArray            *imagesArray;

@end

@implementation ArticleEdiTextContentView

- (NSMutableArray *)attributesImagesArray {

    if (!_attributesImagesArray) {

        _attributesImagesArray = [[NSMutableArray alloc] init];

    }

    return _attributesImagesArray;

}

- (void) buildSubview {

    self.backgroundColor = [UIColor whiteColor];

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(12 *Scale_Width, 10 *Scale_Height, self.width - 24 *Scale_Width, 500 *Scale_Height)];
    textView.textColor   = [UIColor blackColor];
    textView.delegate    = self;
    textView.backgroundColor = [UIColor clearColor];
    textView.keyboardType    = UIKeyboardTypeDefault;
    textView.returnKeyType   = UIReturnKeyDefault;
    textView.alwaysBounceVertical = NO;
    textView.editable        = YES;
    textView.textAlignment   = NSTextAlignmentLeft;
    textView.scrollEnabled   = NO;
    textView.font            = [UIFont systemFontOfSize:TEXT_MIN_SIZE];

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    style.lineSpacing = 8;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:style};

    CGRect frame       = textView.frame;
    frame.origin.x    += 5 *Scale_Width;
    frame.size.height  = 30.f *Scale_Height;
    frame.origin.y    += 7 *Scale_Height;

    //  默认显示文字
    UILabel *firstPlaceholderLabel = [UILabel createLabelWithFrame:frame
                                                         labelType:kLabelNormal
                                                              text:@"请输入正文"
                                                              font:[UIFont systemFontOfSize:TEXT_MIN_SIZE]
                                                         textColor:TextGrayColor
                                                     textAlignment:NSTextAlignmentLeft
                                                               tag:200];
    firstPlaceholderLabel.attributedText = [[NSAttributedString alloc] initWithString:@"请输入正文" attributes:attribute];
    [self addSubview:firstPlaceholderLabel];
    self.firstPlaceholderLabel = firstPlaceholderLabel;
    self.firstPlaceholderLabel.hidden = NO;

    [self addSubview:textView];
    self.textView = textView;

    //  初始化默认格式
    self.font             = TEXT_MIN_SIZE;
    self.lineSapce        = 8;
    self.paragraphSpacing = 10;
    self.isCentre         = NO;
    self.isBold           = NO;
    self.isAddList        = NO;

    [self resetTextStyle];

}

- (void)resetTextStyle {
    //After changing text selection, should reset style.
    NSRange wholeRange = NSMakeRange(0, _textView.textStorage.length);

    [_textView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    [_textView.textStorage removeAttribute:NSForegroundColorAttributeName range:wholeRange];

    //字体加粗
    if (self.isBold) {
        [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:self.font] range:wholeRange];
    }
    //字体大小
    else
    {

        [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.font] range:wholeRange];
    }

}

#pragma mark - image picker delegte
- (void) addImageForTextViewWithImage:(UIImage *)image; {

    [self appenParagraphReturn];

    //图片添加后 自动换行
    [self setImageText:image withRange:self.textView.selectedRange appenReturn:YES];

    [self.textView becomeFirstResponder];

}

//设置图片
-(void)setImageText:(UIImage *)img withRange:(NSRange)range appenReturn:(BOOL)appen
{

    UIImage *image = img;

    if (image == nil)
    {
        return;
    }

    if (![image isKindOfClass:[UIImage class]])
    {
        return;
    }

    CGFloat ImgeHeight = image.size.height *IMAGE_MAX_SIZE / image.size.width;
    if (ImgeHeight>IMAGE_MAX_SIZE*2) {
        ImgeHeight=IMAGE_MAX_SIZE*2;
    }

    ImageTextAttachment *imageTextAttachment = [ImageTextAttachment new];

    //Set tag and image
    imageTextAttachment.imageTag = ImageTag;
    imageTextAttachment.image    = image;

    //Set image size
    imageTextAttachment.imageSize = CGSizeMake(IMAGE_MAX_SIZE, ImgeHeight);

    [self.attributesImagesArray addObject:imageTextAttachment];

    if (appen) {

        //Insert image image
        [self.textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]
                                                  atIndex:range.location];
    }
    else
    {
        if (self.textView.textStorage.length > 0) {

            //Insert image image
            [self.textView.textStorage replaceCharactersInRange:range withAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]];
        }

    }

    //Move selection location
    self.textView.selectedRange = NSMakeRange(range.location + 1, range.length);

    //设置locationStr的设置
    [self setInitLocation];
    if(appen)
    {
        [self appenParagraphReturn];
    }


    [self changeTextViewHeight];

}

#pragma mark - 文本是否居中
- (void) isCentre:(BOOL)isCentre {

    self.isCentre = isCentre;

    [self setInitLocation];

}

#pragma mark - 是否添加列表
- (void) isAddList:(BOOL)isAddList {

    self.isAddList = isAddList;

    [self setInitLocation];

}

#pragma mark - 是否加粗字体
- (void) isBold:(BOOL)isBold {

    if (isBold) {

        self.isBold = YES;

    } else {

        self.isBold = NO;

    }

    [self setInitLocation];

}

#pragma mark - 是否标题字体
- (void) isMaxFont:(BOOL)isMaxFont {

    if (isMaxFont) {

        self.font = TEXT_MAX_SIZE;

    } else {

        self.font = TEXT_MIN_SIZE;

    }

    [self setInitLocation];

}

#pragma mark - 是否点击添加段落
- (void) isAddParagraph {

    [self appenParagraphReturn];

}

#pragma mark -  重置最新的内容
- (void) setInitLocation
{

    self.locationStr = nil;
    self.locationStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];

}

#pragma mark - 重置文本格式
-(void)setStyle
{

    //把最新的内容进行替换
    [self setInitLocation];

    if (self.isDelete) {

        return;
    }

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing              = self.lineSapce;// 字体的行间距
    paragraphStyle.paragraphSpacing         = self.paragraphSpacing;

    if (self.isCentre) {

        paragraphStyle.alignment = NSTextAlignmentCenter;

    } else {

        paragraphStyle.alignment = NSTextAlignmentLeft;

    }

    if (self.isAddList == YES) {

        paragraphStyle.firstLineHeadIndent = 20.f;
        paragraphStyle.headIndent          = 40.f;

    } else {

        paragraphStyle.firstLineHeadIndent = 0.f;
        paragraphStyle.headIndent          = 0.f;

    }

    NSDictionary *attributes = nil;
    if (self.isBold) {
        attributes = @{
                       NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font],
                       NSForegroundColorAttributeName:[UIColor blackColor],
                       NSParagraphStyleAttributeName:paragraphStyle
                       };

    }
    else
    {
        attributes = @{
                       NSFontAttributeName:[UIFont systemFontOfSize:self.font],
                       NSForegroundColorAttributeName:[UIColor blackColor],
                       NSParagraphStyleAttributeName:paragraphStyle
                       };

    }

    NSAttributedString *replaceStr = [[NSAttributedString alloc] initWithString:self.newstr attributes:attributes];
    [self.locationStr replaceCharactersInRange:self.newRange withAttributedString:replaceStr];

    self.textView.attributedText = self.locationStr;

    //  这里需要把光标的位置重新设定
    self.textView.selectedRange = NSMakeRange(self.newRange.location + self.newRange.length, 0);

}

#pragma mark -  刷新数据
- (void) loadContent {



}

#pragma mark -  获取textView数据
- (NSDictionary *) getTextContent; {

    CarOadLog(@"attributedText ---- %@",self.textView.attributedText);

    NSMutableArray * array = [NSMutableArray array];

    [self.textView.attributedText enumerateAttributesInRange:NSMakeRange(0, self.textView.attributedText.length)
                                                     options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                                                  usingBlock:^(NSDictionary *Attributes, NSRange range, BOOL *stop) {

        NSMutableDictionary *AttributeDict = [NSMutableDictionary dictionary];

        //1.  通过range取出相应的字符串
        NSString *title = [self.textView.attributedText.string substringWithRange:range];

        CarOadLog(@"title ---- %@",title);

        //1.把属性字典和相应字符串成为一个大字典
        if (title != nil) {

            [AttributeDict setObject:title forKey:@"title"];
        }
        //2.把属性存储为一个字典

        UIFont * font= Attributes[@"NSFont"];
        if (font!=nil) {

            CGFloat size=font.fontDescriptor.pointSize;
            [AttributeDict setObject:[NSNumber numberWithFloat:size] forKey:@"font_size"];
            [AttributeDict setObject:font.fontDescriptor.postscriptName forKey:@"font_name"];

        }
        //2.取出字体描述fontDescriptor
        NSDictionary *traits = [font.fontDescriptor objectForKey:UIFontDescriptorTraitsAttribute];
        CGFloat weight=[traits[UIFontWeightTrait] doubleValue];


        if (weight>0.0) {
            [AttributeDict setObject:[NSNumber numberWithBool:YES] forKey:@"bold"];
        }
        else
        {
            [AttributeDict setObject:[NSNumber numberWithBool:NO] forKey:@"bold"];
        }

        //2.图片
        ImageTextAttachment *ImageAtt = Attributes[@"NSAttachment"];
        if (ImageAtt!=nil) {
            [AttributeDict setObject:ImageAtt.image forKey:@"image"];
            //这里为title加上图片标示
            [AttributeDict setObject:ImageAtt.imageTag forKey:@"title"];
        }

        //2.行间距
        NSParagraphStyle * paragraphStyle = Attributes[@"NSParagraphStyle"];
        [AttributeDict setObject:[NSNumber numberWithFloat:paragraphStyle.alignment]           forKey:@"alignment"];
        [AttributeDict setObject:[NSNumber numberWithFloat:paragraphStyle.lineSpacing]         forKey:@"lineSpace"];
        [AttributeDict setObject:[NSNumber numberWithFloat:paragraphStyle.paragraphSpacing]    forKey:@"paragraphSpacing"];
        [AttributeDict setObject:[NSNumber numberWithFloat:paragraphStyle.firstLineHeadIndent] forKey:@"firstLineHeadIndent"];
        [AttributeDict setObject:[NSNumber numberWithFloat:paragraphStyle.headIndent]          forKey:@"headIndent"];

        //4.返回一个数组
        [array addObject:AttributeDict];

    }];

    NSMutableArray *imageArr = [NSMutableArray array];
    [self.textView.attributedText enumerateAttribute:NSAttachmentAttributeName
                                             inRange:NSMakeRange(0, self.textView.attributedText.length)
                                             options:0
                                          usingBlock:^(id value, NSRange range, BOOL *stop) {

                      if (value && [value isKindOfClass:[ImageTextAttachment class]]) {

                          ImageTextAttachment *TA = (ImageTextAttachment*)value;
                          [imageArr addObject:TA.image];
                      }
                  }];

    return @{@"Content" : array,
             @"Images"  : imageArr};

}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;{

    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;{

    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView;{

}

- (void)textViewDidEndEditing:(UITextView *)textView;{

}

- (void) textViewDidChange:(UITextView *)textView;{

    if (textView.text.length == 0) {

        self.firstPlaceholderLabel.hidden = NO;

    } else {

        [self.firstPlaceholderLabel setHidden:YES];

    }

    NSInteger len = textView.attributedText.length - self.locationStr.length;

    if (len > 0) {

        self.isDelete = NO;
        self.newRange = NSMakeRange(self.textView.selectedRange.location - len, len);
        self.newstr   = [textView.text substringWithRange:self.newRange];

    } else {

        self.isDelete = YES;

    }

    bool isChinese;//判断当前输入法是否是中文

    if ([[[textView textInputMode] primaryLanguage] isEqualToString: @"en-US"]) {

        isChinese = false;
    } else {

        isChinese = true;
    }

    if (isChinese) {

        UITextRange    *selectedRange = [self.textView markedTextRange];
        UITextPosition *position      = [self.textView positionFromPosition:selectedRange.start offset:0];

        if (!position) {

            [self setStyle];

        } else {


        }

    } else {

        [self setStyle];

    }

    [self changeTextViewHeight];

}

- (void) textViewDidChangeSelection:(UITextView *)textView;{



}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text isEqualToString:@"\n"]) {

        [self appenReturn];

        return NO;

    }

    return YES;

}

-(void)appenReturn
{

    //把最新的内容进行替换
    [self setInitLocation];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing              = self.lineSapce;// 字体的行间距
    paragraphStyle.paragraphSpacing         = self.paragraphSpacing;

    if (self.isCentre) {

        paragraphStyle.alignment = NSTextAlignmentCenter;

    } else {

        paragraphStyle.alignment = NSTextAlignmentLeft;

    }

    if (self.isAddList == YES) {
        
        paragraphStyle.firstLineHeadIndent = 20.f;
        paragraphStyle.headIndent          = 40.f;

    } else {

        paragraphStyle.firstLineHeadIndent = 0.f;
        paragraphStyle.headIndent          = 0.f;

    }

    NSDictionary *attributes = nil;
    if (self.isBold) {
        attributes = @{
                       NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font],
                       NSForegroundColorAttributeName:[UIColor blackColor],
                       NSParagraphStyleAttributeName:paragraphStyle
                       };

    }
    else
    {
        attributes = @{
                       NSFontAttributeName:[UIFont systemFontOfSize:self.font],
                       NSForegroundColorAttributeName:[UIColor blackColor],
                       NSParagraphStyleAttributeName:paragraphStyle
                       };

    }

    if (self.isAddList == YES) {

        NSAttributedString        *returnStr = [[NSAttributedString alloc] initWithString:@"\n •  "  attributes:attributes];
        NSMutableAttributedString *att       = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
        [att appendAttributedString:returnStr];

        self.textView.attributedText = att;

    } else {

        NSAttributedString        *returnStr = [[NSAttributedString alloc] initWithString:@"\n"  attributes:attributes];

        NSMutableAttributedString *att       = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
        [att appendAttributedString:returnStr];

        self.textView.attributedText = att;

    }

}

-(void)appenParagraphReturn
{

    //把最新的内容进行替换
    [self setInitLocation];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing              = self.lineSapce;// 字体的行间距
    paragraphStyle.paragraphSpacing         = self.paragraphSpacing;

    if (self.isCentre) {

        paragraphStyle.alignment = NSTextAlignmentCenter;

    } else {

        paragraphStyle.alignment = NSTextAlignmentLeft;

    }

    NSDictionary *attributes = nil;
    if (self.isBold) {
        attributes = @{
                       NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font],
                       NSForegroundColorAttributeName:[UIColor blackColor],
                       NSParagraphStyleAttributeName:paragraphStyle
                       };

    }
    else
    {
        attributes = @{
                       NSFontAttributeName:[UIFont systemFontOfSize:self.font],
                       NSForegroundColorAttributeName:[UIColor blackColor],
                       NSParagraphStyleAttributeName:paragraphStyle
                       };

    }

    NSAttributedString        *returnStr = [[NSAttributedString alloc] initWithString:@"\n" attributes:attributes];

    NSMutableAttributedString *att       = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    [att appendAttributedString:returnStr];

    self.textView.attributedText = att;

}

//  计算textView高度
- (void) changeTextViewHeight {

    CGFloat view_height = 0;

    for (ImageTextAttachment *image in self.attributesImagesArray) {

        view_height += image.imageSize.height;

    }

    //  计算文字高度
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing              = self.lineSapce;// 字体的行间距
    paragraphStyle.paragraphSpacing         = self.paragraphSpacing;

    if (self.isCentre) {

        paragraphStyle.alignment = NSTextAlignmentCenter;

    } else {

        paragraphStyle.alignment = NSTextAlignmentLeft;

    }

    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.headIndent          = 40.f;

    NSDictionary *attributes = nil;
    if (self.isBold) {
        attributes = @{
                       NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font],
                       NSParagraphStyleAttributeName:paragraphStyle
                       };

    }
    else
    {
        attributes = @{
                       NSFontAttributeName:[UIFont systemFontOfSize:self.font],
                       NSParagraphStyleAttributeName:paragraphStyle
                       };

    }

    CGSize descSize = [self.textView.text boundingRectWithSize:CGSizeMake(self.width - 24 *Scale_Height, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:attributes
                                                context:nil].size;

    CGRect frame        = self.textView.frame;
    frame.size.height   = descSize.height + view_height + 195 *Scale_Height;
    self.textView.frame = frame;

    if (frame.size.height != cell_height) {

        [_delegate changeViewHeight:frame.size.height];
        cell_height = frame.size.height;

    }

}

@end
