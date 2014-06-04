#import <CoreData/CoreData.h>
@class FoodDTO;

@interface MealDTO : NSObject
@property (nonatomic, strong) NSManagedObjectID *objectID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *foods;
@end
