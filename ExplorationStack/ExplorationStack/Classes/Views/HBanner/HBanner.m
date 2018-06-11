//
//  HBanner.m
//  Gito
//
//  Created by ThanhSon on 10/7/16.
//  Copyright © 2016 Horical. All rights reserved.
//

#import "HBanner.h"
#import "HBannerCell.h"
#import "AppDelegate.h"


@interface HBanner () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,HBannerCellDelegate> {
    CGFloat width;
    CGFloat height;
}

@end

@implementation HBanner


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpCollectionView];
    [_pageControl setTintColor: [UIColor grayColor]] ;
    _clvBanner.pagingEnabled = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
   
}

- (void)setUpCollectionView {
    
    [_clvBanner registerNib:[UINib nibWithNibName:@"HBannerCell" bundle:nil] forCellWithReuseIdentifier:@"HBannerCell"];

}


- (void)setDataDisplay:(NSMutableArray*)arr {
    [_arrBanner removeAllObjects];
    _arrBanner = arr.mutableCopy;
    [_clvBanner reloadData];
}

- (void)setMaxPageControlNumber:(NSUInteger)maxPageControlNumber {
    _pageControl.numberOfPages = _arrBanner.count > maxPageControlNumber ? maxPageControlNumber : _arrBanner.count;
    
    [_clvBanner reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_arrBanner.count <1 ) {
        return 1;
        
    } else {
 
       return _arrBanner .count;
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _clvBanner.frame.size;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    HBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HBannerCell" forIndexPath:indexPath];

    if (_arrBanner.count >0) {

//        NSString *link = _arrBanner[row].image;
//        [cell.imgBanner sd_setImageWithURL:[NSURL URLWithString:link]
//                        placeholderImage:[UIImage imageNamed:@"cookbooklogo.9"]];
        cell.vNoImage.hidden = YES;
        
    }else {
        
        cell.imgBanner.backgroundColor = [UIColor grayColor];
        [cell.imgBanner setImage:nil];
        cell.vNoImage.hidden = NO;
    }
    cell.rectClv = _clvBanner.frame;
    cell.delegate = self;
    
    return cell;
}




//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    //HBannerCell *cell = [_clvBanner cellForItemAtIndexPath:indexPath];
//
//    NSURL *urlImage = nil;
//    if(_arrBanner.count > 0) {
//        urlImage = [NSURL URLWithString:_arrBanner[indexPath.row].link];
//    }
//
//    if (_delegate && [_delegate respondsToSelector:@selector(hBanner:clickedZoomImage:)]) {
//        [_delegate hBanner:self clickedZoomImage:urlImage];
//
//    } else {
//        if (_arrBanner.count > 0) {
//            ZoomImageVC *vc = VCFromSB(ZoomImageVC, SB_Common);
//            vc.urlImgZoom = urlImage;
//            [App.mainVC.contentNV presentViewController:vc animated:NO completion:nil];
//        }
//    }
//}

#pragma mark Banner

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int pageView  = scrollView.contentOffset.x/_clvBanner.bounds.size.width;
    _pageControl.currentPage = pageView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int pageView  = scrollView.contentOffset.x/_clvBanner.bounds.size.width;
    _pageControl.currentPage = pageView;
//    _indexPage = pageView;
//    [_delegate changeIndexPage:_indexPage];
}


#pragma mark -delehate hBannerCell

- (void)hBannerCell:(HBannerCell *)hBannerCell clickedZoomImage:(NSURL *)imageUrl {
    if (_delegate && [_delegate respondsToSelector:@selector(hBanner:clickedZoomImage:)]) {
        [_delegate hBanner:self clickedZoomImage:imageUrl];
    }
}



@end
