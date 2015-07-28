//
//  LPYRecommendTagsCell.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/25.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYRecommendTagsCell.h"
#import <UIImageView+WebCache.h>

@interface LPYRecommendTagsCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;
@end

@implementation LPYRecommendTagsCell

- (void)awakeFromNib {
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = LPYColor(255, 255, 255);
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)setRecommendTagsModel:(LPYRecommendTagsModel *)recommendTagsModel
{
    _recommendTagsModel = recommendTagsModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.recommendTagsModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.lblName.text = self.recommendTagsModel.theme_name;
    if(self.recommendTagsModel.sub_number > 10000)
    {
        self.lblCount.text = [NSString stringWithFormat:@"已有%0.1f万人订阅", 1.0 * self.recommendTagsModel.sub_number / 10000];
    }
    else
    {
        self.lblCount.text = [NSString stringWithFormat:@"已有%zd人订阅",self.recommendTagsModel.sub_number];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnRecommendClick:(UIButton *)sender {
    LPYLog(@"订阅");
}
@end
