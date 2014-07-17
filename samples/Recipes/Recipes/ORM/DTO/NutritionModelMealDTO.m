#import "NutritionModelMealDTO.h"

@interface NutritionModelMealDTO ()
{
	NSMutableArray *m_foods;
	NSArray *im_foods;
}

@end

@implementation NutritionModelMealDTO

- (id)init
{
	self = [super init];

	m_foods = [NSMutableArray new];
	im_foods = [NSArray new];

	return self;
}
- (void)addFoodsObject:(NutritionModelMealFoodsDTO *)object;
{
	[m_foods addObject:object];
	im_foods = m_foods.copy;
}
- (void)removeFoodsObject:(NutritionModelMealFoodsDTO *)object;
{
	[m_foods removeObject:object];
	im_foods = m_foods.copy;
}
- (void)setFoods:(NSArray *)objects;
{
	im_foods = objects.copy;
}
- (NSArray *)foods
{
	return im_foods;
}
@end
