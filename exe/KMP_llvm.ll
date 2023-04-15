@"text" = common global [2048 x i8] zeroinitializer, align 4
@"pattern" = common global [2048 x i8] zeroinitializer, align 4
@"next" = common global [2048 x i32] zeroinitializer, align 4
define void @"getNext"()
{
entry:
  %".2" = getelementptr inbounds [2048 x i32], [2048 x i32]* @"next", i32 0, i32 0
  %".3" = sub i32 0, 1
  store i32 %".3", i32* %".2"
  %"i" = alloca i32
  store i32 0, i32* %"i"
  %"j" = alloca i32
  %".6" = sub i32 0, 1
  store i32 %".6", i32* %"j"
  br label %".8"
.8:
  %".12" = load i32, i32* %"i"
  %".13" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"pattern", i32 0, i32 0
  %".14" = call i32 @"strlen"(i8* %".13")
  %".15" = sub i32 %".14", 1
  %".16" = icmp slt i32 %".12", %".15"
  %".17" = icmp ne i1 %".16", 0
  br i1 %".17", label %".9", label %".10"
.9:
  %".19" = load i32, i32* %"j"
  %".20" = sub i32 0, 1
  %".21" = icmp eq i32 %".19", %".20"
  %".22" = load i32, i32* %"i"
  %".23" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"pattern", i32 0, i32 %".22"
  %".24" = load i8, i8* %".23"
  %".25" = load i32, i32* %"j"
  %".26" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"pattern", i32 0, i32 %".25"
  %".27" = load i8, i8* %".26"
  %".28" = icmp eq i8 %".24", %".27"
  %".29" = icmp ne i1 %".21", 0
  %".30" = icmp ne i1 %".28", 0
  %".31" = or i1 %".29", %".30"
  %".32" = icmp ne i1 %".31", 0
  br i1 %".32", label %".9.if", label %".9.else"
.10:
  ret void
.9.if:
  %".34" = load i32, i32* %"i"
  %".35" = add i32 %".34", 1
  store i32 %".35", i32* %"i"
  %".37" = load i32, i32* %"j"
  %".38" = add i32 %".37", 1
  store i32 %".38", i32* %"j"
  %".40" = load i32, i32* %"i"
  %".41" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"pattern", i32 0, i32 %".40"
  %".42" = load i8, i8* %".41"
  %".43" = load i32, i32* %"j"
  %".44" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"pattern", i32 0, i32 %".43"
  %".45" = load i8, i8* %".44"
  %".46" = icmp eq i8 %".42", %".45"
  %".47" = icmp ne i1 %".46", 0
  br i1 %".47", label %".9.if.if", label %".9.if.else"
.9.else:
  %".62" = load i32, i32* %"j"
  %".63" = getelementptr inbounds [2048 x i32], [2048 x i32]* @"next", i32 0, i32 %".62"
  %".64" = load i32, i32* %".63"
  store i32 %".64", i32* %"j"
  br label %".9.endif"
.9.endif:
  br label %".8"
.9.if.if:
  %".49" = load i32, i32* %"i"
  %".50" = getelementptr inbounds [2048 x i32], [2048 x i32]* @"next", i32 0, i32 %".49"
  %".51" = load i32, i32* %"j"
  %".52" = getelementptr inbounds [2048 x i32], [2048 x i32]* @"next", i32 0, i32 %".51"
  %".53" = load i32, i32* %".52"
  store i32 %".53", i32* %".50"
  br label %".9.if.endif"
.9.if.else:
  %".56" = load i32, i32* %"i"
  %".57" = getelementptr inbounds [2048 x i32], [2048 x i32]* @"next", i32 0, i32 %".56"
  %".58" = load i32, i32* %"j"
  store i32 %".58", i32* %".57"
  br label %".9.if.endif"
.9.if.endif:
  br label %".9.endif"
}

declare i32 @"strlen"(i8* %".1")

