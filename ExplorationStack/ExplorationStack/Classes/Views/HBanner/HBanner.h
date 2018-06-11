//
//  HBanner.h
//  Gito
//
//  Created by ThanhSon on 10/7/16.
//  Copyright © 2016 Horical. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBanner;
@protocol HBannerDelegate <NSObject>

- (void) changeIndexPage:(NSInteger)page;
- (void) hBanner:(HBanner*)hBanner clickedZoomImage:(NSURL *)imageUrl;

@end

@interface HBanner : UIView

@property (nonatomic, weak) id <HBannerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UICollectionView *clvBanner;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic , assign) NSInteger pageNumber;
@property (nonatomic , assign) BOOL roleEdit;

@property (nonatomic , assign) NSUInteger maxPageControlNumber;

@property (nonatomic , strong) NSMutableArray *arrBanner;


- (void)setDataDisplay:(NSMutableArray*)arr;
@end
