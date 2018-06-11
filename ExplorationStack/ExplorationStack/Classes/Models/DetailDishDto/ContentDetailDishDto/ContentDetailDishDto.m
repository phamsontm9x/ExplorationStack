//
//  ContentDetailDishDto.m
//  AppFood
//
//  Created by HHumorous on 3/18/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "ContentDetailDishDto.h"

@implementation ContentDetailDishDto

- (instancetype)init {
    self = [super init];
    _arrImage = [[NSMutableArray <ImageContentDetailDishDto *> alloc] init];
    return self;
}

-(id)initWithData:(NSDictionary *)dic {
    self = [super init];
    if (dic) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
//            IO(step);
//            IA(arrImage, ImageContentDetailDishDto);
        }
    }
    return self;
}

- (NSMutableDictionary *)getJSONObject {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    JO(step);
//    JA(arrImage);
    return dic;
}

- (id )getJSONObjectWithMethod:(NSInteger)method{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    return dic;
    
}
@end

@implementation ImageContentDetailDishDto

- (instancetype)init {
    self = [super init];
    return self;
}

-(id)initWithData:(NSDictionary *)dic {
    self = [super init];
    if (dic) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
//            IO(image);
        }
    }
    return self;
}

- (NSMutableDictionary *)getJSONObject {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    JO(image);

    return dic;
}

- (id )getJSONObjectWithMethod:(NSInteger)method{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    return dic;
    
}

@end
