%"Stack" = type {[1000 x i32], i32}
@"lessPrior" = global [6 x [6 x i32]] [[6 x i32] [i32 1, i32 1, i32 1, i32 1, i32 0, i32 1], [6 x i32] [i32 1, i32 1, i32 1, i32 1, i32 0, i32 1], [6 x i32] [i32 0, i32 0, i32 1, i32 1, i32 0, i32 1], [6 x i32] [i32 0, i32 0, i32 1, i32 1, i32 0, i32 1], [6 x i32] [i32 0, i32 0, i32 0, i32 0, i32 0, i32 1], [6 x i32] [i32 1, i32 1, i32 1, i32 1, i32 0, i32 1]]
@"value" = common global %"Stack" zeroinitializer, align 4
@"op" = common global %"Stack" zeroinitializer, align 4
define void @"init"(i32 %"stack_kind")
{
entry:
  %"stack_kind.1" = alloca i32
  store i32 %"stack_kind", i32* %"stack_kind.1"
  %".4" = load i32, i32* %"stack_kind.1"
  %".5" = icmp eq i32 %".4", 0
  %".6" = icmp ne i1 %".5", 0
  br i1 %".6", label %"entry.if", label %"entry.else"
entry.if:
  %".8" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  store i32 0, i32* %".8"
  br label %"entry.endif"
entry.else:
  %".11" = load i32, i32* %"stack_kind.1"
  %".12" = icmp eq i32 %".11", 1
  %".13" = icmp ne i1 %".12", 0
  br i1 %".13", label %"entry.else.if", label %"entry.else.endif"
entry.endif:
  ret void
entry.else.if:
  %".15" = getelementptr inbounds %"Stack", %"Stack"* @"value", i32 0, i32 1
  store i32 0, i32* %".15"
  br label %"entry.else.endif"
entry.else.endif:
  br label %"entry.endif"
}

define void @"push"(i32 %"stack_kind", i32 %"n")
{
entry:
  %"stack_kind.1" = alloca i32
  store i32 %"stack_kind", i32* %"stack_kind.1"
  %"n.1" = alloca i32
  store i32 %"n", i32* %"n.1"
  %"i" = alloca i32
  %".6" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".7" = load i32, i32* %".6"
  store i32 %".7", i32* %"i"
  %".9" = load i32, i32* %"stack_kind.1"
  %".10" = icmp eq i32 %".9", 0
  %".11" = icmp ne i1 %".10", 0
  br i1 %".11", label %"entry.if", label %"entry.else"
entry.if:
  %".13" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 0
  %".14" = load i32, i32* %"i"
  %".15" = getelementptr inbounds [1000 x i32], [1000 x i32]* %".13", i32 0, i32 %".14"
  %".16" = load i32, i32* %"n.1"
  store i32 %".16", i32* %".15"
  %".18" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".19" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".20" = load i32, i32* %".19"
  %".21" = add i32 %".20", 1
  store i32 %".21", i32* %".18"
  br label %"entry.endif"
entry.else:
  %".24" = load i32, i32* %"stack_kind.1"
  %".25" = icmp eq i32 %".24", 1
  %".26" = icmp ne i1 %".25", 0
  br i1 %".26", label %"entry.else.if", label %"entry.else.endif"
entry.endif:
  ret void
entry.else.if:
  %".28" = getelementptr inbounds %"Stack", %"Stack"* @"value", i32 0, i32 1
  %".29" = load i32, i32* %".28"
  store i32 %".29", i32* %"i"
  %".31" = getelementptr inbounds %"Stack", %"Stack"* @"value", i32 0, i32 0
  %".32" = load i32, i32* %"i"
  %".33" = getelementptr inbounds [1000 x i32], [1000 x i32]* %".31", i32 0, i32 %".32"
  %".34" = load i32, i32* %"n.1"
  store i32 %".34", i32* %".33"
  %".36" = getelementptr inbounds %"Stack", %"Stack"* @"value", i32 0, i32 1
  %".37" = getelementptr inbounds %"Stack", %"Stack"* @"value", i32 0, i32 1
  %".38" = load i32, i32* %".37"
  %".39" = add i32 %".38", 1
  store i32 %".39", i32* %".36"
  br label %"entry.else.endif"
entry.else.endif:
  br label %"entry.endif"
}

