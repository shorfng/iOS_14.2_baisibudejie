//
//  TDRecommendCategoryCell.m
//  百思不得姐
//
//  Created by 蓝田 on 2017/1/11.
//  Copyright © 2017年 蓝田. All rights reserved.
//

#import "TDRecommendCategoryCell.h"
#import "TDRecommendCategory.h"

@interface TDRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;  // 左侧选中时显示的指示器控件
@end

@implementation TDRecommendCategoryCell

#pragma mark - 自定义 cell的 xib 的属性
// 当cell的 selection 设置为None时, 即使cell被选中了, 内部的子控件也不会进入高亮状态
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor =  TDRGBColor(244, 244, 244);   // cell的背景色
    self.selectedIndicator.backgroundColor = TDRGBColor(219, 21, 26);  // 左侧选中时的颜色
}

#pragma mark - 重写左侧目录的category的内容
- (void)setCategory:(TDRecommendCategory *)category{
    _category = category;
    
    // 将左侧目录的name 赋值给 cell 中的 textLabel中的 text 属性
    self.textLabel.text = category.name;
}

#pragma mark - 重新调整内部textLabel的frame
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

#pragma mark - 重写选中 cell 的时候(此方法用于监听cell的选中和取消选中)
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    // cell没有被选中的时候，隐藏 selectedIndicator（即是左侧的竖条）
    self.selectedIndicator.hidden = !selected;
    // 通过是否选中 cell 来设置 cell 上 textLabel 的颜色
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : TDRGBColor(78, 78, 78);
}

@end
