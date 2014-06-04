
#import "Condition.h"
#import "NutritionModelMealComporatorContext.h"
#import "NutritionModelFoodComporatorContext.h"
#import "MealDTO.h"
#import "FoodDTO.h"
#import "ADTO.h"
#import "BDTO.h"

typedef Condition* (^NutritionModelMealComporator)(NutritionModelMealComporatorContext *ctx);
typedef Condition* (^NutritionModelFoodComporator)(NutritionModelFoodComporatorContext *ctx);

@interface NutritionModel : NSObject

- (NSArray *)mealObjectsWithComporator:(NutritionModelMealComporator)comporator;
- (NSArray *)foodObjectsWithComporator:(NutritionModelFoodComporator)comporator;
- (void)saveMealDTO:(MealDTO *)mealDTO;
- (void)saveFoodDTO:(FoodDTO *)foodDTO;
- (void)createMealDTO:(MealDTO *)mealDTO;
- (void)createFoodDTO:(FoodDTO *)foodDTO;

@end