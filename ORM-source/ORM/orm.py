import glob
import os
import schema_parser
import generate_model
import generate_data_manager
import distutils.core
import sys
import getopt

def main(argv):
    schemaPath = 'E:\\py\\ORM\\schema.xml'
    filesPath = 'E:\\py\\ORM\\files'
#    try:
#       opts, args = getopt.getopt(argv, "hs:d:", ["schema=","directory="])
#    except getopt.GetoptError:
#       print('orm.py --schema <schemapath> --directory <dirpath>')
#       sys.exit(2)
#    if len(opts) == 0:
#        print('orm.py --schema <schemapath> --directory <dirpath>')
#    else:
#        for opt, arg in opts:
#           if opt == '-h':
#              print ('orm.py --schema <schemapath> --directory <dirpath>')
#              sys.exit()
#           elif opt in ["--schema", "-s"]:
#              schemaPath = arg
#           elif opt in ["--directory", "-d"]:
#              filesPath = arg
        
    currDir = os.path.dirname(__file__)
    classesFromPath = os.path.join(currDir, 'classes')
    classesToPath = os.path.join(filesPath , 'classes')
        
    distutils.dir_util.copy_tree(classesFromPath, classesToPath)
        
    entities, models = schema_parser.parse(schemaPath)
        
    generate_data_manager.create_data_manager(entities, filesPath)
        
    schema_parser.createDTOEntities(entities, os.path.join(filesPath , 'DTO'))
    schema_parser.createEntities(entities, os.path.join(filesPath , 'entities'))
        
    for model in models:
        generate_model.createModel(os.path.join(filesPath , 'models'), model)

if __name__ == "__main__":
    main(sys.argv[1:])

