//
//  HBannerCell.h
//  Gito
//
//  Created by ThanhSon on 10/7/16.
//  Copyright © 2016 Horical. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBannerCell;

@protocol HBannerCellDelegate <NSObject>

@optional
- (void) hBannerCell:(HBannerCell*)hBannerCell clickedZoomImage:(NSURL *)imageUrl;
@end

@interface HBannerCell : UICollectionViewCell


@property (nonatomic, weak) id <HBannerCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *vNoImage;
@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnRemove;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;


@property (assign, nonatomic)  CGRect rectClv;

-(void)setFrameForImage:(NSInteger)index;

@end
