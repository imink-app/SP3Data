#ifndef header_h
#define header_h

#include <stdbool.h>
#include <stdint.h>

typedef uint32_t SCRollingSeed;

typedef enum : uint8_t {
    SCAbility_MainInk_Save,
    SCAbility_SubInk_Save,
    SCAbility_InkRecovery_Up,
    SCAbility_HumanMove_Up,
    SCAbility_SquidMove_Up,
    SCAbility_SpecialIncrease_Up,
    SCAbility_RespawnSpecialGauge_Save,
    SCAbility_SpecialSpec_Up,
    SCAbility_RespawnTime_Save,
    SCAbility_JumpTime_Save,
    SCAbility_SubSpec_Up,
    SCAbility_OpInkEffect_Reduction,
    SCAbility_SubEffect_Reduction,
    SCAbility_Action_Up,
    
    SCAbility_Count,
} SCAbility;

typedef enum : uint8_t {
    SCBrand_SquidForce,
    SCBrand_Zink,
    SCBrand_Krak_On,
    SCBrand_Rockenberg,
    SCBrand_Zekko,
    SCBrand_Forge,
    SCBrand_Firefin,
    SCBrand_Skalop,
    SCBrand_Splash_Mob,
    SCBrand_Inkline,
    SCBrand_Tentatek,
    SCBrand_Takoroka,
    SCBrand_Annaki,
    SCBrand_Enperry,
    SCBrand_Toni_Kensa,
    SCBrand_Barazushi,
    SCBrand_Emberz,
    SCBrand_Grizzco,
    SCBrand_Cuttlegear,
    SCBrand_Amiibo,
    
    SCBrand_Count
} SCBrand;

#define SCAbility_NoDrink UINT8_MAX
#define SCRollingSeed_Invalid 0

typedef struct {
    SCAbility ability;
    SCRollingSeed seed;
} RollingResult;

int8_t brand_code(SCBrand brand);
SCRollingSeed advance_seed(SCRollingSeed x32);
RollingResult get_ability(SCRollingSeed seed, SCBrand brand, SCAbility drink);
SCRollingSeed search_seed(SCRollingSeed seed_start, SCRollingSeed seed_end, SCBrand brand, SCAbility const *ability_sequence, int ability_sequence_count);

#endif /* Header_h */
