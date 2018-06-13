//
//  ExplorationStackCollectionViewCell.h
//  ExplorationStack
//
//  Created by Son Pham on 6/8/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MangaInfoCollectionView.h"

@interface ExplorationStackCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *img;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) MangaInfoCollectionView *vc;



@end
