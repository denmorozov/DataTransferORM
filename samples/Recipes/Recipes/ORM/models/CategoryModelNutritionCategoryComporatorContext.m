#import "CategoryModelNutritionCategoryComporatorContext.h"


@interface CategoryModelNutritionCategoryComporatorContext ()

@property (nonatomic, readwrite) FieldString *name;

@end

@implementation CategoryModelNutritionCategoryComporatorContext

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