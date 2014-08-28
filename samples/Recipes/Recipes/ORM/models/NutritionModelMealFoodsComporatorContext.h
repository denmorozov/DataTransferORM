
#import "FieldStringToMany.h"
#import "FieldFloatToMany.h"
#import "ContextToMany.h"


@interface NutritionModelMealFoodsComporatorContext : ContextToMany

@property (nonatomic, readonly) FieldStringToMany *name;
@property (nonatomic, readonly) FieldFloatToMany *amount;

@end