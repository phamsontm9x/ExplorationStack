//
//  CommentDto.m
//  AppFood
//
//  Created by Nguyen on 5/2/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "CommentDto.h"

@implementation CommentDto

-(id)initWithData:(NSDictionary *)dic {
    self = [super init];
    if (dic) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
//            IO(_id);
//            IO(content);
//            IO(username);
//            IO(created);
//            IO(foodId);
//            IO(image);
        }
    }
    return self;
}

- (NSMutableDictionary *)getJSONObject {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
//    JO(_id);
//    JO(content);
//    JO(username);
//    JO(created);
//    JO(foodId);
//    JO(image);
    
    return dic;
}

- (id )getJSONObjectWithMethod:(NSInteger)method{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
//    if (method == METHOD_POST) {
//        JO(_id);
//        JO(content);
//        JO(username);
//        JO(created);
//        JO(foodId);
//    }
//
    return dic;
}

@end

@implementation ListCommentDto

- (instancetype)init {
    self = [super init];
    _list = [[NSMutableArray alloc] init];
    return self;
}

- (id)initWithData:(NSDictionary *)dic {
    self = [super init];
//    IAObj(list, dic, CommentDto);
    return self;
}

@end
