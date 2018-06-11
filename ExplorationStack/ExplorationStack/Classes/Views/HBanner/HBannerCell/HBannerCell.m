//
//  HBannerCell.m
//  Gito
//
//  Created by ThanhSon on 10/7/16.
//  Copyright © 2016 Horical. All rights reserved.
//

#import "HBannerCell.h"

@implementation HBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}


- (void)layoutSubviews {

    
}
- (void)drawRect:(CGRect)rect {    
    [self.contentView setFrame:_rectClv];
}

- (void)setFrameForImage:(NSInteger)index {
    [_imgBanner setFrame:CGRectMake(index*self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    
}
@end
