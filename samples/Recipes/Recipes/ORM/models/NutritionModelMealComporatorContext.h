
#import "FieldString.h"
#import "NutritionModelMealFoodsComporatorContext.h"


@interface NutritionModelMealComporatorContext : NSObject

@property (nonatomic, readonly) FieldString *name;
@property (nonatomic, readonly) NutritionModelMealFoodsComporatorContext *foods;

@end