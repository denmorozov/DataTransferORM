#import "CategoryModelNutritionCategoryMealsComporatorContext.h"


@interface CategoryModelNutritionCategoryMealsComporatorContext ()

@property (nonatomic, readwrite) FieldStringToMany *name;

@end

@implementation CategoryModelNutritionCategoryMealsComporatorContext

- (instancetype)init
{
	self = [super initWithName:@"meals"];
	if (self)
	{
		self.name = [[FieldStringToMany alloc] initWithName:@"meals.name"];
	}
	return self;
}


@end