define i32 @"pop"(i32 %"stack_kind")
{
entry:
  %"stack_kind.1" = alloca i32
  store i32 %"stack_kind", i32* %"stack_kind.1"
  %".4" = load i32, i32* %"stack_kind.1"
  %".5" = icmp eq i32 %".4", 0
  %".6" = icmp ne i1 %".5", 0
  br i1 %".6", label %"entry.if", label %"entry.else"
entry.if:
  %".8" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".9" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".10" = load i32, i32* %".9"
  %".11" = sub i32 %".10", 1
  store i32 %".11", i32* %".8"
  %".13" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 0
  %".14" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".15" = load i32, i32* %".14"
  %".16" = getelementptr inbounds [1000 x i32], [1000 x i32]* %".13", i32 0, i32 %".15"
  %".17" = load i32, i32* %".16"
  ret i32 %".17"
entry.else:
  %".19" = load i32, i32* %"stack_kind.1"
  %".20" = icmp eq i32 %".19", 1
  %".21" = icmp ne i1 %".20", 0
  br i1 %".21", label %"entry.else.if", label %"entry.else.endif"
entry.endif:
  ret i32 0
entry.else.if:
  %".23" = getelementptr inbounds %"Stack", %"Stack"* @"value", i32 0, i32 1
  %".24" = getelementptr inbounds %"Stack", %"Stack"* @"value", i32 0, i32 1
  %".25" = load i32, i32* %".24"
  %".26" = sub i32 %".25", 1
  store i32 %".26", i32* %".23"
  %".28" = getelementptr inbounds %"Stack", %"Stack"* @"value", i32 0, i32 0
  %".29" = getelementptr inbounds %"Stack", %"Stack"* @"value", i32 0, i32 1
  %".30" = load i32, i32* %".29"
  %".31" = getelementptr inbounds [1000 x i32], [1000 x i32]* %".28", i32 0, i32 %".30"
  %".32" = load i32, i32* %".31"
  ret i32 %".32"
entry.else.endif:
  br label %"entry.endif"
}

define i32 @"top"(i32 %"stack_kind")
{
entry:
  %"stack_kind.1" = alloca i32
  store i32 %"stack_kind", i32* %"stack_kind.1"
  %".4" = load i32, i32* %"stack_kind.1"
  %".5" = icmp eq i32 %".4", 0
  %".6" = icmp ne i1 %".5", 0
  br i1 %".6", label %"entry.if", label %"entry.else"
entry.if:
  %".8" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".9" = load i32, i32* %".8"
  %".10" = icmp slt i32 %".9", 1
  %".11" = icmp ne i1 %".10", 0
  br i1 %".11", label %"entry.if.if", label %"entry.if.endif"
entry.else:
  %".23" = load i32, i32* %"stack_kind.1"
  %".24" = icmp eq i32 %".23", 1
  %".25" = icmp ne i1 %".24", 0
  br i1 %".25", label %"entry.else.if", label %"entry.else.endif"
entry.endif:
  ret i32 0
entry.if.if:
  %".13" = getelementptr inbounds [32 x i8], [32 x i8]* @".str3", i32 0, i32 0
  %".14" = call i32 (i8*, ...) @"printf"(i8* %".13")
  ret i32 0
entry.if.endif:
  %".16" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 0
  %".17" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".18" = load i32, i32* %".17"
  %".19" = sub i32 %".18", 1
  %".20" = getelementptr inbounds [1000 x i32], [1000 x i32]* %".16", i32 0, i32 %".19"
  %".21" = load i32, i32* %".20"
  ret i32 %".21"
entry.else.if:
  %".27" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".28" = load i32, i32* %".27"
  %".29" = icmp slt i32 %".28", 1
  %".30" = icmp ne i1 %".29", 0
  br i1 %".30", label %"entry.else.if.if", label %"entry.else.if.endif"
entry.else.endif:
  br label %"entry.endif"
entry.else.if.if:
  %".32" = getelementptr inbounds [32 x i8], [32 x i8]* @".str4", i32 0, i32 0
  %".33" = call i32 (i8*, ...) @"printf"(i8* %".32")
  ret i32 0
entry.else.if.endif:
  %".35" = getelementptr inbounds %"Stack", %"Stack"* @"value", i32 0, i32 0
  %".36" = getelementptr inbounds %"Stack", %"Stack"* @"value", i32 0, i32 1
  %".37" = load i32, i32* %".36"
  %".38" = sub i32 %".37", 1
  %".39" = getelementptr inbounds [1000 x i32], [1000 x i32]* %".35", i32 0, i32 %".38"
  %".40" = load i32, i32* %".39"
  ret i32 %".40"
}

