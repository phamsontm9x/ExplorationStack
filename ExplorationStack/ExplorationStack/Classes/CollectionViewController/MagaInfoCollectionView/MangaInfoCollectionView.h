//
//  MangaInfoCollectionView.h
//  ExplorationStack
//
//  Created by Son Pham on 6/11/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import <UIKit/UIKit.h>



@class MangaInfoCollectionView;


@protocol MangaInfoCollectionViewDelegate <NSObject>
- (void)mangaInfoCollectionView:(MangaInfoCollectionView *)vc didSmallScreen:(NSIndexPath*)indexPath;

@end



@interface MangaInfoCollectionView : UICollectionViewController

@property (nonatomic, weak) id<MangaInfoCollectionViewDelegate> delegate;
@property (nonatomic) UIColor *color;

- (void)didChangeModeFullScreen;

@end
