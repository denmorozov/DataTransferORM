#import <CoreData/CoreData.h>
@class Meal;

@interface Food : NSManagedObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) float amount;
@property (nonatomic, strong) NSSet *meals;
@end
