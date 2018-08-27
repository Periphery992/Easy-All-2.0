//
//  GWRoleDataInfo.m
//  Easy-All 2.0
//
//  Created by Posen on 2018/8/24.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#import "GWRoleDataInfo.h"
#import "RoleDataFormula.h"


@implementation GWRoleDataInfo

- (instancetype)initWithRoleClass:(GWRoleClass)roleClass level:(NSInteger)level
{
    if (self = [super init])
    {
        switch (roleClass) {
            case GWRoleClassPaladin_Retribution:
            {
                self.roleClass = roleClass;
                self.level = level;
                self.health = formulaHealth_Palading_Restribution(level);
                self.energy = formulaEnergy_Palading_Restribution(level);
                self.attack = formulaAttack_Palading_Restribution(level);
                self.defense = formulaDefense_Palading_Restribution(level);

            }
                break;
                
            default:
                break;
        }
    }
    
    return self;
}

- (NSString *)description
{
    CGFloat i = [self.defense floatValue];
    CGFloat f = i/(i+self.level*self.level+self.level*30);
    f = f*100;
    
    NSString *string = [NSString stringWithFormat:@"level  :%zi\
                          \r\n                     health :%@\
                          \r\n                     Energy :%@\
                          \r\n                     Attack :%@\
                          \r\n                     Defense:%@\
                          \r\n                     Defense:%0.2f%%\
                          \r\n----------------------------------",
                        self.level,
                        self.health,
                        self.energy,
                        self.attack,
                        self.defense,
                        f];
    
    return string;
}

@end
