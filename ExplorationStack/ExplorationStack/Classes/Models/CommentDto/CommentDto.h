//
//  CommentDto.h
//  AppFood
//
//  Created by Nguyen on 5/2/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import "BaseDto.h"

@class CommentDto;

@interface CommentDto : BaseDto

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *foodId;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *image;

@end

@interface ListCommentDto : BaseDto

@property (nonatomic, strong) NSMutableArray <CommentDto *>*list;


@end
