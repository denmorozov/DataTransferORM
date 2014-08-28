
#import "Condition.h"
#import "CategoryModelNutritionCategoryComporatorContext.h"
#import "CategoryModelNutritionCategoryDTO.h"
#import "CategoryModelNutritionCategoryMealsDTO.h"

typedef Condition* (^CategoryModelNutritionCategoryComporator)(CategoryModelNutritionCategoryComporatorContext *nutritioncategory);

@interface CategoryModel : NSObject

- (NSArray *)nutritioncategoryObjectsWithComporator:(CategoryModelNutritionCategoryComporator)comporator;
- (void)saveCategoryModelNutritionCategoryDTO:(CategoryModelNutritionCategoryDTO *)nutritioncategoryDTO;

@end