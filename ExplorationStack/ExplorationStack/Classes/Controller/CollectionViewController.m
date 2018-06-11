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



@interface CollectionViewController () <ExplorationStackViewLayoutDelegate>

@property (nonatomic, strong) NSMutableArray *arrColor;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;

@end

@implementation CollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _arrColor = [[NSMutableArray alloc] init];
    [_arrColor addObject:[UIColor grayColor]];
    [_arrColor addObject:[UIColor blueColor]];
    [_arrColor addObject:[UIColor yellowColor]];
    [_arrColor addObject:[UIColor grayColor]];
    
    ExplorationStackViewLayout *layout = [[ExplorationStackViewLayout alloc] init];
    self.collectionView.collectionViewLayout = layout;
    layout.delegateDrag = self;
    
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


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExplorationStackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExplorationStackCollectionViewCell" forIndexPath:indexPath];
    cell.img.backgroundColor = _arrColor[indexPath.row%4];
    cell.titleLabel.text = [NSString stringWithFormat:@"View %ld",indexPath.row];
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
}

- (void)explorationStackViewLayout:(UICollectionViewLayout *)collectionViewLayout cellDidSmallScreen:(NSIndexPath *)indexPath {
    [_btnRight setHidden:NO];
    [_btnLeft setHidden:NO];
}


@end
