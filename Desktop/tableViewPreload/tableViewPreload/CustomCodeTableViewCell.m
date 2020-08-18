//
//  CustomCodeTableViewCell.m
//  tableViewPreload
//
//  Created by 饶鸿平 on 2020/8/7.
//  Copyright © 2020 饶鸿平. All rights reserved.
//

#import "CustomCodeTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface CustomCodeTableViewCell()

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation CustomCodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    [self.contentView addSubview:self.bgImageView];
    return [super initWithStyle:style reuseIdentifier:reuseIdentifier];
}

- (void)setUpCustomCellImageUrl:(NSString *)url {
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:url]];
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.frame];
    }
    return _bgImageView;
}

@end
