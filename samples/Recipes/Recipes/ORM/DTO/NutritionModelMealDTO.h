#import <CoreData/CoreData.h>
@class NutritionModelMealFoodsDTO;

@interface NutritionModelMealDTO : NSObject
@property (nonatomic, strong) NSManagedObjectID *objectID;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSArray *foods;
- (void)addFoodsObject:(NutritionModelMealFoodsDTO *)object;
- (void)removeFoodsObject:(NutritionModelMealFoodsDTO *)object;

@end
