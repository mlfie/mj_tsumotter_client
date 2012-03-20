//
//  Agari.m
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 12/03/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Agari.h"
#import "Yaku.h"

@implementation Agari

@dynamic bakaze;
@dynamic date;
@dynamic dora_num;
@dynamic honba_num;
@dynamic img;
@dynamic is_chankan;
@dynamic is_chiho;
@dynamic is_furo;
@dynamic is_haitei;
@dynamic is_ippatsu;
@dynamic is_parent;
@dynamic is_rinshan;
@dynamic is_tenho;
@dynamic is_tsumo;
@dynamic jikaze;
@dynamic mangan_scale;
@dynamic reach_num;
@dynamic tehai_list;
@dynamic total_fu_num;
@dynamic total_han_num;
@dynamic total_point;
@dynamic child_point;
@dynamic parent_point;
@dynamic ron_point;
@dynamic yakus;

- (void)fromMjAgari:(MjAgari *)mjAgari
{
    NSArray *attributes = [NSArray arrayWithObjects:@"bakaze", @"jikaze", @"honba_num",
                           @"dora_num", @"reach_num", @"is_chankan", @"is_chiho", @"is_furo", @"is_haitei", @"is_ippatsu", @"is_parent",
                           @"is_rinshan", @"is_tenho", @"is_tsumo", @"mangan_scale",
                           @"tehai_list", @"total_fu_num", @"total_han_num", @"total_point", @"child_point", @"parent_point", @"ron_point", @"img", nil];
    
    for (NSString *attribute in attributes) {
        [self setValue:[mjAgari valueForKey:attribute] forKey:attribute];
    }
}

@end
