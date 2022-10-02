#ifndef header_h
#define header_h

#include <stdbool.h>
#include <stdint.h>

typedef uint32_t AbilityRollingSeed __attribute__((swift_wrapper(struct)));
extern const AbilityRollingSeed AbilityRollingSeedInvalid;

typedef enum __attribute__((enum_extensibility(open))) : uint8_t {
    AbilityInkSaverMain = 0,
    AbilityInkSaverSub,
    AbilityInkRecoveryUp,
    AbilityRunSpeedUp,
    AbilitySwimSpeedUp,
    AbilitySpecialChargeUp,
    AbilitySpecialSaver,
    AbilitySpecialPowerUp,
    AbilityQuickRespawn,
    AbilityQuickSuperJump,
    AbilitySubPowerUp,
    AbilityInkResistanceUp,
    AbilitySubResistanceUp,
    AbilityIntensifyAction,
    
    AbilityCount,
    AbilityNoDrink,
} Ability;

typedef enum __attribute__((enum_extensibility(open))) : int8_t {
    BrandSquidForce,
    BrandZink,
    BrandKrakOn,
    BrandRockenberg,
    BrandZekko,
    BrandForge,
    BrandFirefin,
    BrandSkalop,
    BrandSplashMob,
    BrandInkline,
    BrandTentatek,
    BrandTakoroka,
    BrandAnnaki = 15,
    BrandEnperry,
    BrandToniKensa,
    BrandBarazushi = 19,
    BrandEmberz,
    BrandGrizzco = 97,
    BrandCuttlegear,
    BrandAmiibo,
    
    BrandMax,
} Brand;

typedef struct {
    Ability ability;
    AbilityRollingSeed seed;
} RollingResult;

AbilityRollingSeed advance_seed(AbilityRollingSeed x32);
RollingResult get_ability(AbilityRollingSeed seed, Brand brand, Ability drink);

/// returns first found seed, or AbilityRollingSeedInvalid if not found
AbilityRollingSeed search_seed_in_range(AbilityRollingSeed seed_start, AbilityRollingSeed seed_end, Brand brand, Ability const *ability_sequence, size_t ability_sequence_count);
/// returns index of seed_ptr, or -1 if not found
size_t search_seed_in_list(AbilityRollingSeed const *seed_ptr, size_t seed_count, Brand brand, Ability const *ability_sequence, size_t ability_sequence_count);

#endif /* Header_h */
