#import "NutritionModelMealCategoryComporatorContext.h"


@interface NutritionModelMealCategoryComporatorContext ()

@property (nonatomic, readwrite) FieldString *name;

@end

@implementation NutritionModelMealCategoryComporatorContext

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		self.name = [[FieldString alloc] initWithName:@"name"];
	}
return self;
}


@end