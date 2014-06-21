from generate_model.templates import methodTemplate

class ConvertToDTOMethodDef:
    def __init__(self, name, entity, properties, id):
        self.name = name
        self.entity = entity
        self.properties = properties
        self.id = id

def methodDefById(defs, id):
    for d in defs:
        if d.id == id:
            return d
    return None

def makeMethodsDefs(name, entity, properties, id):
    result = []
    result.append(ConvertToDTOMethodDef(name, entity, properties, id))
    for property in properties:
        if property.relationship != None:
            subname = None if property.id != None and len(property.properties) == 0 else name + property.relationship.name
            result += makeMethodsDefs(subname, property.relationship.entity, property.properties, property.id)
    return result;

def generateConvertToDTOMethod(model):
    
    methodsDefs = makeMethodsDefs(model.name + model.structs[0].entity.name, model.structs[0].entity, model.structs[0].properties, model.structs[0].id)
    
    lines = []
    
    for d in methodsDefs:
        if d.name != None:
            lines.append('- ({n}DTO *){n}With{e}:({e} *){ev}'.format(n = d.name, e = d.entity.name, ev = d.entity.name.lower()))
            lines.append('{')
            lines.append('\t{n}DTO *{ev}DTO = [{n}DTO new];'.format(n = d.name, ev = d.entity.name.lower()))
            for property in d.properties:
                if property.relationship == None:
                    lines.append('\t{ev}DTO.{pn} = {ev}.{pn};'.format(n = d.name, pn = property.name, ev = d.entity.name.lower()))
                elif property.relationship != None and property.relationship.type == 'toMany':
                    lines.append('\tfor ({se} *{sev} in {ev}.{pn})'.format(se = property.relationship.entity.name, sev = property.relationship.entity.name.lower(), ev = d.entity.name.lower(), pn = property.name))
                    lines.append('\t{')
                    if property.id != None and len(property.properties) == 0:
                        dd = methodDefById(methodsDefs, property.id)
                        lines.append('\t\t{sn}DTO *sub{sev}DTO = [self {sn}With{se}:{sev}];'.format(sn = dd.name, sev = dd.entity.name.lower(), se = dd.entity.name))
                        lines.append('\t\t[{ev}DTO add{pn}object:sub{sev}DTO];'.format(ev = d.entity.name.lower(), sev = dd.entity.name.lower(), pn = property.name))
                    else:
                        lines.append('\t\t{sn}DTO *sub{sev}DTO = [self {sn}With{se}:{sev}];'.format(sn = d.name + property.name, sev = property.relationship.entity.name.lower(), se = property.relationship.entity.name))
                        lines.append('\t\t[{ev}DTO add{pn}object:sub{sev}DTO];'.format(ev = d.entity.name.lower(), sev = property.relationship.entity.name.lower(), pn = property.name))
                    lines.append('\t}')
                elif property.relationship != None and property.relationship.type == 'toOne':
                    if property.id != None and len(property.properties) == 0:
                        dd = methodDefById(methodsDefs, property.id)
                        lines.append('\t{ev}DTO.{sev} = [self {sn}With{se}:{sev}];'.format(ev = d.entity.name.lower(), sn = dd.name, sev = dd.entity.name.lower(), se = dd.entity.name))
                    else:
                        lines.append('\t{ev}DTO.{sev} = [self {sn}With{se}:{ev}.{sev}];'.format(ev = d.entity.name.lower(), sn = d.name + property.name, sev = property.relationship.entity.name.lower(), se = property.relationship.entity.name))
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
        tryBlock.append('\tresult = [self {v}ObjectsConvertToDTO:array];'.format(v = var))
        tryBlock.append('}')
        
        exceptionBlock = ['NSLog(@"%@", e);']
        finallyBlock = []
        
        methodName = '- (NSArray *){v}ObjectsWithComporator:({mn}{en}Comporator)comporator'.format(mn = model.name, v = var, en = entity)
        
        methods.append(methodName + '\n' + methodTemplate(['NSArray *result = nil;'], tryBlock, exceptionBlock, finallyBlock, ['return result;']))
    return '\n'.join(methods)
