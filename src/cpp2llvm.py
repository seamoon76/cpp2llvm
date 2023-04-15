import sys
from generator import Coder
from myYacc import parser


def main():
    import sys
    from preprocess import preprocess
    import json
    coder = Coder()

    if len(sys.argv) > 1:
        file_data, ok = preprocess(sys.argv[1])
        if not ok:
            print('preprocess error')
        else:
            ast_raw = parser.parse(file_data)
            llvm_code=coder.transform_ast2code(ast_raw)
            ast_save_path = sys.argv[1][:-len('.cpp')] + '_ast.json'
            if len(sys.argv) == 4 and sys.argv[3]=='--show':
                ast_dict=ast_raw.build_tree()
                tree = json.dumps(ast_dict, indent=4)
                with open(ast_save_path,'w+',encoding='utf-8') as ast_f:
                    ast_f.write(str(tree))
                print("ast tree is saved at {}.".format(ast_save_path))

            save_path = sys.argv[1][:-len('.cpp')] + '_llvm.ll'
            if len(sys.argv) > 2:
                save_path = sys.argv[2]

            # f.write(buf)
            print(llvm_code,file=open(save_path, 'w+'))
            with open(save_path, 'r',encoding='utf-8') as f:
                lines = f.readlines()
            with open(save_path, 'w',encoding='utf-8') as w:
                for l in lines[4:]:
                    w.write(l)
            # print(llvm_code)
            print("results is saved at {}.".format(save_path))

    else:
        print("please input c++ file path")


if __name__ == '__main__':
    main()
