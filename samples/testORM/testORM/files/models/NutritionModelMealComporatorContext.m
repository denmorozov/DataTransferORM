#import "NutritionModelMealComporatorContext.h"


@interface NutritionModelMealComporatorContext ()

@property (nonatomic, readwrite) FieldString *name;

@end

@implementation NutritionModelMealComporatorContext

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