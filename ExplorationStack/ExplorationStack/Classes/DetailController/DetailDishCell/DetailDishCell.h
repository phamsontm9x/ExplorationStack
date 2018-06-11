//
//  DetailDishCell.h
//  AppFood
//
//  Created by HHumorous on 3/26/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseCell.h"
#import "HBanner.h"

@class DetailDishCell;

@protocol DetailDishCellDelegate <NSObject>

- (void)detailDishCell:(DetailDishCell *)cell didSelectedSave:(UIButton *)btn;
- (void)detailDishCell:(DetailDishCell *)cell didSelectedFavorite:(UIButton *)btn;

@end

@interface DetailDishCell : BaseCell

@property (nonatomic, weak) IBOutlet UIWebView *wvYoutube;
@property (nonatomic, weak) IBOutlet UIButton *btnFavorite;
@property (nonatomic, weak) IBOutlet UIButton *btnSave;
@property (nonatomic, weak) IBOutlet UILabel *lblIngredients;
@property (nonatomic, weak) IBOutlet UILabel *lblTime;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *csBotRow;
@property (nonatomic, weak) IBOutlet UIView *lineView;
@property (nonatomic, strong) HBanner *vBanner;
@property (nonatomic, weak) IBOutlet UIView *vContent;

- (void)roundCornersOnTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius;

@property (nonatomic, weak) id <DetailDishCellDelegate> delegate;

@end
