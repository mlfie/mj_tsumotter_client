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
    NSArray *attributes = [NSArray arrayWithObjects:@"bakaze", @"jikaze",
                           @"honba_num", @"dora_num", @"reach_num", @"is_tsumo", @"is_ippatsu",
                           @"is_haitei", @"is_rinshan", @"is_chankan", @"is_tenho", @"is_chiho",
                           @"is_parent", nil];
    
    for (NSString *attribute in attributes) {
        id val = [self valueForKey:attribute];
        if(val) {
            if ([attribute hasPrefix:@"is_"]) {
                NSNumber *num = val;
                [agari setObject:[NSNumber numberWithBool:[num boolValue]] forKey:attribute];
            } else {
                [agari setObject:val forKey:attribute];                
            }
        }
    }
    
    if(self.img) {
        [agari setObject:[self.img base64EncodedString] forKey:@"img"];
    }
        
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:agari forKey:@"agari"];
    return dictionary;
}

- (NSString *)toJSON
{
    NSDictionary *d = [[self getSerializableDictionary] retain];
    NSString *json = [d JSONRepresentation];
    [d release];
    
    NSLog(@"json = %@", json);
    
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

//override
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
