//
//  LPYUserCell.m
//  BSBDJProject
//
//  Created by 刘蒲艳 on 15/7/24.
//  Copyright (c) 2015年 liupuyan. All rights reserved.
//

#import "LPYUserCell.h"
#import <UIImageView+WebCache.h>

@interface LPYUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *lblscreenName;
@property (weak, nonatomic) IBOutlet UILabel *lblRecommend;

@end

@implementation LPYUserCell

- (void)awakeFromNib {
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = LPYColor(255, 255, 255);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecommendUserModel:(LPYRecommendUserModel *)recommendUserModel
{
    _recommendUserModel = recommendUserModel;
    self.lblscreenName.text = self.recommendUserModel.screen_name;
    if(self.recommendUserModel.fans_count >= 10000)
    {
        self.lblRecommend.text = [NSString stringWithFormat:@"%.1f万人关注",1.0 * self.recommendUserModel.fans_count / 10000];
    }
    else
    {
        self.lblRecommend.text = [NSString stringWithFormat:@"%zd人关注", self.recommendUserModel.fans_count];
    }
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:self.recommendUserModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (IBAction)btnRecommendClick:(UIButton *)sender {
    LPYLog(@"关注");
}

@end
