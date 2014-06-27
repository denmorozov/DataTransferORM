from generate_model.templates import methodTemplate

def generateConvertToDTOMethod(model):
    lines = []
    for struct in model.structs:
        classesDefs = struct.classesDefs()
        for d in classesDefs:
            lines.append('- ({n}DTO *){n}With{e}:({e} *){ev} withContext:(ModelContext *)ctx'.format(n = d.name, e = d.entity.name, ev = d.entity.name.lower()))
            lines.append('{')
            lines.append('\tif ([ctx containsWithObjectID:{ev}.objectID withClass:{n}DTO.class])'.format(n = d.name, ev = d.entity.name.lower()))
            lines.append('\t{')
            lines.append('\t\treturn [ctx objectWithObjectID:{ev}.objectID withClass:{n}DTO.class];'.format(n = d.name, ev = d.entity.name.lower()))
            lines.append('\t}')
            lines.append('\t{n}DTO *{ev}DTO = [{n}DTO new];'.format(n = d.name, ev = d.entity.name.lower()))
            lines.append('\t[ctx addObject:{ev}DTO];'.format(ev = d.entity.name.lower()))
            for property in d.properties:
                if property.relationship == None:
                    lines.append('\t{ev}DTO.{pn} = {ev}.{pn};'.format(n = d.name, pn = property.name, ev = d.entity.name.lower()))
                elif property.relationship != None and property.relationship.type == 'toMany':
                    lines.append('\tfor ({se} *{sev} in {ev}.{pn})'.format(se = property.relationship.entity.name, sev = property.relationship.entity.name.lower(), ev = d.entity.name.lower(), pn = property.name))
                    lines.append('\t{')
                    if property.id != None and len(property.properties) == 0:
                        dd = struct.classDefById(property.id)
                        lines.append('\t\t{sn}DTO *sub{sev}DTO = [self {sn}With{se}:{sev} withContext:ctx];'.format(sn = dd.name, sev = dd.entity.name.lower(), se = dd.entity.name))
                        lines.append('\t\t[{ev}DTO add{pn}object:sub{sev}DTO];'.format(ev = d.entity.name.lower(), sev = dd.entity.name.lower(), pn = property.name))
                    else:
                        lines.append('\t\t{sn}DTO *sub{sev}DTO = [self {sn}With{se}:{sev} withContext:ctx];'.format(sn = d.name + property.name, sev = property.relationship.entity.name.lower(), se = property.relationship.entity.name))
                        lines.append('\t\t[{ev}DTO add{pn}object:sub{sev}DTO];'.format(ev = d.entity.name.lower(), sev = property.relationship.entity.name.lower(), pn = property.name))
                    lines.append('\t}')
                elif property.relationship != None and property.relationship.type == 'toOne':
                    if property.id != None and len(property.properties) == 0:
                        dd = struct.classDefById(property.id)
                        lines.append('\t{ev}DTO.{sev} = [self {sn}With{se}:{sev} withContext:ctx];'.format(ev = d.entity.name.lower(), sn = dd.name, sev = dd.entity.name.lower(), se = dd.entity.name))
                    else:
                        lines.append('\t{ev}DTO.{sev} = [self {sn}With{se}:{ev}.{sev} withContext:ctx];'.format(ev = d.entity.name.lower(), sn = d.name + property.name, sev = property.relationship.entity.name.lower(), se = property.relationship.entity.name))
            lines.append('\treturn {ev}DTO;'.format(ev = d.entity.name.lower()))
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
