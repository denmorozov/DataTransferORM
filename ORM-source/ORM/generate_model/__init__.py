from generate_model.save_methods import generateSaveMethod
from generate_model.save_methods import generateSaveDTOMethod
from generate_model.save_methods import generateSaveDTOMethodsNames
from generate_model.select_methods import generateSelectDTOMethod
from generate_model.select_methods import generateSelectDTOMethodsNames
from generate_model.select_methods import generateConvertToDTOMethod
from generate_model.templates import headerFileTemplate
from generate_model.templates import sourceFileTemplate
import glob
import os

def generateComporatorHeaderFile(modelName, struct):
    methods = []
    imports = []
    for field in struct.entity.fields:
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
        imports.append(type + '.h')
        methods.append('@property (nonatomic, readonly) {t} *{n};'.format(t = type, n = field.name))
    className = '{mn}{en}ComporatorContext'.format(mn = modelName, en = struct.entity.name)
    return headerFileTemplate(imports, [], className, methods)

def generateComporatorSourceFile(modelName, struct):
    declarationMethods = []
    for field in struct.entity.fields:
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
        declarationMethods.append('@property (nonatomic, readwrite) {t} *{n};'.format(t = type, n = field.name))
    className = '{mn}{en}ComporatorContext'.format(mn = modelName, en = struct.entity.name)
    
    initMethod = ''
    initMethod += '- (instancetype)init\n';
    initMethod += '{\n';
    initMethod += '\tself = [super init];\n';
    initMethod += '\tif (self)\n';
    initMethod += '\t{\n';
    for field in struct.entity.fields:
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
        initMethod += '\t\tself.{n} = [[{t} alloc] initWithName:@"{n}"];\n'.format(n = field.name, t = type)
    initMethod += '\t}\n';
    initMethod += 'return self;\n';
    initMethod += '}\n';
    methods = []
    methods.append(initMethod)
    return sourceFileTemplate([], declarationMethods, className, methods)

def generateHeaderFile(model):
    
    methods = []
    
    methods += generateSelectDTOMethodsNames(model)
    methods += generateSaveDTOMethodsNames(model)
    
    typedefs = []
    for struct in model.structs:
        typedefs.append('typedef Condition* (^{mn}{en}Comporator)({mn}{en}ComporatorContext *ctx);'.format(mn = model.name, en = struct.entity.name))
    
    imports = []
    imports.append('Condition.h')
    for struct in model.structs:
        imports.append('{mn}{en}ComporatorContext.h'.format(mn = model.name, en = struct.entity.name))
    for entityName in model.entities():
        imports.append(entityName + 'DTO.h')
    
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
    
    return sourceFileTemplate(imports, [], model.name, methods)

def createModel(directory, model):
    if not os.path.exists(directory):
        os.makedirs(directory)
    
    #create comporator context files
    for struct in model.structs:
        headerFileName = '{mn}{en}ComporatorContext.h'.format(mn = model.name, en = struct.entity.name)
        sourceFileName = '{mn}{en}ComporatorContext.m'.format(mn = model.name, en = struct.entity.name)
        file = open(os.path.join(directory, headerFileName), 'w+')
        file.write(generateComporatorHeaderFile(model.name, struct))
        file.close()
        file = open(os.path.join(directory, sourceFileName), 'w+')
        file.write(generateComporatorSourceFile(model.name, struct))
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


