from generate_model.save_methods import generateSaveMethod
from generate_model.save_methods import generateSaveDTOMethod
from generate_model.save_methods import generateSaveDTOMethodsNames
from generate_model.select_methods import generateSelectDTOMethod
from generate_model.select_methods import generateSelectDTOMethodsNames
from generate_model.select_methods import generateConvertToDTOMethod
from generate_model.templates import headerFileTemplate
from generate_model.templates import sourceFileTemplate
from helpers import upperCaseForFirstSymbol
import glob
import os

class ComporatorContextDef:
    def __init__(self, name, className, property, inverse):
        self.name = name
        self.className = className
        self.property = property
        self.inverse = inverse

def getComporatorContextDefs(name, struct):
    
    comporatorContextDefs = []
    
    StructName = upperCaseForFirstSymbol(struct.entity.name)
    
    relationshipProperties = struct.relationshipProperties()
    for property in relationshipProperties:
        relationship = property.relationship
        RelationshipName = upperCaseForFirstSymbol(relationship.name)
        className = '{n}{sn}{rn}ComporatorContext'.format(n = name, rn = RelationshipName, sn = StructName)
        comporatorContextDefs.append(ComporatorContextDef(relationship.name, className, property, False))
    
    inverseProperties = struct.inverseProperties()
    for property in inverseProperties:
        relationship = struct.entity.relationshipByName(property.relationship.inverse)
        RelationshipName = upperCaseForFirstSymbol(relationship.name)
        className = '{n}{sn}{rn}ComporatorContext'.format(n = name, rn = RelationshipName, sn = StructName)
        comporatorContextDefs.append(ComporatorContextDef(relationship.name, className, property, True))
    
    return comporatorContextDefs

def fieldPropertiesForComporator(entity, properties, toMany):
    initProperties = []
    declarationProperties = []
    imports = []
    for property in properties:
        field = entity.fieldByName(property.name)
        if field == None:
            continue
        type = None
        if field.type == 'string':
            type = 'FieldString'
        if field.type == 'float':
            type = 'FieldFloat'
        if field.type == 'boolean':
            type = 'FieldBoolean'
        if field.type == 'date':
            type = 'FieldDate'
        if field.type == 'double':
            type = 'FieldDouble'
        if field.type == 'integer32':
            type = 'FieldInteger32'
        if field.type == 'integer64':
            type = 'FieldInteger64'
        if type == None:
            continue
        if toMany == True:
            type += 'ToMany'
        imports.append(type + '.h')
        declarationProperties.append('@property (nonatomic, readonly) {t} *{n};'.format(t = type, n = field.name))
    return [imports, declarationProperties]

def fieldPropertiesForComporatorSource(entity, properties, parentName, toMany):
    initProperties = []
    declarationProperties = []
    imports = []
    for property in properties:
        field = entity.fieldByName(property.name)
        if field == None:
            continue
        type = None
        if field.type == 'string':
            type = 'FieldString'
        if field.type == 'float':
            type = 'FieldFloat'
        if field.type == 'boolean':
            type = 'FieldBoolean'
        if field.type == 'date':
            type = 'FieldDate'
        if field.type == 'double':
            type = 'FieldDouble'
        if field.type == 'integer32':
            type = 'FieldInteger32'
        if field.type == 'integer64':
            type = 'FieldInteger64'
        if type == None:
            continue
        if toMany == True:
            type += 'ToMany'
        imports.append(type + '.h')
        declarationProperties.append('@property (nonatomic, readwrite) {t} *{n};'.format(t = type, n = field.name))
        initProperties.append('\t\tself.{n} = [[{t} alloc] initWithName:@"{pn}.{n}"];'.format(t = type, n = field.name, pn = parentName))
    return [imports, declarationProperties, initProperties]

def generateComporatorHeadersFiles(name, struct):
    
    result = {}
    
    comporatorContextDefs = getComporatorContextDefs(name, struct)
    
    imports, declarationProperties = fieldPropertiesForComporator(struct.entity, struct.properties, False)
    for comporatorContextDef in comporatorContextDefs:
        imports.append('{cn}.h'.format(cn = comporatorContextDef.className))
        declarationProperties.append('@property (nonatomic, readonly) {cn} *{pn};'.format(pn = comporatorContextDef.name, cn = comporatorContextDef.className))
    StructName = upperCaseForFirstSymbol(struct.entity.name)
    className = '{n}{sn}ComporatorContext'.format(n = name, sn = StructName)
    result[className] = headerFileTemplate(imports, [], className, declarationProperties)
    
    for c in comporatorContextDefs:
        relationshipType = c.property.relationship.type
        if c.inverse == True:
            relationshipType = c.property.relationship.entity.relationshipByName(c.property.relationship.inverse).type
        imports, declarationProperties = fieldPropertiesForComporator(c.property.relationship.entity, c.property.properties, (relationshipType == 'toMany') )
        parentClass = '';
        if relationshipType == 'toMany':
            parentClass = 'ContextToMany'
        elif relationshipType == 'toOne':
            parentClass = 'ContextToOne'
        imports.append(parentClass + '.h')
        result[c.className] = headerFileTemplate(imports, [], c.className, declarationProperties, parentClass)
    
    return result

