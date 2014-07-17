#import <CoreData/CoreData.h>

@interface NutritionModelMealFoodsDTO : NSObject
@property (nonatomic, strong) NSManagedObjectID *objectID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) float amount;


@end
