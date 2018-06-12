//
//  ExplorationStackCollectionViewCell.m
//  ExplorationStack
//
//  Created by Son Pham on 6/8/18.
//  Copyright © 2018 Son Pham. All rights reserved.
//

#import "ExplorationStackCollectionViewCell.h"

@implementation ExplorationStackCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;

}



@end
