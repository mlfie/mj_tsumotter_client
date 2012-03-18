//
//  DummyAgari.m
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MjAgari.h"
#import "NSData+Base64.h"

@implementation MjAgari

@synthesize img, bakaze, jikaze, dora_num, honba_num, reach_num, 
           is_tsumo, is_ippatsu, is_haitei, is_rinshan, is_chankan, is_tenho, is_chiho, is_parent,
           total_fu_num, total_han_num, child_point, parent_point, ron_point, total_point, mangan_scale,
           is_furo, tehai_list, yaku_list;

- (id)init
{
    self = [super init];
    if(self) {
        self.img = nil;
        self.bakaze = nil;
        self.jikaze = nil;
        self.honba_num = 0;
        self.dora_num = 0;
        self.reach_num = 0;
        self.is_tsumo = NO;
        self.is_ippatsu = NO;
        self.is_haitei = NO;
        self.is_rinshan = NO;
        self.is_chankan = NO;
        self.is_tenho = NO;
        self.is_chiho = NO;
        self.is_parent = NO;
        self.total_fu_num = 0;
        self.total_han_num = 0;
        self.child_point = 0;
        self.parent_point = 0;
        self.ron_point = 0;
        self.total_point = 0;
        self.mangan_scale = 0;
        self.is_furo = NO;
        self.tehai_list = nil;
        self.yaku_list = nil;
    }
    return self;
}

- (NSDictionary *)getSerializableDictionary
{
    NSMutableDictionary *agari = [NSMutableDictionary dictionary];
    if(self.img) {
        [agari setObject:[self.img base64EncodedString] forKey:@"img"];
    }
    if(self.bakaze) {
        [agari setObject:self.bakaze forKey:@"bakaze"];
    }
    if(self.jikaze) {
        [agari setObject:self.jikaze forKey:@"jikaze"];
    }
    [agari setObject:[NSNumber numberWithInt:self.honba_num] forKey:@"honba_num"];
    [agari setObject:[NSNumber numberWithInt:self.dora_num] forKey:@"dora_num"];
    [agari setObject:[NSNumber numberWithInt:self.reach_num] forKey:@"reach_num"];
    [agari setObject:[NSNumber numberWithBool:self.is_tsumo] forKey:@"is_tsumo"];
    [agari setObject:[NSNumber numberWithBool:self.is_ippatsu] forKey:@"is_ippatsu"];
    [agari setObject:[NSNumber numberWithBool:self.is_haitei] forKey:@"is_haitei"];
    [agari setObject:[NSNumber numberWithBool:self.is_rinshan] forKey:@"is_rinshan"];
    [agari setObject:[NSNumber numberWithBool:self.is_chankan] forKey:@"is_chankan"];
    [agari setObject:[NSNumber numberWithBool:self.is_tenho] forKey:@"is_tenho"];
    [agari setObject:[NSNumber numberWithBool:self.is_chiho] forKey:@"is_chiho"];
    [agari setObject:[NSNumber numberWithBool:self.is_parent] forKey:@"is_parent"];
        
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:agari forKey:@"agari"];
    return dictionary;
}

- (NSString *)toJSON
{
    NSDictionary *d = [[self getSerializableDictionary] retain];
    NSString *json = [d JSONRepresentation];
    [d release];
    
    return json;
}

- (BOOL)fromJSON:(NSString *)json
{
    NSDictionary *dictionary = [json JSONValue];
    if (!dictionary) { return NO; }
    
    NSDictionary *agari = [dictionary objectForKey:@"agari"];
    if (!agari) { return NO; }

    @try {
        NSEnumerator *enumerator = [agari keyEnumerator];
        id key;
        while (key = [enumerator nextObject]) {
            [self setValue:[agari objectForKey:key] forKey:key];
        }        
    }
    @catch (NSException *exception) {
        NSLog(@"MjAgari#fromJSON catch Exception %@", exception.description);
        return NO;
    }
    
    return YES;
}

@end
