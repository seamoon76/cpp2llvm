## 配置环境

如果只要生成IR，不运行IR，跳过“方法1”小节，看配置环境方法(2)

### 方法1

操作系统：ubuntu 20.04

#### 安装 llvm

sudo apt-get install clang

sudo apt-get install llvm

我们在ubuntu20.04安装的llvm版本是10.0.0， clang 版本是 10.0.0-4ubuntu1

#### 安装 llvmlite

安装与llvm版本对应的llvmlite，对应表可以看[这里](https://pypi.org/project/llvmlite/)，例如查表知llvm10.0.0对应llvmlite 0.6.0

wget https://github.com/numba/llvmlite/archive/refs/tags/v0.36.0.tar.gz

tar -xvf v0.36.0.tar.gz

cd llvmlite-0.36.0/

sudo LLVM_CONFIG_PATH=/path/to/your/llvm/bin/llvm-config-3.8 python3 setup.py install

#### 安装 PLY

pip install PLY

### 方法2

如果只要生成IR，不运行IR

pip install PLY
pip install llvmlite

## 使用方法
### 词法分析

python ../src/lex.py [path of cpp file]

程序将输出token流，您可以用定向符把它存储到文本文件里：

python ../src/lex.py KMP.cpp > token.txt

### 生成语法树

python ../src/myYacc3.py 源文件路径 [目标存储路径(可选)]

不指定第三个参数的话，会存储到'源文件路径'_ast.json

### 生成llvm ir

python ../src/cpp2llvm.py 源文件路径 [目标存储路径(可选)]

不指定第三个参数的话，会存储到'源文件路径'_llvm.ll
要想同时生成语法树到json文件

python ../src/cpp2llvm.py 源文件路径 目标存储路径(必选) --show

AST的json格式文件会存储到'源文件路径'_ast.json

### 运行IR文件

lli [IR文件路径]


## 测试文件

+ arithmetic.cpp:四则运算计算，输入一个字符串 s（仅含数字 0-9 和符号+-*/()），输出该表达式的值
+ KMP.cpp:KMP 字符串匹配，输入一个字符串 s 和一个模板串 t，在 s 中匹配 t，将所有匹配上的子串的起始位置输出；若 s 中无 t，则输出’False’
+ myRank.cpp:排序，输入若干个整数（以空格间隔），程序会将它们按照从小到大的顺序排序后重新输出
+ palindrome.cpp:回文检测，输入一个字符串 s，程序会判断 s 是否为回文
+ test_preprocess.cpp：测试预处理#include和#define，程序将myheader.h中定义的fun函数include到test_preprocess.cpp中，打印调用fun的返回值666，打印#define将T都替换为6后的结果
+ myArray.cpp：验证对高维数组的支持，输入两个二维数组并计算乘积（每次输入4个数字，以空格间隔）。
+ scope.cpp：测试作用域机制
+ test_error_handling.cpp：测试检查语法错误，结果请见上一小节`错误处理`部分
+ test_semantic_error.cpp: 测试检查语义错误，结果请见上一小节`错误处理`部分

