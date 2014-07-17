#import "NutritionModelFoodComporatorContext.h"


@interface NutritionModelFoodComporatorContext ()

@property (nonatomic, readwrite) FieldString *name;
@property (nonatomic, readwrite) FieldFloat *amount;

@end

@implementation NutritionModelFoodComporatorContext

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		self.name = [[FieldString alloc] initWithName:@"name"];
		self.amount = [[FieldFloat alloc] initWithName:@"amount"];
	}
return self;
}


@end