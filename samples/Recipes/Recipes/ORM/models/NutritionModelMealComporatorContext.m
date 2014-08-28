#import "NutritionModelMealComporatorContext.h"


@interface NutritionModelMealComporatorContext ()

@property (nonatomic, readwrite) FieldString *name;
@property (nonatomic, readwrite) NutritionModelMealFoodsComporatorContext *foods;

@end

@implementation NutritionModelMealComporatorContext

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		self.name = [[FieldString alloc] initWithName:@"self.name"];
		self.foods = [[NutritionModelMealFoodsComporatorContext alloc] init];
	}
	return self;
}


@end