def generateComporatorSourceFiles(name, struct):
    
    result = {}
    
    initMethod = ''
    initMethod += '- (instancetype)init\n'
    initMethod += '{{\n'
    initMethod += '\tself = [super {init}];\n'
    initMethod += '\tif (self)\n'
    initMethod += '\t{{\n'
    initMethod += '{ip}\n'
    initMethod += '\t}}\n';
    initMethod += '\treturn self;\n'
    initMethod += '}}\n'
    
    comporatorContextDefs = getComporatorContextDefs(name, struct)
    
    imports, declarationProperties, initProperties = fieldPropertiesForComporatorSource(struct.entity, struct.properties, 'self', False)
    for comporatorContextDef in comporatorContextDefs:
        declarationProperties.append('@property (nonatomic, readwrite) {cn} *{pn};'.format(cn = comporatorContextDef.className, pn = comporatorContextDef.name))
        initProperties.append('\t\tself.{pn} = [[{cn} alloc] init];'.format(cn = comporatorContextDef.className, pn = comporatorContextDef.name))
    StructName = upperCaseForFirstSymbol(struct.entity.name)
    className = '{n}{sn}ComporatorContext'.format(n = name, sn = StructName)
    
    methods = [initMethod.format(ip = '\n'.join(initProperties), init = 'init')]
    
    result[className] = sourceFileTemplate([], declarationProperties, className, methods)
    
    for c in comporatorContextDefs:
        imports, declarationProperties, initProperties = fieldPropertiesForComporatorSource(c.property.relationship.entity, c.property.properties, c.name, c.property.relationship.type == 'toMany')
        methods = [initMethod.format(ip = '\n'.join(initProperties), init = 'initWithName:@"' + c.name + '"')]
        result[c.className] = sourceFileTemplate([], declarationProperties, c.className, methods)
    
    return result

def generateHeaderFile(model):
    
    methods = []
    
    methods += generateSelectDTOMethodsNames(model)
    methods += generateSaveDTOMethodsNames(model)
    
    typedefs = []
    for struct in model.structs:
        typedefs.append('typedef Condition* (^{mn}{en}Comporator)({mn}{en}ComporatorContext *{vn});'.format(mn = model.name, en = struct.entity.name, vn = struct.entity.name.lower()))
    
    imports = []
    imports.append('Condition.h')
    for struct in model.structs:
        imports.append('{mn}{en}ComporatorContext.h'.format(mn = model.name, en = struct.entity.name))
    for struct in model.structs:
        classesDefs = struct.classesDefs()
        for d in classesDefs:
            DTOName = d.name
            imports.append(DTOName + 'DTO.h')
    
    return headerFileTemplate(imports, typedefs, model.name, methods)

def generateSourceFile(model):
    
    methods = []
    
    methods.append(generateConvertToDTOMethod(model))
    methods.append(generateSelectDTOMethod(model))
    methods.append(generateSaveMethod(model))
    methods.append(generateSaveDTOMethod(model))
    
    imports = []
    imports.append('DataManager.h')
    for entityName in model.entities():
        imports.append(entityName + '.h')
    imports.append('ModelContext.h')
    
    return sourceFileTemplate(imports, [], model.name, methods)

def createModel(directory, model):
    if not os.path.exists(directory):
        os.makedirs(directory)
    
    #create comporator context files
    for struct in model.structs:
        headersFiles = generateComporatorHeadersFiles(model.name, struct)
        for className, content in headersFiles.items():
            headerFileName = '{cn}.h'.format(cn = className)
            file = open(os.path.join(directory, headerFileName), 'w+')
            file.write(content)
            file.close()
        sourceFiles = generateComporatorSourceFiles(model.name, struct)
        for className, content in sourceFiles.items():
            sourceFileName = '{cn}.m'.format(cn = className)
            file = open(os.path.join(directory, sourceFileName), 'w+')
            file.write(content)
            file.close()
    
    #create model files
    headerFileName = '{mn}.h'.format(mn = model.name)
    sourceFileName = '{mn}.m'.format(mn = model.name)
    file = open(os.path.join(directory, headerFileName), 'w+')
    file.write(generateHeaderFile(model))
    file.close()
    file = open(os.path.join(directory, sourceFileName), 'w+')
    file.write(generateSourceFile(model))
    file.close()
    
    return ''