@".str3" = constant [32 x i8] c"cannot get top of empty stack.\0a\00"
declare i32 @"printf"(i8* %".1", ...)

@".str4" = constant [32 x i8] c"cannot get top of empty stack.\0a\00"
define i32 @"indexOf"(i8 signext %"ch")
{
entry:
  %"ch.1" = alloca i8
  store i8 %"ch", i8* %"ch.1"
  %"index" = alloca i32
  store i32 10, i32* %"index"
  %".5" = load i8, i8* %"ch.1"
  %".6" = icmp eq i8 %".5", 43
  %".7" = icmp ne i1 %".6", 0
  br i1 %".7", label %"entry.if", label %"entry.else"
entry.if:
  store i32 0, i32* %"index"
  br label %"entry.endif"
entry.else:
  %".11" = load i8, i8* %"ch.1"
  %".12" = icmp eq i8 %".11", 45
  %".13" = icmp ne i1 %".12", 0
  br i1 %".13", label %"entry.else.if", label %"entry.else.else"
entry.endif:
  %".46" = load i32, i32* %"index"
  ret i32 %".46"
entry.else.if:
  store i32 1, i32* %"index"
  br label %"entry.else.endif"
entry.else.else:
  %".17" = load i8, i8* %"ch.1"
  %".18" = icmp eq i8 %".17", 42
  %".19" = icmp ne i1 %".18", 0
  br i1 %".19", label %"entry.else.else.if", label %"entry.else.else.else"
entry.else.endif:
  br label %"entry.endif"
entry.else.else.if:
  store i32 2, i32* %"index"
  br label %"entry.else.else.endif"
entry.else.else.else:
  %".23" = load i8, i8* %"ch.1"
  %".24" = icmp eq i8 %".23", 47
  %".25" = icmp ne i1 %".24", 0
  br i1 %".25", label %"entry.else.else.else.if", label %"entry.else.else.else.else"
entry.else.else.endif:
  br label %"entry.else.endif"
entry.else.else.else.if:
  store i32 3, i32* %"index"
  br label %"entry.else.else.else.endif"
entry.else.else.else.else:
  %".29" = load i8, i8* %"ch.1"
  %".30" = icmp eq i8 %".29", 40
  %".31" = icmp ne i1 %".30", 0
  br i1 %".31", label %"entry.else.else.else.else.if", label %"entry.else.else.else.else.else"
entry.else.else.else.endif:
  br label %"entry.else.else.endif"
entry.else.else.else.else.if:
  store i32 4, i32* %"index"
  br label %"entry.else.else.else.else.endif"
entry.else.else.else.else.else:
  %".35" = load i8, i8* %"ch.1"
  %".36" = icmp eq i8 %".35", 41
  %".37" = icmp ne i1 %".36", 0
  br i1 %".37", label %"entry.else.else.else.else.else.if", label %"entry.else.else.else.else.else.endif"
entry.else.else.else.else.endif:
  br label %"entry.else.else.else.endif"
entry.else.else.else.else.else.if:
  store i32 5, i32* %"index"
  br label %"entry.else.else.else.else.else.endif"
entry.else.else.else.else.else.endif:
  br label %"entry.else.else.else.else.endif"
}

