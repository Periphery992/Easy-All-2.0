//
//  GWRoleDataInfo.m
//  Easy-All 2.0
//
//  Created by Posen on 2018/8/24.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#import "GWRoleDataInfo.h"
#import "RoleDataFormula.h"

@interface GWRoleDataInfo (){}

@end

#define TAG_HEALTH_FORMULA iHealth_base+(level-1)*iHealth_growth
#define TAG_ENERGY_FORMULA iEnergy_base+(level-1)*iEnergy_growth
#define TAG_ATTACK_FORMULA iAttack_base+(level-1)*iAttack_growth

@implementation GWRoleDataInfo

- (instancetype)initWithRoleClass:(GWRoleClass)roleClass level:(NSInteger)level allRoleBaseDic:(NSDictionary *)allRoleBaseDic
{
    if (self = [super init])
    {
        
        NSDictionary *roleBaseDic = [allRoleBaseDic objectForKey:[NSString stringWithFormat:@"%zi",roleClass]];
        
        NSInteger iHealth_base = [[roleBaseDic objectForKey:@"health_base"] integerValue];
        NSInteger iHealth_growth = [[roleBaseDic objectForKey:@"health_growth"] integerValue];
        NSInteger iEnergy_base = [[roleBaseDic objectForKey:@"energy_base"] integerValue];
        NSInteger iEnergy_growth = [[roleBaseDic objectForKey:@"energy_growth"] integerValue];
        NSInteger iAttack_base = [[roleBaseDic objectForKey:@"attack_base"] integerValue];
        NSInteger iAttack_growth = [[roleBaseDic objectForKey:@"attack_growth"] integerValue];
        CGFloat iCriticalStrike_base = [[roleBaseDic objectForKey:@"criticalStrike_base"] floatValue];
        CGFloat iCriticalBonus_base = [[roleBaseDic objectForKey:@"criticalBonus_base"] floatValue];
        CGFloat iAttackInterval_base = [[roleBaseDic objectForKey:@"attackInterval_base"] floatValue];
        
        self.roleClass = roleClass;
        self.level = level;
        self.health = TAG_HEALTH_FORMULA;
        self.energy = TAG_ENERGY_FORMULA;
        self.attack = TAG_ATTACK_FORMULA;
        self.criticalStrike = iCriticalStrike_base;
        self.criticalBonus = iCriticalBonus_base;
        self.attackInterval = iAttackInterval_base;
    }
    
    return self;
}

- (NSString *)description
{
    NSString *string = [NSString stringWithFormat:@"level  :%zi\
                          \r\n                     health :%zi\
                          \r\n                     Energy :%zi\
                          \r\n                     Attack :%zi\
                          \r\n                     Defense:%zi\
                          \r\n----------------------------------",
                        self.level,
                        self.health,
                        self.energy,
                        self.attack,
                        self.defense];
    
    return string;
}

@end
