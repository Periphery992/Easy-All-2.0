
//
//  RoleDataFormula.h
//  Easy-All 2.0
//
//  Created by Posen on 2018/8/24.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#ifndef RoleDataFormula_h
#define RoleDataFormula_h

#define correctLevel(level) (level-2)

#pragma mark - GWRoleClassPaladin_Retribution
#define BasicHealth_PaRe    200   //基础生命值
#define BasicIncHealth_PaRe 20    //基础增长值
#define AddIncHealth_PaRe   0    //额外增长值
#define formulaHealth_Palading_Restribution(level) [NSNumber numberWithInteger:BasicHealth_PaRe+(BasicIncHealth_PaRe+(BasicIncHealth_PaRe+correctLevel(level)*AddIncHealth_PaRe))*(level-1)/2]

#define BasicEnergy_PaRe    50   //基础能量值
#define BasicIncEnergy_PaRe 2    //基础增长值
#define AddIncEnergy_PaRe   0    //额外增长值
#define formulaEnergy_Palading_Restribution(level) [NSNumber numberWithInteger:BasicEnergy_PaRe+(BasicIncEnergy_PaRe+(BasicIncEnergy_PaRe+correctLevel(level)*AddIncEnergy_PaRe))*(level-1)/2]

#define BasicAttack_PaRe    30   //基础攻击值
#define BasicIncAttack_PaRe 3    //基础增长值
#define AddIncAttack_PaRe   1    //额外增长值
#define formulaAttack_Palading_Restribution(level) [NSNumber numberWithInteger:BasicAttack_PaRe+(BasicIncAttack_PaRe+(BasicIncAttack_PaRe+correctLevel(level)*AddIncAttack_PaRe))*(level-1)/2]

//#define BasicDefense_PaRe    50   //基础值
//#define BasicIncDefense_PaRe 5    //基础增长值
//#define AddIncDefense_PaRe   2    //额外增长值
//#define formulaDefense_Palading_Restribution(level) [NSNumber numberWithInteger:BasicDefense_PaRe+(BasicIncDefense_PaRe+(BasicIncDefense_PaRe+correctLevel(level)*AddIncDefense_PaRe))*(level-1)/2]

#define BasicCriticalStrike_PaRe    0.1   //基础值
#define BasicCriticalBonus_PaRe     1.5   //基础值
#define BasicAttackInterval_PaRe    1.5   //基础值

#endif /* RoleDataFormula_h */