define void @"sendOp"(i8 signext %"op")
{
entry:
  %"op.1" = alloca i8
  store i8 %"op", i8* %"op.1"
  %"right" = alloca i32
  %".4" = call i32 @"pop"(i32 1)
  store i32 %".4", i32* %"right"
  %".6" = load i8, i8* %"op.1"
  %".7" = icmp eq i8 %".6", 43
  %".8" = icmp ne i1 %".7", 0
  br i1 %".8", label %"entry.if", label %"entry.else"
entry.if:
  %".10" = call i32 @"pop"(i32 1)
  %".11" = load i32, i32* %"right"
  %".12" = add i32 %".10", %".11"
  call void @"push"(i32 1, i32 %".12")
  br label %"entry.endif"
entry.else:
  %".15" = load i8, i8* %"op.1"
  %".16" = icmp eq i8 %".15", 45
  %".17" = icmp ne i1 %".16", 0
  br i1 %".17", label %"entry.else.if", label %"entry.else.else"
entry.endif:
  ret void
entry.else.if:
  %".19" = call i32 @"pop"(i32 1)
  %".20" = load i32, i32* %"right"
  %".21" = sub i32 %".19", %".20"
  call void @"push"(i32 1, i32 %".21")
  br label %"entry.else.endif"
entry.else.else:
  %".24" = load i8, i8* %"op.1"
  %".25" = icmp eq i8 %".24", 42
  %".26" = icmp ne i1 %".25", 0
  br i1 %".26", label %"entry.else.else.if", label %"entry.else.else.else"
entry.else.endif:
  br label %"entry.endif"
entry.else.else.if:
  %".28" = call i32 @"pop"(i32 1)
  %".29" = load i32, i32* %"right"
  %".30" = mul i32 %".28", %".29"
  call void @"push"(i32 1, i32 %".30")
  br label %"entry.else.else.endif"
entry.else.else.else:
  %".33" = load i8, i8* %"op.1"
  %".34" = icmp eq i8 %".33", 47
  %".35" = icmp ne i1 %".34", 0
  br i1 %".35", label %"entry.else.else.else.if", label %"entry.else.else.else.endif"
entry.else.else.endif:
  br label %"entry.else.endif"
entry.else.else.else.if:
  %".37" = call i32 @"pop"(i32 1)
  %".38" = load i32, i32* %"right"
  %".39" = sdiv i32 %".37", %".38"
  call void @"push"(i32 1, i32 %".39")
  br label %"entry.else.else.else.endif"
entry.else.else.else.endif:
  br label %"entry.else.else.endif"
}

