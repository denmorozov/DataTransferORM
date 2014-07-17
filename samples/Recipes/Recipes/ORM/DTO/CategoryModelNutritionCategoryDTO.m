#import "CategoryModelNutritionCategoryDTO.h"

@interface CategoryModelNutritionCategoryDTO ()
{
	NSMutableArray *m_subcategories;
	NSArray *im_subcategories;
	NSMutableArray *m_meals;
	NSArray *im_meals;
}

@end

@implementation CategoryModelNutritionCategoryDTO

- (id)init
{
	self = [super init];

	m_subcategories = [NSMutableArray new];
	im_subcategories = [NSArray new];

	m_meals = [NSMutableArray new];
	im_meals = [NSArray new];

	return self;
}
- (void)addSubcategoriesObject:(CategoryModelNutritionCategoryDTO *)object;
{
	[m_subcategories addObject:object];
	im_subcategories = m_subcategories.copy;
}
- (void)removeSubcategoriesObject:(CategoryModelNutritionCategoryDTO *)object;
{
	[m_subcategories removeObject:object];
	im_subcategories = m_subcategories.copy;
}
- (void)setSubcategories:(NSArray *)objects;
{
	im_subcategories = objects.copy;
}
- (NSArray *)subcategories
{
	return im_subcategories;
}
- (void)addMealsObject:(CategoryModelNutritionCategoryMealsDTO *)object;
{
	[m_meals addObject:object];
	im_meals = m_meals.copy;
}
- (void)removeMealsObject:(CategoryModelNutritionCategoryMealsDTO *)object;
{
	[m_meals removeObject:object];
	im_meals = m_meals.copy;
}
- (void)setMeals:(NSArray *)objects;
{
	im_meals = objects.copy;
}
- (NSArray *)meals
{
	return im_meals;
}
@end