define i32 @"KMP"(i32 %"start")
{
entry:
  %"start.1" = alloca i32
  store i32 %"start", i32* %"start.1"
  %"pattern_len" = alloca i32
  %".4" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"pattern", i32 0, i32 0
  %".5" = call i32 @"strlen"(i8* %".4")
  store i32 %".5", i32* %"pattern_len"
  %"text_len" = alloca i32
  %".7" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"text", i32 0, i32 0
  %".8" = call i32 @"strlen"(i8* %".7")
  store i32 %".8", i32* %"text_len"
  %"i" = alloca i32
  %".10" = load i32, i32* %"start.1"
  store i32 %".10", i32* %"i"
  %"j" = alloca i32
  store i32 0, i32* %"j"
  br label %".13"
.13:
  %".17" = load i32, i32* %"i"
  %".18" = load i32, i32* %"text_len"
  %".19" = icmp slt i32 %".17", %".18"
  %".20" = load i32, i32* %"j"
  %".21" = load i32, i32* %"pattern_len"
  %".22" = icmp slt i32 %".20", %".21"
  %".23" = icmp ne i1 %".19", 0
  %".24" = icmp ne i1 %".22", 0
  %".25" = and i1 %".23", %".24"
  %".26" = icmp ne i1 %".25", 0
  br i1 %".26", label %".14", label %".15"
.14:
  %".28" = load i32, i32* %"j"
  %".29" = sub i32 0, 1
  %".30" = icmp eq i32 %".28", %".29"
  %".31" = load i32, i32* %"i"
  %".32" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"text", i32 0, i32 %".31"
  %".33" = load i8, i8* %".32"
  %".34" = load i32, i32* %"j"
  %".35" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"pattern", i32 0, i32 %".34"
  %".36" = load i8, i8* %".35"
  %".37" = icmp eq i8 %".33", %".36"
  %".38" = icmp ne i1 %".30", 0
  %".39" = icmp ne i1 %".37", 0
  %".40" = or i1 %".38", %".39"
  %".41" = icmp ne i1 %".40", 0
  br i1 %".41", label %".14.if", label %".14.else"
.15:
  %".56" = load i32, i32* %"j"
  %".57" = load i32, i32* %"pattern_len"
  %".58" = icmp eq i32 %".56", %".57"
  %".59" = icmp ne i1 %".58", 0
  br i1 %".59", label %".15.if", label %".15.else"
.14.if:
  %".43" = load i32, i32* %"i"
  %".44" = add i32 %".43", 1
  store i32 %".44", i32* %"i"
  %".46" = load i32, i32* %"j"
  %".47" = add i32 %".46", 1
  store i32 %".47", i32* %"j"
  br label %".14.endif"
.14.else:
  %".50" = load i32, i32* %"j"
  %".51" = getelementptr inbounds [2048 x i32], [2048 x i32]* @"next", i32 0, i32 %".50"
  %".52" = load i32, i32* %".51"
  store i32 %".52", i32* %"j"
  br label %".14.endif"
.14.endif:
  br label %".13"
.15.if:
  %".61" = load i32, i32* %"i"
  %".62" = load i32, i32* %"j"
  %".63" = sub i32 %".61", %".62"
  ret i32 %".63"
.15.else:
  %".65" = sub i32 0, 1
  ret i32 %".65"
.15.endif:
  %".67" = sub i32 0, 1
  ret i32 %".67"
}

define i32 @"main"()
{
entry:
  %".2" = getelementptr inbounds [25 x i8], [25 x i8]* @".str3", i32 0, i32 0
  %".3" = call i32 (i8*, ...) @"printf"(i8* %".2")
  %".4" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"text", i32 0, i32 0
  %".5" = call i32 (...) @"gets"(i8* %".4")
  %".6" = getelementptr inbounds [28 x i8], [28 x i8]* @".str4", i32 0, i32 0
  %".7" = call i32 (i8*, ...) @"printf"(i8* %".6")
  %".8" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"pattern", i32 0, i32 0
  %".9" = call i32 (...) @"gets"(i8* %".8")
  call void @"getNext"()
  %"start" = alloca i32
  store i32 0, i32* %"start"
  %"pos" = alloca i32
  store i32 0, i32* %"pos"
  %"has_pattern" = alloca i32
  store i32 0, i32* %"has_pattern"
  %"text_len" = alloca i32
  %".14" = getelementptr inbounds [2048 x i8], [2048 x i8]* @"text", i32 0, i32 0
  %".15" = call i32 @"strlen"(i8* %".14")
  store i32 %".15", i32* %"text_len"
  br label %".17"
.17:
  %".21" = load i32, i32* %"start"
  %".22" = load i32, i32* %"text_len"
  %".23" = icmp slt i32 %".21", %".22"
  %".24" = icmp ne i1 %".23", 0
  br i1 %".24", label %".18", label %".19"
.18:
  %".26" = load i32, i32* %"start"
  %".27" = call i32 @"KMP"(i32 %".26")
  store i32 %".27", i32* %"pos"
  %".29" = load i32, i32* %"pos"
  %".30" = sub i32 0, 1
  %".31" = icmp ne i32 %".29", %".30"
  %".32" = icmp ne i1 %".31", 0
  br i1 %".32", label %".18.if", label %".18.else"
.19:
  %".45" = load i32, i32* %"has_pattern"
  %".46" = icmp eq i32 %".45", 0
  %".47" = icmp ne i1 %".46", 0
  br i1 %".47", label %".19.if", label %".19.endif"
.18.if:
  %".34" = getelementptr inbounds [4 x i8], [4 x i8]* @".str5", i32 0, i32 0
  %".35" = load i32, i32* %"pos"
  %".36" = add i32 %".35", 1
  %".37" = call i32 (i8*, ...) @"printf"(i8* %".34", i32 %".36")
  %".38" = load i32, i32* %"pos"
  %".39" = add i32 %".38", 1
  store i32 %".39", i32* %"start"
  store i32 1, i32* %"has_pattern"
  br label %".18.endif"
.18.else:
  br label %".19"
.18.endif:
  br label %".17"
.19.if:
  %".49" = getelementptr inbounds [6 x i8], [6 x i8]* @".str6", i32 0, i32 0
  %".50" = call i32 (i8*, ...) @"printf"(i8* %".49")
  br label %".19.endif"
.19.endif:
  ret i32 0
}

@".str3" = constant [25 x i8] c"Please enter the text : \00"
declare i32 @"printf"(i8* %".1", ...)

declare i32 @"gets"(...)

@".str4" = constant [28 x i8] c"Please enter the pattern : \00"
@".str5" = constant [4 x i8] c"%d \00"
@".str6" = constant [6 x i8] c"False\00"
