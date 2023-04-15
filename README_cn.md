# cpp2llvm

���� ������Ȼ ������� 

## ѡ��˵��

Դ����C++��Ŀ������LLVM IR��ʹ��python-lex-yacc����ʵ��C++�Ĳ����﷨��

## ���û���

������UTF-8���롣���ֻҪ����IR��������IR������������1��С�ڣ������û�������(2)
### ����1
����ϵͳ��ubuntu 20.04
#### ��װ llvm
```
sudo apt-get install clang
```

```
sudo apt-get install llvm
```

������ubuntu20.04��װ��llvm�汾��10.0.0�� clang �汾�� 10.0.0-4ubuntu1 

#### ��װ llvmlite

��װ��llvm�汾��Ӧ��llvmlite����Ӧ����Կ�[����](https://pypi.org/project/llvmlite/)��������֪llvm10.0.0��Ӧllvmlite 0.6.0

```
wget https://github.com/numba/llvmlite/archive/refs/tags/v0.36.0.tar.gz
```

```
tar -xvf v0.36.0.tar.gz 
```

```
cd llvmlite-0.36.0/
```

```
sudo LLVM_CONFIG_PATH=/path/to/your/llvm/bin/llvm-config-3.8 python3 setup.py install
```

#### ��װ PLY

```
pip install PLY
```

### ����2
���ֻҪ����IR��������IR
```bash
pip install PLY
pip install llvmlite
```
## ʹ�÷���
+ �ʷ�����

``` bash
python src/lex.py [path of cpp file]
```

�������token�����������ö���������洢���ı��ļ��

``` bash
python src/lex.py KMP.cpp > token.txt
```
+ �����﷨��
```bash
python src/myYacc3.py Դ�ļ�·�� [Ŀ��洢·��(��ѡ)]
```
��ָ�������������Ļ�����洢��'Դ�ļ�·��'_ast.json
+ ����llvm ir
```bash
python src/cpp2llvm.py Դ�ļ�·�� [Ŀ��洢·��(��ѡ)]
```
��ָ�������������Ļ�����洢��'Դ�ļ�·��'_llvm.ll
Ҫ��ͬʱ�����﷨����json�ļ�

```bash
python src/cpp2llvm.py Դ�ļ�·�� Ŀ��洢·��(��ѡ) --show
```
AST��json��ʽ�ļ���洢��'Դ�ļ�·��'_ast.json

+ ����IR�ļ�
``` bash
lli [IR�ļ�·��]
```
## ֧�ֵĹ���

ͨ�����������㡢�ַ���ƥ�䡢���򡢻��ļ���ĸ������Բ��ԡ�֧��`scanf`��`printf`��`gets`��`atoi`��`isdigit`��`strlen`������

֧�ֵĸ߼������У�

+ ֧�ֶ�ά����
+ ֧�����������
+ ���ƵĴ���������⵽һ������ʱ��������ͣ�£����ǻ�������б��롣
+ ֧��Ԥ����#include��#define)

## �ѵ��봴�µ�

### �ʷ�����

�ѵ�ʹ��µ��ǽ���Ԥ����Ŀǰ�ܴ���include��define�������Զ����ͷ�ļ�������"myheader.h"�����ǿ�����Ԥ������**�ݹ�**�ذ�ͷ�ļ��ĺ�������ճ����Դ�ļ��С����ڱ�׼��ͷ�ļ�������ֱ�����������õ��Ŀ⺯��������scanf��ֱ�ӵ���һ�������ڵ㣬�������м����ʱ��ʹ��llvmlite��declare_intrinsic��������llvm�Ľӿڹ淶����llvm���õ�scanf��

### �﷨����

��һ�׶�������Ҫ����C99�涨���﷨��д�﷨����û��ʲô���Ŀռ䣬����C99��׼�ĵ���¼ A.2.1С�ڣ�[ISO/IEC 9899:1999 ](https://www.dii.uchile.cl/~daespino/files/Iso_C_1999_definition.pdf) ��¼A.2 Phrase structure grammar,408ҳ�����涨��*primary-expression*���������ʽ����*postfix-expression*����׺���ʽ����*argument-expression-list*��ʵ�α��ʽ�б���*unary-expression*��һԪ���ʽ���ȵȣ�����ֻ��Ҫ���ݹ淶��д�﷨���򼴿ɡ�

### ������

##### ����﷨����

��`src/myYacc.py`�ļ���`p_error(p)`�����жԴ�����д����ڼ�⵽����ʱ����������ͼ��кţ�֮�����`parser.errok()`����parser��״̬����Ϊδ�����״̬��ʹ��parser�ᶪ���ó���token���������·�����**�������м�⵽�Ĵ���**�������ڼ�⵽��һ��������ֹͣ��

ʵ�ֵ��﷨�������У���������Ƿ�ƥ�䡢���ֺ��Ƿ�ȱʧ

����ʾ����

<img src="README/image-20221228234254959.png" alt="image-20221228234254959" style="zoom: 40%;" />

<img src="README/image-20221228233735451.png" alt="image-20221228233735451" style="zoom: 40%;" />

##### ����������

��`src/generator.py`�ļ��У�ͨ��`raise RuntimeError`�ķ�ʽ���ڼ�⵽����ʱ�������������Ϣ��ֹͣ��

ʵ�ֵ�����������У�ʹ��δ����ı�����ʹ��δ����ĺ�����ʹ��δ������������͡�ʹ��δ����Ķ�Ԫ��������ظ�����������

����ʾ����

<img src="README/image-20221228234518599.png" alt="image-20221228234518599" style="zoom:40%;" />

<img src="README/image-20221228234442138.png" alt="image-20221228234442138" style="zoom: 40%;" />

<img src="README\image-20221228234610189.png" alt="image-20221228234610189" style="zoom:40%;" />

<img src="README\image-20221228234638495.png" alt="image-20221228234638495" style="zoom: 40%;" />

## �����������֤

��exeĿ¼��

+ arithmetic.cpp:�����������
+ KMP.cpp:KMP �ַ���ƥ��
+ myRank.cpp:����
+ palindrome.cpp:���ļ��
+ test_preprocess.cpp������Ԥ����#include��#define������myheader.h�ж����fun����include��test_preprocess.cpp�У���ӡ����fun�ķ���ֵ666����ӡ#define��T���滻Ϊ6��Ľ��
+ myArray.cpp����֤�Ը�ά�����֧�֣�����������ά���鲢����˻���ÿ������4�����֣��Կո�������
+ scope.cpp���������������
+ test_error_handling.cpp�����Լ���﷨���󣬽�������һС��`������`����
+ test_semantic_error.cpp: ���Լ��������󣬽�������һС��`������`����

���Է�����

�ο����ĵ��ڶ�С�ڵ�ʹ�÷�������`cpp2llvm.py`������`.cpp`�����ļ�����Ϊ`.ll`�ļ���IR��ʽ����Ȼ��ִ��

```
lli arithmetic_llvm.ll
```

�����Ĳ����ļ���ll�ļ��Ѿ����ɺ���`exe`Ŀ¼�¡�

## �ֹ�

|        | �ʷ������׶�                                                 | �﷨�����׶� | �м��������                       |
| ------ | ------------------------------------------------------------ | ------------ | ---------------------------------- |
| ����   | ���ܣ��ʷ������еĳ�����ע�͡�������Ԥ����           | ��д�﷨���� | ��д�������ɹ���׫д�ĵ�         |
| ����� | �ʷ������е��������㣬����������д�����򣬻��ļ�⣩         | ��д�﷨���� | ��д�������ɹ��򣬱�д�����ļ�     |
| ����Ȼ | �ʷ������е�C++�����ؼ��֣�����������д������������㣬�ַ���ƥ�䣩 | ��д�﷨���� | ��д�������ɹ���ʵ�ִ������� |

## �ο�

https://github.com/Jmq14/c2llvm-compiler

https://github.com/wish142857/iTranslator-C2P/

https://github.com/alcides/pascal-in-python/

C99��׼��https://www.dii.uchile.cl/~daespino/files/Iso_C_1999_definition.pdf

C99��׼�����https://blog.csdn.net/weixin_44567318/article/details/117322765

llvmlite�ĵ���https://llvmlite.readthedocs.io/en/latest/