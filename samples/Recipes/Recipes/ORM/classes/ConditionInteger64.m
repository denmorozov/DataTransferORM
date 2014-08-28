#import "ConditionInteger64.h"

@interface ConditionInteger64 ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionInteger64

- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toInt64:(int64_t)value
{
	return [self initWithFieldName:fieldName withOperator:operator toInt64:value withOperation:ConditionAggregateOperationNo];
}

- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toInt64:(int64_t)value withOperation:(ConditionAggregateOperation)operation;
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ %@ %@ %lli)", [self stringOperation:operation], fieldName, [self stringOperator:operator], value];
	}
	
	return self;
}

@end