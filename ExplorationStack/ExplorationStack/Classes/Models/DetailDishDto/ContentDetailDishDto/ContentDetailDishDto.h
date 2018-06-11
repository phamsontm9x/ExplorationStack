//
//  ContentDetailDishDto.h
//  AppFood
//
//  Created by HHumorous on 3/18/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseDto.h"
#import <UIKit/UIKit.h>

@class ContentDetailDishDto;
@class ImageContentDetailDishDto;

@interface ContentDetailDishDto : BaseDto

@property (nonatomic, strong) NSString *step;
@property (nonatomic, strong) NSMutableArray <ImageContentDetailDishDto *> *arrImage;

@end

@interface ImageContentDetailDishDto : BaseDto

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) UIImage *img;

@end
