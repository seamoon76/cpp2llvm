import re
import sys
import os


def preprocess(filename):
    r"""
    :param filename:
    :return: file_data:If the read is successful, it will be the file content, if the read fails, it will be an error message
    ok:True or False
    """

    dir_name = os.path.dirname(filename)
    try:
        f = open(filename, "r")
        data = f.read()
        f.close()
    except FileNotFoundError as e:
        return str(e), False

    files_to_read = []
    lines = data.split('\n')
    lines_keep=[]
    for_define_list = []
    for l in lines:
        l = l.strip(' ').strip('\t').strip('\r').strip('\n')
        if len(l) > 0 and l[0] == '#':
            try:
                words = l[1:].strip(' ').split(' ', 2)
                if words[0] == 'include':
                    if words[1][0] == '"' and words[1][-1] == '"':
                        files_to_read.append(os.path.join(dir_name, words[1][1:-1]))
                    elif words[1][0] == '<' and words[1][-1] == '>':
                        pass
                    else:
                        return "invalid include order", False
                elif words[0] == 'define':
                    for_define_list.append((words[1], words[2]))
                elif words[0] in ['if','endif','ifndef']:
                    pass
                else:
                    return "invalid include order", False
            except Exception as e:
                return "invalid include order: " + str(e), False
        elif len(l)>0:
            lines_keep.append(l)
    content_now_file = '\n'.join(lines_keep)
    for m in for_define_list:
        content_now_file = re.sub(m[0], m[1], content_now_file)
    # include handle
    file_data = ''
    for m in files_to_read:
        content, ok = preprocess(m)
        if ok:
            file_data = file_data + content
        else:
            return content, ok
    file_data = file_data + content_now_file + '\n'
    return file_data, True
