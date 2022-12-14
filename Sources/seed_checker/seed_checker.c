#include "header.h"
#include <math.h>

#define BRAND_SKILL_WEIGHT_LOW 1
#define BRAND_SKILL_WEIGHT_MID 2
#define BRAND_SKILL_WEIGHT_HIGHT 10

const AbilityRollingSeed AbilityRollingSeedInvalid = 0;

static const Brand _all_brands[] = {BrandSquidForce, BrandZink, BrandKrakOn, BrandRockenberg, BrandZekko, BrandForge, BrandFirefin, BrandSkalop, BrandSplashMob, BrandInkline, BrandTentatek, BrandTakoroka, BrandAnnaki, BrandEnperry, BrandToniKensa, BrandBarazushi, BrandEmberz, BrandGrizzco, BrandCuttlegear, BrandAmiibo};
const Brand *all_brands = _all_brands;
const int all_brands_count = sizeof(_all_brands)/sizeof(_all_brands[0]);

static const Ability brand_usual_skill_table[] = {11, 9, 4, 3, 6, 7, 1, 8, 0, 12, 2, 5, 1, 10, 0, 13, 13, -1, -1, -1};
static const Ability brand_unusual_skill_table[] = {0, 8, 12, 4, 5, 1, 2, 6, 3, 13, 9, 7, 6, 11, 10, 10, 5, -1, -1, -1};

static int brand_max_num_table[BrandMax];
static Ability brand_ability_table[BrandMax][64];
static int brand_max_num_with_drink_table[BrandMax][AbilitySmallAbilityCount];
static Ability brand_ability_with_drink_table[BrandMax][AbilitySmallAbilityCount][64];

static int brand_get_index(Brand brand) {
    switch (brand) {
        case BrandSquidForce:   return 0;
        case BrandZink:         return 1;
        case BrandKrakOn:       return 2;
        case BrandRockenberg:   return 3;
        case BrandZekko:        return 4;
        case BrandForge:        return 5;
        case BrandFirefin:      return 6;
        case BrandSkalop:       return 7;
        case BrandSplashMob:    return 8;
        case BrandInkline:      return 9;
        case BrandTentatek:     return 10;
        case BrandTakoroka:     return 11;
        case BrandAnnaki:       return 12;
        case BrandEnperry:      return 13;
        case BrandToniKensa:    return 14;
        case BrandBarazushi:    return 15;
        case BrandEmberz:       return 16;
        case BrandGrizzco:      return 17;
        case BrandCuttlegear:   return 18;
        case BrandAmiibo:       return 19;
        default:                return -1;
    }
}

static int brand_weight(Brand brand, Ability ability) {
    int index = brand_get_index(brand);
    if (brand_usual_skill_table[index] == ability) {
        return BRAND_SKILL_WEIGHT_HIGHT;
    } else if (brand_unusual_skill_table[index] == ability) {
        return BRAND_SKILL_WEIGHT_LOW;
    } else {
        return BRAND_SKILL_WEIGHT_MID;
    }
}

AbilityRollingSeed advance_seed(AbilityRollingSeed x32) {
    x32 ^= x32 << 13;
    x32 ^= x32 >> 17;
    x32 ^= x32 << 5;
    return x32;
}

RollingResult get_ability(AbilityRollingSeed seed, Brand brand, Ability drink) {
    RollingResult result;
    result.seed = advance_seed(seed);
    if(drink == AbilityNone) {
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

static bool seed_match_sequence(AbilityRollingSeed seed, Brand brand, SingleRoll const *history, size_t history_count) {
    for (int i=0; i<history_count; i++) {
        SingleRoll historyToMatch = history[i];
        RollingResult result = get_ability(seed, brand, historyToMatch.drink);
        if (historyToMatch.ability != result.ability) {
            return false;;
        }
        seed = result.seed;
    }
    return true;
}

AbilityRollingSeed search_seed_in_range(AbilityRollingSeed seed_start, AbilityRollingSeed seed_end, Brand brand, SingleRoll const *history, size_t history_count) {
    for (AbilityRollingSeed seed=seed_start; seed<=seed_end; seed++) {
        if (seed_match_sequence(seed, brand, history, history_count)) {
            return seed;
        }
    }
    return AbilityRollingSeedInvalid;
}

size_t search_seed_in_list(AbilityRollingSeed const *seed_ptr, size_t seed_count, Brand brand, SingleRoll const *history, size_t history_count) {
    for (int i=0; i<seed_count; i++) {
        AbilityRollingSeed seed = seed_ptr[seed_count];
        if (seed_match_sequence(seed, brand, history, history_count)) {
            return i;
        }
    }
    return -1;
}

void search_seed(Brand brand, SingleRoll const *history, size_t history_count, AbilityRollingSeed start, AbilityRollingSeed *result, size_t *result_count, void (*reporting_progress)(double, void const *), void *reporting_progress_context) {
    double fstride = pow(AbilitySmallAbilityCount, history_count);
    double estimated_result_count = (double)UINT32_MAX / fstride;
    double estimated_max_seed = UINT32_MAX;
//    if (*result_count < estimated_result_count) {
//        estimated_max_seed /= estimated_result_count;
//        estimated_max_seed *= *result_count;
//    }
    int stride = estimated_max_seed / 100;
    int result_idx = 0;
    for (AbilityRollingSeed seed=1; seed!=0; seed++) {
        if (seed_match_sequence(seed, brand, history, history_count)) {
            result[result_idx] = seed;
            result_idx ++;
            if (result_idx >= *result_count) {
                return;
            }
        }
        if (reporting_progress && (seed % stride == 0)) {
            double progress = (double)(seed / stride) / 100.0;
            if (progress < 1) {
                reporting_progress(progress, reporting_progress_context);
            }
        }
    }
    *result_count = result_idx;
}

__attribute__((constructor)) void fill_table() {
    for (int i=0; i<all_brands_count; i++) {
        Brand brand = all_brands[i];
        int idx = 0;
        int brand_max_num = 0;
        for (Ability ability=0; ability<AbilitySmallAbilityCount; ability++) {
            int weight = brand_weight(brand, ability);
            for (int i=0; i<weight; i++) {
                brand_ability_table[brand][idx] = ability;
                idx++;
                brand_max_num += weight;
            }
            brand_max_num_table[brand] = brand_max_num;
        }
        
        for (Ability drink=0; drink<AbilitySmallAbilityCount; drink++) {
            int idx = 0;
            int brand_drink_max_num = 0;
            for (Ability ability=0; ability<AbilitySmallAbilityCount; ability++) {
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
