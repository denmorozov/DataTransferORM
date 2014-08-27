#import "FieldString.h"

@interface FieldString ()

@property (nonatomic, strong) NSString *name;

@end

@implementation FieldString

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self)
	{
		self.name = name;
	}
	return self;
}

- (ConditionString *)anyEual:(NSString *)string
{
	return [[ConditionString alloc] initWithFieldName:self.name equalToString:string withOperation:ConditionAggregateOperationAny];
}
- (ConditionString *)allEqual:(NSString *)string
{
	return [[ConditionString alloc] initWithFieldName:self.name equalToString:string withOperation:ConditionAggregateOperationAll];
}
- (ConditionString *)noneEqual:(NSString *)string
{
	return [[ConditionString alloc] initWithFieldName:self.name equalToString:string withOperation:ConditionAggregateOperationNone];
}
- (ConditionString *)anyLike:(NSString *)pattern
{
	return [[ConditionString alloc] initWithFieldName:self.name likeToPattern:string withOperation:ConditionAggregateOperationAny];
}
- (ConditionString *)allLike:(NSString *)pattern
{
	return [[ConditionString alloc] initWithFieldName:self.name likeToPattern:string withOperation:ConditionAggregateOperationAll];
}
- (ConditionString *)noneLike:(NSString *)pattern
{
	return [[ConditionString alloc] initWithFieldName:self.name likeToPattern:string withOperation:ConditionAggregateOperationNone];
}
- (ConditionString *)anyNull
{
	return [[ConditionString alloc] initIsNULLWithFieldName:self.name withOperation:ConditionAggregateOperationAny];
}
- (ConditionString *)allNull
{
	return [[ConditionString alloc] initIsNULLWithFieldName:self.name withOperation:ConditionAggregateOperationAll];
}
- (ConditionString *)noneNull
{
	return [[ConditionString alloc] initIsNULLWithFieldName:self.name withOperation:ConditionAggregateOperationNone];
}

@end
