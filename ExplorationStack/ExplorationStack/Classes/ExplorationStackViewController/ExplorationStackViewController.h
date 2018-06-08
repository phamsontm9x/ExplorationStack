//
//  ExplorationStackViewController.h
//  ExplorationStack
//
//  Created by Son Pham on 6/8/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ExplorationStackViewController;



@protocol ExplorationStackViewControllerDataSource<NSObject>

@optional
//- (void) didChangeCellExplorationStack
@end


@protocol ExplorationStackViewControllerDelegate

@required
- (int) numberOfViewsInExplorationStacksInExplorationStackView:(UICollectionView *)collectionView;
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView viewInExplorationStacksForItemAtIndexPath:(NSIndexPath *)indexPath;

@end



@interface ExplorationStackViewController : UICollectionViewController

@property (nonatomic, weak) id<ExplorationStackViewControllerDataSource> dataSource;
@property (nonatomic, weak) id<ExplorationStackViewControllerDelegate> delegate;

@end
