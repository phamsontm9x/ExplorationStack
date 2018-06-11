//
//  BaseDto.h
//  AppFood
//
//  Created by ThanhSon on 3/9/18.
//  Copyright © 2018 ThanhSon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDto : NSObject

- (id) initWithData:(NSDictionary*)dic;

- (NSMutableDictionary*) getJSONObject;
- (NSMutableDictionary*) getJSONObjectWithMethod:(NSInteger)method;
- (NSString*) getJSONString;

- (BaseDto*) cloneToNewObject;
- (void) mergedFromObject:(BaseDto*)object;


@end
