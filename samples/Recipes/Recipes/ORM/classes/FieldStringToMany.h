
#import "ConditionString.h"

@interface FieldStringToMany : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionString *)anyEual:(NSString *)string;
- (ConditionString *)allEqual:(NSString *)string;
- (ConditionString *)noneEqual:(NSString *)string;
- (ConditionString *)anyLike:(NSString *)pattern;
- (ConditionString *)allLike:(NSString *)pattern;
- (ConditionString *)noneLike:(NSString *)pattern;
- (ConditionString *)anyNull;
- (ConditionString *)allNull;
- (ConditionString *)noneNull;

@end