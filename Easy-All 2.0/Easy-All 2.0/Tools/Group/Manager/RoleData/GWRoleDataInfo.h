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
    GWRoleHeroPaladin           = 1,
    GWRoleHeroDruid             = 2,
    GWRoleHeroHunter            = 3,
    GWRoleHeroMage              = 4,
    GWRoleHeroPriest            = 500,
    GWRoleHeroRogue             = 600,
    GWRoleHeroShaman            = 700,
    GWRoleHeroWarlock           = 800,
    GWRoleHeroWarrior           = 900,
//    GWRoleHeroDeathKnigh        = 1000,
//    GWRoleHeroMonk              = 1100,
    GWRoleHeroEnd,
} GWRoleHero;

typedef enum : NSUInteger {
    GWRoleClassPaladin_Retribution  = 101,
    GWRoleClassPaladin_Protection   = 102,
    GWRoleClassPaladin_Holy         = 103,
    GWRoleClassHunter_BeastMastery  = 201,
    GWRoleClassHunter_Marksmanship  = 202,
    GWRoleClassHunter_Survival      = 203,
    GWRoleClassMage_Arcane          = 301,
    GWRoleClassMage_Fire            = 302,
    GWRoleClassMage_Frost           = 303,
    GWRoleClassPriest_Discipline    = 401,
    GWRoleClassPriest_Holy          = 402,
    GWRoleClassPriest_Shadow        = 403,
    GWRoleClassRogue_Assassination  = 501,
    GWRoleClassRogue_Combat         = 502,
    GWRoleClassRogue_Subtlety       = 503,
    GWRoleClassShaman_Elemental     = 601,
    GWRoleClassShaman_Enhancement   = 602,
    GWRoleClassShaman_Restoration   = 603,
    GWRoleClassWarlock_Affliction   = 701,
    GWRoleClassWarlock_Demonology   = 702,
    GWRoleClassWarlock_Destruction  = 703,
    GWRoleClassWarrior_Arms         = 801,
    GWRoleClassWarrior_Fury         = 802,
    GWRoleClassWarrior_Protection   = 803,
    GWRoleClassDruid_Balance        = 901,
    GWRoleClassDruid_FeralCat       = 902,
    GWRoleClassDruid_FeralBear      = 903,
    GWRoleClassDruid_Restoration    = 904,
//    GWRoleClassDeathKnight_Blood    = 1001,
//    GWRoleClassDeathKnight_Frost    = 1002,
//    GWRoleClassDeathKnight_Unholy   = 1003,
//    GWRoleClassMonk_Brewmaster      = 1101,
//    GWRoleClassMonk_Mistweaver      = 1102,
//    GWRoleClassMonk_Windwalker      = 1103,
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
@property (nonatomic, assign) CGFloat hitRate;
@property (nonatomic, assign) GWRoleClass roleClass;


- (instancetype)initWithRoleClass:(GWRoleClass)roleClass level:(NSInteger)level allRoleBaseDic:(NSDictionary *)allRoleBaseDic
;

@end

NS_ASSUME_NONNULL_END
