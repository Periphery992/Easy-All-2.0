//
//  GWRoleDataInfo.h
//  Easy-All 2.0
//
//  Created by Posen on 2018/8/24.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    GWRoleClassPaladin_Retribution  = 101,
    GWRoleClassPaladin_Protection   = 102,
    GWRoleClassPaladin_Holy         = 103,
    GWRoleClassDeathKnight_Blood    = 201,
    GWRoleClassDeathKnight_Frost    = 202,
    GWRoleClassDeathKnight_Unholy   = 203,
    GWRoleClassDruid_Balance        = 301,
    GWRoleClassDruid_FeralCat       = 302,
    GWRoleClassDruid_FeralBear      = 303,
    GWRoleClassDruid_Restoration    = 304,
    GWRoleClassHunter_BeastMastery  = 401,
    GWRoleClassHunter_Marksmanship  = 402,
    GWRoleClassHunter_Survival      = 403,
    GWRoleClassMage_Arcane          = 501,
    GWRoleClassMage_Fire            = 502,
    GWRoleClassMage_Frost           = 503,
    GWRoleClassMonk_Brewmaster      = 601,
    GWRoleClassMonk_Mistweaver      = 602,
    GWRoleClassMonk_Windwalker      = 603,
    GWRoleClassPriest_Discipline    = 701,
    GWRoleClassPriest_Holy          = 702,
    GWRoleClassPriest_Shadow        = 703,
    GWRoleClassRogue_Assassination  = 801,
    GWRoleClassRogue_Combat         = 802,
    GWRoleClassRogue_Subtlety       = 803,
    GWRoleClassShaman_Elemental     = 901,
    GWRoleClassShaman_Enhancement   = 902,
    GWRoleClassShaman_Restoration   = 903,
    GWRoleClassWarlock_Affliction   = 1001,
    GWRoleClassWarlock_Demonology   = 1002,
    GWRoleClassWarlock_Destruction  = 1003,
    GWRoleClassWarrior_Arms         = 1101,
    GWRoleClassWarrior_Fury         = 1102,
    GWRoleClassWarrior_Protection   = 1103,
} GWRoleClass;

@interface GWRoleDataInfo : NSObject
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger health;
@property (nonatomic, assign) NSInteger energy;
@property (nonatomic, assign) NSInteger attack;
@property (nonatomic, assign) NSInteger defense;
@property (nonatomic, assign) CGFloat criticalStrike;
@property (nonatomic, assign) CGFloat criticalBonus;
@property (nonatomic, assign) CGFloat attackInterval;
@property (nonatomic, assign) GWRoleClass roleClass;


- (instancetype)initWithRoleClass:(GWRoleClass)roleClass level:(NSInteger)level allRoleBaseDic:(NSDictionary *)allRoleBaseDic
;

@end

NS_ASSUME_NONNULL_END
