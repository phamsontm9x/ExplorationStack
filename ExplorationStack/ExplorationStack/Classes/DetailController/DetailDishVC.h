//
//  DetailDishVC.h
//  AppFood
//
//  Created by ThanhSon on 3/9/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailDishDto.h"
#import "CommentDto.h"

@interface DetailDishVC : UIViewController

@property (nonatomic, weak) IBOutlet UIView *vHeaderView;
@property (nonatomic, weak) IBOutlet UITableView * tbvContent;

@property (nonatomic, weak) IBOutlet UIView *vNav;
@property (nonatomic, weak) IBOutlet UIView *vHeaderTbv;
@property (nonatomic, weak) IBOutlet UIImageView *imgHeaderView;
@property (nonatomic, weak) IBOutlet UIImageView *imgAvatar;

@property (nonatomic, weak) IBOutlet UIButton *btnBack;
@property (nonatomic, weak) IBOutlet UIButton *btnReload;
@property (nonatomic, weak) IBOutlet UIButton *btnShare;

@property (nonatomic, weak) IBOutlet UILabel *lblHeader;

@property (nonatomic, weak) IBOutlet UILabel *lblTitleHeaderTBV;
@property (nonatomic, weak) IBOutlet UILabel *lblDescHeaderTBV;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *vEff;


@property (nonatomic, strong) DetailDishDto *fooddish;
@property (nonatomic, strong) ListCommentDto *listComment;

@property (nonatomic, strong) NSString *foodId;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *name;

@property (nonatomic) BOOL lazyLoad;

@end


