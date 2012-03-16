//
//  DummyAgari.m
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DummyAgari.h"

@implementation DummyAgari

@synthesize total_point, total_han_num, total_fu_num, tehai_list, img, bakaze, jikaze, is_furo, dora_num,
            is_chiho, is_tenho, is_tsumo, honba_num, is_haitei, is_parent, reach_num, is_chankan, is_ippatsu,
            is_rinshan, mangan_scale;

- (NSMutableDictionary *)getSerializableDictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    //    [dictionary setObject:@"img" forKey:self.img];
    [dictionary setObject:[NSNumber numberWithInt:self.total_point] forKey:@"total_point"];
    [dictionary setObject:[NSNumber numberWithInt:self.total_fu_num] forKey:@"total_fu_num"];
    
    return dictionary;
}

- (NSString *)toJSON
{
    NSMutableDictionary *d = [[self getSerializableDictionary] retain];
    NSString *json = [d JSONRepresentation];
    [d release];
    
    return json;
}

@end
