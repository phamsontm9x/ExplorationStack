//
//  BaseCell.h
//  AppFood
//
//  Created by ThanhSon on 3/8/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseCell;

//@protocol BaseCellDelegate <NSObject>
//
//@optional
//- (void)baseTableCellSelected:(BaseCell*)cell;
//@end

@interface BaseCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UILabel *lblSubTitle;
@property (nonatomic, weak) IBOutlet UILabel *lblFullName;

@property (nonatomic, weak) IBOutlet UIButton *btnAction;
@property (nonatomic, weak) IBOutlet UIButton *btnLogOut;

@property (nonatomic, weak) IBOutlet UIImageView *imgIcon;

@property (nonatomic, weak) IBOutlet UIView *vBackground;

@property (nonatomic, weak) IBOutlet UIButton *btnDelete;

//@property (nonatomic, weak) id<BaseCellDelegate> delegate;

@end
