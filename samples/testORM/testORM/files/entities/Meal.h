#import <CoreData/CoreData.h>
@class Food;

@interface Meal : NSManagedObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSSet *foods;
@end
