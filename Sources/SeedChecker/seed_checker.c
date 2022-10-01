#include "header.h"

#define BRAND_SKILL_WEIGHT_LOW 1
#define BRAND_SKILL_WEIGHT_MID 2
#define BRAND_SKILL_WEIGHT_HIGHT 10

int8_t brand_code_table[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 16, 17, 19, 20, 97, 98, 99};
SCAbility brand_usual_skill_table[] = {11, 9, 4, 3, 6, 7, 1, 8, 0, 12, 2, 5, 1, 10, 0, 13, 13, -1, -1, -1};
SCAbility brand_unusual_skill_table[] = {0, 8, 12, 4, 5, 1, 2, 6, 3, 13, 9, 7, 6, 11, 10, 10, 5, -1, -1, -1};

int brand_max_num_table[SCBrand_Count];
SCAbility brand_ability_table[SCBrand_Count][64];
int brand_max_num_with_drink_table[SCBrand_Count][SCAbility_Count];
SCAbility brand_ability_with_drink_table[SCBrand_Count][SCAbility_Count][64];

int8_t brand_code(SCBrand brand) {
    return brand_code_table[brand];
}

int brand_weight(SCBrand brand, SCAbility ability) {
    if (brand_usual_skill_table[brand] == ability) {
        return BRAND_SKILL_WEIGHT_HIGHT;
    } else if (brand_unusual_skill_table[brand] == ability) {
        return BRAND_SKILL_WEIGHT_LOW;
    } else {
        return BRAND_SKILL_WEIGHT_MID;
    }
}

SCRollingSeed advance_seed(SCRollingSeed x32) {
    x32 ^= x32 << 13;
    x32 ^= x32 >> 17;
    x32 ^= x32 << 5;
    return x32;
}

RollingResult get_ability(SCRollingSeed seed, SCBrand brand, SCAbility drink) {
    RollingResult result;
    result.seed = advance_seed(seed);
    if(drink == SCAbility_NoDrink) {
        int ability_roll = seed % brand_max_num_table[brand];
        result.ability = brand_ability_table[brand][ability_roll];
    } else if(seed % 0x64 <= 0x1D) {
        result.ability = drink;
    } else {
        result.seed = advance_seed(result.seed);
        int ability_roll = seed % brand_max_num_with_drink_table[brand][drink];
        result.ability = brand_ability_with_drink_table[brand][drink][ability_roll];
    }
    return result;
}

SCRollingSeed next_seed_if_match(SCRollingSeed seed, SCBrand brand, SCAbility ability) {
    RollingResult result = get_ability(seed, brand, SCAbility_NoDrink);
    if (result.ability == ability) {
        return result.seed;
    } else {
        return SCRollingSeed_Invalid;
    }
}

bool seed_match_sequence(SCRollingSeed seed, SCBrand brand, SCAbility const *ability_sequence, int ability_sequence_count) {
    for (int i=0; i<ability_sequence_count; i++) {
        SCRollingSeed next = next_seed_if_match(seed, brand, ability_sequence[i]);
        if (next == SCRollingSeed_Invalid) {
            return false;
        }
    }
    return true;
}

SCRollingSeed search_seed(SCRollingSeed seed_start, SCRollingSeed seed_end, SCBrand brand, SCAbility const *ability_sequence, int ability_sequence_count) {
    for (SCRollingSeed seed=seed_start; seed<=seed_end; seed++) {
        if (seed_match_sequence(seed, brand, ability_sequence, ability_sequence_count)) {
            return seed;
        }
    }
    return SCRollingSeed_Invalid;
}

__attribute__((constructor)) void fill_table() {
    for (SCBrand brand=0; brand<SCBrand_Count; brand++) {
        int idx = 0;
        int brand_max_num = 0;
        for (SCAbility ability=0; ability<SCAbility_Count; ability++) {
            int weight = brand_weight(brand, ability);
            for (int i=0; i<weight; i++) {
                brand_ability_table[brand][idx] = ability;
                idx++;
                brand_max_num += weight;
            }
            brand_max_num_table[brand] = brand_max_num;
        }
        
        for (SCAbility drink=0; drink<SCAbility_Count; drink++) {
            int idx = 0;
            int brand_drink_max_num = 0;
            for (SCAbility ability=0; ability<SCAbility_Count; ability++) {
                if (drink == ability) {
                    continue;
                }
                int weight = brand_weight(brand, ability);
                for (int i=0; i<weight; i++) {
                    brand_ability_with_drink_table[brand][drink][idx] = ability;
                    idx++;
                    brand_drink_max_num += weight;
                }
                brand_max_num_with_drink_table[brand][drink] = brand_drink_max_num;
            }
        }
    }
}
