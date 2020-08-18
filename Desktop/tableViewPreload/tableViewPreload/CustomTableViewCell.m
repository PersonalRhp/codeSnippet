//
//  CustomTableViewCell.m
//  tableViewPreload
//
//  Created by 饶鸿平 on 2020/8/7.
//  Copyright © 2020 饶鸿平. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CustomTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCustomCellImageUrl:(NSString *)url {
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://timing-imgservice.kr-cell.com/image/timing_19097979_1596720099363_2jh6n5s0qg6bbvvw4ce1?x-oss-process=image/resize,w_180,h_180/quality,Q_80/format,jpg"]];
}

@end
