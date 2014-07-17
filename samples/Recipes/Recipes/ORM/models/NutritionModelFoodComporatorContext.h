
#import "FieldString.h"
#import "FieldFloat.h"


@interface NutritionModelFoodComporatorContext : NSObject

@property (nonatomic, readonly) FieldString *name;
@property (nonatomic, readonly) FieldFloat *amount;

@end