//
//  DetailDishDto.h
//  AppFood
//
//  Created by ThanhSon on 3/15/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseDto.h"
#import "ContentDetailDishDto.h"
#import "MaterialsDetailDishDto.h"
#import <UIKit/UIKit.h>

@class DetailDishDto;

@interface DetailDishDto : BaseDto

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSMutableArray *favourite;
@property (nonatomic, strong) NSString *decriptions;
@property (nonatomic, strong) NSString *youtube;
@property (nonatomic, strong) NSString *material;
@property (nonatomic, strong) NSMutableArray<MaterialsDetailDishDto *> *materials;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSMutableArray<ContentDetailDishDto *> *content;
@property (nonatomic, strong) NSString *time;
@property (strong, nonatomic) UIImage *imgAvatar;


@property (nonatomic, assign) BOOL hasSave;


- (id)initWithID:(NSString*)_id Image:(NSString*)strImg Name:(NSString*)name Desc:(NSString*)desc URL:(NSString*)youtube Material:(NSString*)material;

@end

@interface ListDishDetailDto : BaseDto

@property (nonatomic, strong) NSMutableArray <DetailDishDto *>*list;

@end


