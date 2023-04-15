import cAST as myAST


def handle_decl_change(to_change, changer):
    changer_head = changer
    changer_tail = changer

    while changer_tail.type:
        changer_tail = changer_tail.type

    if isinstance(to_change, myAST.Identifier):
        changer_tail.type = to_change
        return changer
    else:
        res = to_change

        while not isinstance(res.type, myAST.Identifier):
            res = res.type

        changer_tail.type = res.type
        res.type = changer_head
        return to_change


