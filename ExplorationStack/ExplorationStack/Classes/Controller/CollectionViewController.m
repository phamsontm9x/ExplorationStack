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



@interface CollectionViewController ()

@property (nonatomic, strong) NSMutableArray *arrColor;

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
    [self.collectionView reloadData];
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
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExplorationStackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExplorationStackCollectionViewCell" forIndexPath:indexPath];
    cell.img.backgroundColor = _arrColor[indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"View %ld",indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>



@end
