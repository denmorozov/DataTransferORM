
#import "FieldString.h"
#import "CategoryModelNutritionCategorySubcategoriesComporatorContext.h"
#import "CategoryModelNutritionCategoryMealsComporatorContext.h"
#import "CategoryModelNutritionCategoryParentcategoryComporatorContext.h"


@interface CategoryModelNutritionCategoryComporatorContext : NSObject

@property (nonatomic, readonly) FieldString *name;
@property (nonatomic, readonly) CategoryModelNutritionCategorySubcategoriesComporatorContext *subcategories;
@property (nonatomic, readonly) CategoryModelNutritionCategoryMealsComporatorContext *meals;
@property (nonatomic, readonly) CategoryModelNutritionCategoryParentcategoryComporatorContext *parentcategory;

@end