from generate_model.templates import methodTemplate
from helpers import upperCaseForFirstSymbol

def generateConvertToDTOMethod(model):
    lines = []
    for struct in model.structs:
        classesDefs = struct.classesDefs()
        for d in classesDefs:
            DTOName = d.name
            entity = d.entity.name
            entityVar = entity.lower()
            lines.append('- ({n}DTO *){n}With{e}:({e} *){ev} withContext:(ModelContext *)ctx'.format(n = DTOName, e = entity, ev = entityVar))
            lines.append('{')
            lines.append('\t' + 'if ([ctx containsWithObjectID:{ev}.objectID withClass:{n}DTO.class])'.format(n = DTOName, ev = entityVar))
            lines.append('\t' + '{')
            lines.append('\t\t' + 'return [ctx objectWithObjectID:{ev}.objectID withClass:{n}DTO.class];'.format(n = DTOName, ev = entityVar))
            lines.append('\t' + '}')
            lines.append('\t' + '{n}DTO *dto = [{n}DTO new];'.format(n = DTOName))
            lines.append('\t' + '[ctx addObject:dto withObjectID:{ev}.objectID];'.format(ev = entityVar))
            lines.append('\t' + 'dto.objectID = {ev}.objectID;'.format(ev = entityVar))
            for property in d.properties:
                subDTOName = d.name + upperCaseForFirstSymbol(property.name)
                subEntity = property.relationship.entity.name if property.relationship != None else None
                subEntityVar = 'sub' + subEntity.lower() if subEntity != None else None
                propertyName = property.name
                PropertyName = upperCaseForFirstSymbol(propertyName)
                if property.id != None and len(property.properties) == 0:
                    dd = struct.classDefById(property.id)
                    subDTOName = dd.name
                if property.relationship == None:
                    lines.append('\t' + 'dto.{pn} = {ev}.{pn};'.format(pn = property.name, ev = entityVar))
                elif property.relationship != None and property.relationship.type == 'toMany':
                    lines.append('\t' + 'for ({se} *{sev} in {ev}.{pn})'.format(se = subEntity, sev = subEntityVar, ev = entityVar, pn = propertyName))
                    lines.append('\t' + '{')
                    lines.append('\t\t' + '{sn}DTO *sub{sev}DTO = [self {sn}With{se}:{sev} withContext:ctx];'.format(sn = subDTOName, sev = subEntityVar, se = subEntity))
                    lines.append('\t\t' + '[dto add{pn}Object:sub{sev}DTO];'.format(sev = subEntityVar, pn = PropertyName))
                    lines.append('\t' + '}')
                elif property.relationship != None and property.relationship.type == 'toOne':
                    lines.append('\t' + 'dto.{pn} = [self {sn}With{se}:{ev}.{pn} withContext:ctx];'.format(ev = entityVar, sn = subDTOName, pn = propertyName, se = subEntity))
            lines.append('\t' + 'return dto;')
            lines.append('}')
    
    return '\n'.join(lines)

def generateSelectDTOMethodsNames(model):
    methodNames = []
    for struct in model.structs:
        var = struct.entity.name.lower()
        entity = struct.entity.name
        methodNames.append('- (NSArray *){v}ObjectsWithComporator:({mn}{en}Comporator)comporator;'.format(mn = model.name, v = var, en = entity))
    return methodNames

def generateSelectDTOMethod(model):
    methods = []
    for struct in model.structs:
        entity = struct.entity.name
        var = struct.entity.name.lower()
        
        tryBlock = []
        tryBlock.append('NSFetchRequest *request = [[NSFetchRequest alloc] init];')
        tryBlock.append('')
        tryBlock.append('NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"{e}" inManagedObjectContext:context];'.format(e = entity, v = var))
        tryBlock.append('[request setEntity:entityDescription];')
        tryBlock.append('')
        tryBlock.append('if (comporator != nil)')
        tryBlock.append('{')
        tryBlock.append('\t{mn}{en}ComporatorContext *comporatorContext = [{mn}{en}ComporatorContext new];'.format(mn = model.name, en = entity))
        tryBlock.append('\tNSPredicate *predicate = [comporator(comporatorContext) predicate];'.format(v = var))
        tryBlock.append('\t[request setPredicate:predicate];')
        tryBlock.append('}')
        tryBlock.append('')
        
        tryBlock.append('NSError *error = nil;')
        tryBlock.append('NSArray *array = [context executeFetchRequest:request error:&error];')
        tryBlock.append('if (array == nil)')
        tryBlock.append('{')
        tryBlock.append('\t//Deal with error...')
        tryBlock.append('}')
        tryBlock.append('else')
        tryBlock.append('{')
        tryBlock.append('\tModelContext *ctx = [ModelContext new];')
        tryBlock.append('\tfor ({e} *{ev} in array)'.format(e = entity, ev = var))
        tryBlock.append('\t{')
        tryBlock.append('\t\t[result addObject:[self {mn}{e}With{e}:{ev} withContext:ctx]];'.format(e = entity, mn = model.name, ev = var))
        tryBlock.append('\t}')
        tryBlock.append('}')
        
        exceptionBlock = ['NSLog(@"%@", e);']
        finallyBlock = []
        
        methodName = '- (NSArray *){v}ObjectsWithComporator:({mn}{en}Comporator)comporator'.format(mn = model.name, v = var, en = entity)
        
        methods.append(methodName + '\n' + methodTemplate(['NSMutableArray *result = [NSMutableArray new];'], tryBlock, exceptionBlock, finallyBlock, ['return result.copy;']))
    return '\n'.join(methods)
