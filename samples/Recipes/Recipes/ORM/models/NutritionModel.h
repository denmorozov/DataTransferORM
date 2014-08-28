
#import "Condition.h"
#import "NutritionModelMealComporatorContext.h"
#import "NutritionModelFoodComporatorContext.h"
#import "NutritionModelMealDTO.h"
#import "NutritionModelMealFoodsDTO.h"
#import "NutritionModelFoodDTO.h"

typedef Condition* (^NutritionModelMealComporator)(NutritionModelMealComporatorContext *meal);
typedef Condition* (^NutritionModelFoodComporator)(NutritionModelFoodComporatorContext *food);

@interface NutritionModel : NSObject

- (NSArray *)mealObjectsWithComporator:(NutritionModelMealComporator)comporator;
- (NSArray *)foodObjectsWithComporator:(NutritionModelFoodComporator)comporator;
- (void)saveNutritionModelMealDTO:(NutritionModelMealDTO *)mealDTO;
- (void)saveNutritionModelFoodDTO:(NutritionModelFoodDTO *)foodDTO;

@end