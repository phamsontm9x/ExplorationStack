//
//  CollectionViewController.m
//  ExplorationStack
//
//  Created by Son Pham on 6/8/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "CollectionViewController.h"
#import "ExplorationStackCollectionViewCell.h"
#import "ExplorationStackViewLayout.h"
#import "MangaInfoCollectionView.h"



@interface CollectionViewController () <ExplorationStackViewLayoutDelegate, MangaInfoCollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrColor;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) ExplorationStackViewLayout *layout;

@property (nonatomic) NSIndexPath *indexCell;
@property (nonatomic) BOOL fullScreen;

@end

@implementation CollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _indexCell  = 0;
    _fullScreen = NO;
    _arrColor = [[NSMutableArray alloc] init];
    [_arrColor addObject:[UIColor grayColor]];
    [_arrColor addObject:[UIColor blueColor]];
    [_arrColor addObject:[UIColor yellowColor]];
    [_arrColor addObject:[UIColor magentaColor]];
    
    _layout = [[ExplorationStackViewLayout alloc] init];
    self.collectionView.collectionViewLayout = _layout;
    [self.collectionView setScrollEnabled:NO];
    _layout.delegateDrag = self;
    _layout.gesturesEnabled = YES;
    
    [self.collectionView reloadData];
    
    _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(-10, self.collectionView.frame.size.height/2, 40, 40)];
    [_btnLeft setBackgroundImage:[UIImage imageNamed:@"ic_delete"] forState:UIControlStateNormal];
    
    _btnRight = [[UIButton alloc] initWithFrame:CGRectMake(self.collectionView.frame.size.width - 30, self.collectionView.frame.size.height/2, 40, 40)];
    [_btnRight setBackgroundImage:[UIImage imageNamed:@"ic_select"] forState:UIControlStateNormal];
    
    [self.view addSubview:_btnLeft];
    [self.view addSubview:_btnRight];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [_btnLeft setFrame:CGRectMake(-10, size.height/2, 40, 40)];
    [_btnRight setFrame:CGRectMake(size.width - 30, size.height/2, 40, 40)];
    [self.collectionView reloadData];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExplorationStackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExplorationStackCollectionViewCell" forIndexPath:indexPath];
    //cell.img.backgroundColor = _arrColor[indexPath.row%4];
    cell.titleLabel.text = [NSString stringWithFormat:@"View %ld",indexPath.row];
    
    cell.vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass([MangaInfoCollectionView class])];
    [cell.vc.view setFrame:cell.bounds];
    cell.vc.color = _arrColor[indexPath.row%4];
    cell.vc.delegate = self;
    [self addChildViewController:cell.vc];
    [cell addSubview:cell.vc.view];
    
    if (!_fullScreen) {
        [cell.vc.collectionView setScrollEnabled:NO];
    }

    return cell;
}


#pragma mark - ExplorationStackViewLayoutDelegate

- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout didFinishDraggingLeft:(BOOL)isLeft Right:(BOOL)isRight {
    _btnLeft.transform = CGAffineTransformMakeScale(1,1);
    _btnRight.transform = CGAffineTransformMakeScale(1,1);
}

- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout updateDraggingLeft:(BOOL)isLeft Right:(BOOL)isRight {
    if (isLeft) {
        _btnLeft.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } else {
        _btnLeft.transform = CGAffineTransformMakeScale(1,1);
    }
    
    if (isRight) {
        _btnRight.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } else {
        _btnRight.transform = CGAffineTransformMakeScale(1,1);
    }
}

- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout cellWillFullScreen:(NSIndexPath *)indexPath {
    [_btnRight setHidden:YES];
    [_btnLeft setHidden:YES];
    _indexCell = indexPath;
    _fullScreen = YES;
    _layout.gesturesEnabled = NO;
    ExplorationStackCollectionViewCell *cell = (ExplorationStackCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell.vc.collectionView setScrollEnabled:YES];
}

- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout cellDidSmallScreen:(NSIndexPath *)indexPath {
//    [_btnRight setHidden:NO];
//    [_btnLeft setHidden:NO];
//    _indexCell = indexPath;
//    _fullScreen = YES;
}

- (void)mangaInfoCollectionView:(MangaInfoCollectionView *)vc didSmallScreen:(NSIndexPath *)indexPath {
    [_btnRight setHidden:NO];
    [_btnLeft setHidden:NO];
    _fullScreen = NO;
    _layout.gesturesEnabled = YES;
    [_layout loadSmallScreen];
    [vc.collectionView setScrollEnabled:NO];
}


@end
