//
//  MaterialsDetailDishDto.m
//  AppFood
//
//  Created by HHumorous on 3/27/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "MaterialsDetailDishDto.h"

@implementation MaterialsDetailDishDto

- (instancetype)init {
    self = [super init];
    return self;
}

-(id)initWithData:(NSDictionary *)dic {
    self = [super init];
    if (dic) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
//            IO(material);
//            IO(amount);
        }
    }
    return self;
}

- (NSMutableDictionary *)getJSONObject {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    JO(material);
//    JO(amount);
    return dic;
}

- (id )getJSONObjectWithMethod:(NSInteger)method{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    return dic;
    
}

@end
