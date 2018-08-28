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
    GWRoleClassPaladin_Retribution,
    GWRoleClassPaladin_Protection,
    GWRoleClassPaladin_Holy,
    GWRoleClassDeathKnight_Blood,
    GWRoleClassDeathKnight_Frost,
    GWRoleClassDeathKnight_Unholy,
    GWRoleClassDruid_Balance,
    GWRoleClassDruid_FeralCat,
    GWRoleClassDruid_FeralBear,
    GWRoleClassDruid_Restoration,
    GWRoleClassHunter_BeastMastery,
    GWRoleClassHunter_Marksmanship,
    GWRoleClassHunter_Survival,
    GWRoleClassMage_Arcane,
    GWRoleClassMage_Fire,
    GWRoleClassMage_Frost,
    GWRoleClassMonk_Brewmaster,
    GWRoleClassMonk_Mistweaver,
    GWRoleClassMonk_Windwalker,
    GWRoleClassPriest_Discipline,
    GWRoleClassPriest_Holy,
    GWRoleClassPriest_Shadow,
    GWRoleClassRogue_Assassination,
    GWRoleClassRogue_Combat,
    GWRoleClassRogue_Subtlety,
    GWRoleClassShaman_Elemental,
    GWRoleClassShaman_Enhancement,
    GWRoleClassShaman_Restoration,
    GWRoleClassWarlock_Affliction,
    GWRoleClassWarlock_Demonology,
    GWRoleClassWarlock_Destruction,
    GWRoleClassWarrior_Arms,
    GWRoleClassWarrior_Fury,
    GWRoleClassWarrior_Protection,
} GWRoleClass;

@interface GWRoleDataInfo : NSObject
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSNumber *health;
@property (nonatomic, strong) NSNumber *energy;
@property (nonatomic, strong) NSNumber *attack;
@property (nonatomic, strong) NSNumber *defense;
@property (nonatomic, assign) CGFloat criticalStrike;
@property (nonatomic, assign) CGFloat criticalBonus;
@property (nonatomic, assign) CGFloat attackInterval;
@property (nonatomic, assign) GWRoleClass roleClass;

- (instancetype)initWithRoleClass:(GWRoleClass)roleClass level:(NSInteger)level;

@end

NS_ASSUME_NONNULL_END
