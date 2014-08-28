#import "NutritionModelMealFoodsComporatorContext.h"


@interface NutritionModelMealFoodsComporatorContext ()

@property (nonatomic, readwrite) FieldStringToMany *name;
@property (nonatomic, readwrite) FieldFloatToMany *amount;

@end

@implementation NutritionModelMealFoodsComporatorContext

- (instancetype)init
{
	self = [super initWithName:@"foods"];
	if (self)
	{
		self.name = [[FieldStringToMany alloc] initWithName:@"foods.name"];
		self.amount = [[FieldFloatToMany alloc] initWithName:@"foods.amount"];
	}
	return self;
}


@end