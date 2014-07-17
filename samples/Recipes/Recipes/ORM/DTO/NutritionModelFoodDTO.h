#import <CoreData/CoreData.h>

@interface NutritionModelFoodDTO : NSObject
@property (nonatomic, strong) NSManagedObjectID *objectID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) float amount;


@end
