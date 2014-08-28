#import "CategoryModelNutritionCategoryComporatorContext.h"


@interface CategoryModelNutritionCategoryComporatorContext ()

@property (nonatomic, readwrite) FieldString *name;
@property (nonatomic, readwrite) CategoryModelNutritionCategorySubcategoriesComporatorContext *subcategories;
@property (nonatomic, readwrite) CategoryModelNutritionCategoryMealsComporatorContext *meals;
@property (nonatomic, readwrite) CategoryModelNutritionCategoryParentcategoryComporatorContext *parentcategory;

@end

@implementation CategoryModelNutritionCategoryComporatorContext

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		self.name = [[FieldString alloc] initWithName:@"self.name"];
		self.subcategories = [[CategoryModelNutritionCategorySubcategoriesComporatorContext alloc] init];
		self.meals = [[CategoryModelNutritionCategoryMealsComporatorContext alloc] init];
		self.parentcategory = [[CategoryModelNutritionCategoryParentcategoryComporatorContext alloc] init];
	}
	return self;
}


@end