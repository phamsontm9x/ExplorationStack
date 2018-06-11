//
//  DetailDishDto.m
//  AppFood
//
//  Created by ThanhSon on 3/15/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "DetailDishDto.h"
#import "DetailDishDto.h"

@implementation DetailDishDto

- (id)initWithID:(NSString*)_id Image:(NSString*)strImg Name:(NSString*)name Desc:(NSString*)desc URL:(NSString*)youtube Material:(NSString*)material {
    self = [super init];
    
    __id = _id;
    _image = strImg;
    _name = name;
    _decriptions = desc;
    _youtube = youtube;
    _material = material;
    
    return self;
    
}

- (instancetype)init {
    self = [super init];
    _content = [[NSMutableArray <ContentDetailDishDto *> alloc] init];
    _materials = [[NSMutableArray <MaterialsDetailDishDto *> alloc] init];
    
    for (int i =0 ; i < 10 ; i ++) {
        MaterialsDetailDishDto * dto = [[MaterialsDetailDishDto alloc] init];
        dto.material = @"AAA";
        dto.amount = @"1111";
        [_materials addObject:dto];
    }
    
    return self;
}

-(id)initWithData:(NSDictionary *)dic {
    self = [super init];
    if (dic) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
//            IO(_id);
//            IO(image);
//            IO(name);
//            IO(decriptions);
//            IO(youtube);
//            IO(material);
//            IO(categoryId);
//            IA(content, ContentDetailDishDto);
//            IA(materials, MaterialsDetailDishDto);
//            IO(favourite);
//            IO(time);
        }
    }
    return self;
}

- (NSMutableDictionary *)getJSONObject {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
//    JO(_id);
//    JO(image);
//    JO(name);
//    JO(decriptions);
//    JO(youtube);
//    JO(material);
//    JO(categoryId);
//    JA(content);
//    JA(materials);
//    JO(favourite);
//    JO(time);
    
    return dic;
}

- (id )getJSONObjectWithMethod:(NSInteger)method{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
//    if (method == METHOD_POST_2) {
//        JO(favourite);
//    } else if (method == METHOD_POST) {
//        JO(image);
//        JO(name);
//        JO(decriptions);
//        JO(youtube);
//        JO(material);
//        JO(categoryId);
//        JA(content);
//        JA(materials);
//        JO(favourite);
//        JO(time);
//    }
    
    return dic;
    
}

- (BOOL)hasSave {
    BOOL save = NO;
//    ListDishDetailDto *list = [FileHelper getListFavorite];
//    for (DetailDishDto *item in list.list) {
//        if ([item._id isEqualToString:__id]) {
//            save = YES;
//            break;
//        }
//    }
    
    return save;
}



@end

@implementation ListDishDetailDto

- (instancetype)init {
    self = [super init];
    _list = [[NSMutableArray alloc] init];
    return self;
}

- (id)initWithData:(NSDictionary *)dic {
    self = [super init];
//    if ([dic isKindOfClass:[NSArray class]]) {
//        IAObj(list, dic, DetailDishDto);
//    }else if ([dic isKindOfClass:[NSDictionary class]]) {
//        IAObj(list, dic[@"list"], DetailDishDto);
//    }
    return self;
}

- (NSMutableDictionary *)getJSONObject {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    JA(list);
    return dic;
}

@end

