#import "ConditionInteger32.h"

@interface ConditionInteger32 ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionInteger32

- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toInt32:(int32_t)value
{
	return [self initWithFieldName:fieldName withOperator:operator toInt32:value withOperation:ConditionAggregateOperationNo];
}

- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toInt32:(int32_t)value withOperation:(ConditionAggregateOperation)operation
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ %@ %@ %i)", [self stringOperation:operation], fieldName, [self stringOperator:operator], value];
	}
	
	return self;
}

@end