define i32 @"main"()
{
entry:
  call void @"init"(i32 1)
  call void @"init"(i32 0)
  %"str" = alloca [101 x i8]
  %".4" = getelementptr inbounds [29 x i8], [29 x i8]* @".str5", i32 0, i32 0
  %".5" = call i32 (i8*, ...) @"printf"(i8* %".4")
  %".6" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 0
  %".7" = call i32 (...) @"gets"(i8* %".6")
  %"i" = alloca i32
  store i32 0, i32* %"i"
  br label %".9"
.9:
  %".13" = load i32, i32* %"i"
  %".14" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".13"
  %".15" = load i8, i8* %".14"
  %".16" = icmp ne i8 %".15", 0
  br i1 %".16", label %".10", label %".11"
.10:
  %".18" = load i32, i32* %"i"
  %".19" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".18"
  %".20" = load i8, i8* %".19"
  %".21" = sext i8 %".20" to i32
  %".22" = call i32 @"isdigit"(i32 %".21")
  %".23" = icmp ne i32 %".22", 0
  br i1 %".23", label %".10.if", label %".10.endif"
.11:
  br label %".201"
.10.if:
  %"j" = alloca i32
  %".25" = load i32, i32* %"i"
  store i32 %".25", i32* %"j"
  br label %".27"
.10.endif:
  %"con" = alloca i32
  store i32 0, i32* %"con"
  %".77" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".78" = load i32, i32* %".77"
  %".79" = icmp eq i32 %".78", 0
  %".80" = icmp eq i1 %".79", 0
  %".81" = icmp ne i1 %".80", 0
  br i1 %".81", label %".10.endif.if", label %".10.endif.else"
.27:
  %".31" = load i32, i32* %"i"
  %".32" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".31"
  %".33" = load i8, i8* %".32"
  %".34" = load i32, i32* %"i"
  %".35" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".34"
  %".36" = load i8, i8* %".35"
  %".37" = sext i8 %".36" to i32
  %".38" = call i32 @"isdigit"(i32 %".37")
  %".39" = icmp ne i8 %".33", 0
  %".40" = icmp ne i32 %".38", 0
  %".41" = and i1 %".39", %".40"
  %".42" = icmp ne i1 %".41", 0
  br i1 %".42", label %".28", label %".29"
.28:
  %".44" = load i32, i32* %"i"
  %".45" = add i32 %".44", 1
  store i32 %".45", i32* %"i"
  br label %".27"
.29:
  %"buff" = alloca [11 x i8]
  %"count" = alloca i32
  %".48" = load i32, i32* %"i"
  %".49" = sub i32 %".48", 1
  store i32 %".49", i32* %"count"
  br label %".51"
.51:
  %".55" = load i32, i32* %"count"
  %".56" = load i32, i32* %"j"
  %".57" = icmp sge i32 %".55", %".56"
  %".58" = icmp ne i1 %".57", 0
  br i1 %".58", label %".52", label %".53"
.52:
  %".60" = load i32, i32* %"count"
  %".61" = load i32, i32* %"j"
  %".62" = sub i32 %".60", %".61"
  %".63" = getelementptr inbounds [11 x i8], [11 x i8]* %"buff", i32 0, i32 %".62"
  %".64" = load i32, i32* %"count"
  %".65" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".64"
  %".66" = load i8, i8* %".65"
  store i8 %".66", i8* %".63"
  %".68" = load i32, i32* %"count"
  %".69" = sub i32 %".68", 1
  store i32 %".69", i32* %"count"
  br label %".51"
.53:
  %".72" = getelementptr inbounds [11 x i8], [11 x i8]* %"buff", i32 0, i32 0
  %".73" = call i32 (...) @"atoi"(i8* %".72")
  call void @"push"(i32 1, i32 %".73")
  br label %".9"
.10.endif.if:
  %".83" = load i32, i32* %"i"
  %".84" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".83"
  %".85" = load i8, i8* %".84"
  %".86" = call i32 @"indexOf"(i8 %".85")
  %".87" = getelementptr inbounds [6 x [6 x i32]], [6 x [6 x i32]]* @"lessPrior", i32 0, i32 %".86"
  %".88" = call i32 @"top"(i32 0)
  %".89" = trunc i32 %".88" to i8
  %".90" = call i32 @"indexOf"(i8 %".89")
  %".91" = getelementptr inbounds [6 x i32], [6 x i32]* %".87", i32 0, i32 %".90"
  %".92" = load i32, i32* %".91"
  %".93" = icmp ne i32 %".92", 0
  br i1 %".93", label %".10.endif.if.if", label %".10.endif.if.else"
.10.endif.else:
  store i32 0, i32* %"con"
  br label %".10.endif.endif"
.10.endif.endif:
  br label %".102"
.10.endif.if.if:
  store i32 1, i32* %"con"
  br label %".10.endif.if.endif"
.10.endif.if.else:
  store i32 0, i32* %"con"
  br label %".10.endif.if.endif"
.10.endif.if.endif:
  br label %".10.endif.endif"
.102:
  %".106" = load i32, i32* %"con"
  %".107" = icmp ne i32 %".106", 0
  br i1 %".107", label %".103", label %".104"
.103:
  %".109" = call i32 @"pop"(i32 0)
  %".110" = trunc i32 %".109" to i8
  call void @"sendOp"(i8 %".110")
  %".112" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".113" = load i32, i32* %".112"
  %".114" = icmp eq i32 %".113", 0
  %".115" = icmp eq i1 %".114", 0
  %".116" = icmp ne i1 %".115", 0
  br i1 %".116", label %".103.if", label %".103.else"
.104:
  %".138" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".139" = load i32, i32* %".138"
  %".140" = icmp eq i32 %".139", 0
  %".141" = icmp eq i1 %".140", 0
  %".142" = icmp ne i1 %".141", 0
  br i1 %".142", label %".104.if", label %".104.endif"
.103.if:
  %".118" = load i32, i32* %"i"
  %".119" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".118"
  %".120" = load i8, i8* %".119"
  %".121" = call i32 @"indexOf"(i8 %".120")
  %".122" = getelementptr inbounds [6 x [6 x i32]], [6 x [6 x i32]]* @"lessPrior", i32 0, i32 %".121"
  %".123" = call i32 @"top"(i32 0)
  %".124" = trunc i32 %".123" to i8
  %".125" = call i32 @"indexOf"(i8 %".124")
  %".126" = getelementptr inbounds [6 x i32], [6 x i32]* %".122", i32 0, i32 %".125"
  %".127" = load i32, i32* %".126"
  %".128" = icmp ne i32 %".127", 0
  br i1 %".128", label %".103.if.if", label %".103.if.else"
.103.else:
  store i32 0, i32* %"con"
  br label %".103.endif"
.103.endif:
  br label %".102"
.103.if.if:
  store i32 1, i32* %"con"
  br label %".103.if.endif"
.103.if.else:
  store i32 0, i32* %"con"
  br label %".103.if.endif"
.103.if.endif:
  br label %".103.endif"
.104.if:
  %".144" = load i32, i32* %"i"
  %".145" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".144"
  %".146" = load i8, i8* %".145"
  %".147" = icmp eq i8 %".146", 41
  %".148" = call i32 @"top"(i32 0)
  %".149" = icmp eq i32 %".148", 40
  %".150" = icmp ne i1 %".147", 0
  %".151" = icmp ne i1 %".149", 0
  %".152" = and i1 %".150", %".151"
  %".153" = icmp ne i1 %".152", 0
  br i1 %".153", label %".104.if.if", label %".104.if.endif"
.104.endif:
  %".161" = load i32, i32* %"i"
  %".162" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".161"
  %".163" = load i8, i8* %".162"
  %".164" = icmp eq i8 %".163", 45
  %".165" = load i32, i32* %"i"
  %".166" = icmp eq i32 %".165", 0
  %".167" = load i32, i32* %"i"
  %".168" = sub i32 %".167", 1
  %".169" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".168"
  %".170" = load i8, i8* %".169"
  %".171" = sext i8 %".170" to i32
  %".172" = call i32 @"isdigit"(i32 %".171")
  %".173" = icmp eq i32 %".172", 0
  %".174" = load i32, i32* %"i"
  %".175" = sub i32 %".174", 1
  %".176" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".175"
  %".177" = load i8, i8* %".176"
  %".178" = icmp ne i8 %".177", 41
  %".179" = icmp ne i1 %".173", 0
  %".180" = icmp ne i1 %".178", 0
  %".181" = and i1 %".179", %".180"
  %".182" = icmp ne i1 %".166", 0
  %".183" = icmp ne i1 %".181", 0
  %".184" = or i1 %".182", %".183"
  %".185" = icmp ne i1 %".164", 0
  %".186" = icmp ne i1 %".184", 0
  %".187" = and i1 %".185", %".186"
  %".188" = icmp ne i1 %".187", 0
  br i1 %".188", label %".104.endif.if", label %".104.endif.endif"
.104.if.if:
  %".155" = call i32 @"pop"(i32 0)
  %".156" = load i32, i32* %"i"
  %".157" = add i32 %".156", 1
  store i32 %".157", i32* %"i"
  br label %".9"
.104.if.endif:
  br label %".104.endif"
.104.endif.if:
  call void @"push"(i32 1, i32 0)
  br label %".104.endif.endif"
.104.endif.endif:
  %".192" = load i32, i32* %"i"
  %".193" = getelementptr inbounds [101 x i8], [101 x i8]* %"str", i32 0, i32 %".192"
  %".194" = load i8, i8* %".193"
  %".195" = sext i8 %".194" to i32
  call void @"push"(i32 0, i32 %".195")
  %".197" = load i32, i32* %"i"
  %".198" = add i32 %".197", 1
  store i32 %".198", i32* %"i"
  br label %".9"
.201:
  %".205" = getelementptr inbounds %"Stack", %"Stack"* @"op", i32 0, i32 1
  %".206" = load i32, i32* %".205"
  %".207" = icmp eq i32 %".206", 0
  %".208" = icmp eq i1 %".207", 0
  %".209" = icmp ne i1 %".208", 0
  br i1 %".209", label %".202", label %".203"
.202:
  %".211" = call i32 @"pop"(i32 0)
  %".212" = trunc i32 %".211" to i8
  call void @"sendOp"(i8 %".212")
  br label %".201"
.203:
  %"out" = alloca i32
  %".215" = call i32 @"pop"(i32 1)
  store i32 %".215", i32* %"out"
  %".217" = getelementptr inbounds [4 x i8], [4 x i8]* @".str6", i32 0, i32 0
  %".218" = load i32, i32* %"out"
  %".219" = call i32 (i8*, ...) @"printf"(i8* %".217", i32 %".218")
  ret i32 0
}

@".str5" = constant [29 x i8] c"Please enter an expression:\0a\00"
declare i32 @"gets"(...)

declare i32 @"isdigit"(i32 %".1")

declare i32 @"atoi"(...)

@".str6" = constant [4 x i8] c"%d\0a\00"
