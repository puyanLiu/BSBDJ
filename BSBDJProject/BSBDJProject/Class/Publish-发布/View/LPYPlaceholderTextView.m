//
//  LPYPlaceholderTextView.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/8/5.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYPlaceholderTextView.h"

@interface LPYPlaceholderTextView()
/** placeholderLabel */
@property (nonatomic,weak) UILabel *placeholderLabel;

@end

@implementation LPYPlaceholderTextView

- (UILabel *)placeholderLabel
{
    if(_placeholderLabel == nil)
    {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.x = 4;
        label.y = 7;
        
        [self addSubview:label];
        _placeholderLabel = label;
    }
    
    return _placeholderLabel;
}

// 调整占位符的尺寸
//- (void)updatePlaceholderLabelSize
//{
//    // 方法二
//    CGFloat width = self.width - 2 * self.placeholderLabel.x;
//    self.placeholderLabel.width = width;
//    [self.placeholderLabel sizeToFit];
//    
//    
//    // 方法一
////    CGSize size = CGSizeMake(LPYScreenWidth - 2 * self.placeholderLabel.x , MAXFLOAT);
////    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
////    dictionary[NSFontAttributeName] = self.placeholderFont;
////    
////    self.placeholderLabel.size = [self.placeholderLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dictionary context:nil].size;
//}

- (void)layoutSubviews
{
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.font = [UIFont systemFontOfSize:14];
    self.placeholderColor = [UIColor grayColor];
    self.placeholderFont = self.font;
    
    self.alwaysBounceVertical = YES;
    
    // 发送通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(txtDidChanged) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)txtDidChanged
{
    self.placeholderLabel.hidden = self.hasText;
}

//- (void)drawRect:(CGRect)rect
//{
//    if(self.hasText) return;
//    
//    rect.origin.x = 4;
//    rect.origin.y = 7;
//    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//    dictionary[NSForegroundColorAttributeName] = self.placeholderColor;
//    dictionary[NSFontAttributeName] = self.placeholderFont;
//    [self.placeholder drawInRect:rect withAttributes:dictionary];
//}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
//    [self setNeedsDisplay];
    
    self.placeholderLabel.text = placeholder;
//    [self updatePlaceholderLabelSize];
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
//    [self setNeedsDisplay];
    
    self.placeholderLabel.textColor = placeholderColor;
//    [self updatePlaceholderLabelSize];
    [self setNeedsLayout];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
//    [self setNeedsDisplay];
    
    self.placeholderLabel.font = placeholderFont;
//    [self updatePlaceholderLabelSize];
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
//    [self setNeedsDisplay];
    
    [self txtDidChanged];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
//    [self setNeedsDisplay];

    [self txtDidChanged];
}

@end
