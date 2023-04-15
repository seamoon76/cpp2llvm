define void @"myRank"()
{
entry:
  %".2" = getelementptr inbounds [4 x i8], [4 x i8]* @".str0", i32 0, i32 0
  %".3" = getelementptr inbounds [47 x i8], [47 x i8]* @".str1", i32 0, i32 0
  %".4" = call i32 (i8*, ...) @"printf"(i8* %".2", i8* %".3")
  %"ch" = alloca i8
  %"list" = alloca [100 x i32]
  %"count" = alloca i32
  store i32 0, i32* %"count"
  %".6" = getelementptr inbounds [3 x i8], [3 x i8]* @".str2", i32 0, i32 0
  %".7" = load i32, i32* %"count"
  %".8" = getelementptr inbounds [100 x i32], [100 x i32]* %"list", i32 0, i32 %".7"
  %".9" = call i32 (i8*, ...) @"scanf"(i8* %".6", i32* %".8")
  %".10" = load i32, i32* %"count"
  %".11" = add i32 %".10", 1
  store i32 %".11", i32* %"count"
  %".13" = getelementptr inbounds [3 x i8], [3 x i8]* @".str3", i32 0, i32 0
  %".14" = call i32 (i8*, ...) @"scanf"(i8* %".13", i8* %"ch")
  br label %".15"
.15:
  %".19" = load i8, i8* %"ch"
  %".20" = icmp ne i8 %".19", 10
  %".21" = icmp ne i1 %".20", 0
  br i1 %".21", label %".16", label %".17"
.16:
  %".23" = getelementptr inbounds [3 x i8], [3 x i8]* @".str4", i32 0, i32 0
  %".24" = load i32, i32* %"count"
  %".25" = getelementptr inbounds [100 x i32], [100 x i32]* %"list", i32 0, i32 %".24"
  %".26" = call i32 (i8*, ...) @"scanf"(i8* %".23", i32* %".25")
  %".27" = load i32, i32* %"count"
  %".28" = add i32 %".27", 1
  store i32 %".28", i32* %"count"
  %".30" = getelementptr inbounds [3 x i8], [3 x i8]* @".str5", i32 0, i32 0
  %".31" = call i32 (i8*, ...) @"scanf"(i8* %".30", i8* %"ch")
  br label %".15"
.17:
  %"temp" = alloca i32
  %"j" = alloca i32
  %"i" = alloca i32
  store i32 1, i32* %"i"
  br label %".34"
.34:
  %".38" = load i32, i32* %"i"
  %".39" = load i32, i32* %"count"
  %".40" = icmp slt i32 %".38", %".39"
  %".41" = icmp ne i1 %".40", 0
  br i1 %".41", label %".35", label %".36"
.35:
  store i32 0, i32* %"j"
  br label %".44"
.36:
  store i32 0, i32* %"i"
  br label %".91"
.44:
  %".48" = load i32, i32* %"j"
  %".49" = load i32, i32* %"count"
  %".50" = load i32, i32* %"i"
  %".51" = sub i32 %".49", %".50"
  %".52" = icmp slt i32 %".48", %".51"
  %".53" = icmp ne i1 %".52", 0
  br i1 %".53", label %".45", label %".46"
.45:
  %".55" = load i32, i32* %"j"
  %".56" = getelementptr inbounds [100 x i32], [100 x i32]* %"list", i32 0, i32 %".55"
  %".57" = load i32, i32* %".56"
  %".58" = load i32, i32* %"j"
  %".59" = add i32 %".58", 1
  %".60" = getelementptr inbounds [100 x i32], [100 x i32]* %"list", i32 0, i32 %".59"
  %".61" = load i32, i32* %".60"
  %".62" = icmp sgt i32 %".57", %".61"
  %".63" = icmp ne i1 %".62", 0
  br i1 %".63", label %".45.if", label %".45.endif"
.46:
  %".86" = load i32, i32* %"i"
  %".87" = add i32 %".86", 1
  store i32 %".87", i32* %"i"
  br label %".34"
.45.if:
  %".65" = load i32, i32* %"j"
  %".66" = getelementptr inbounds [100 x i32], [100 x i32]* %"list", i32 0, i32 %".65"
  %".67" = load i32, i32* %".66"
  store i32 %".67", i32* %"temp"
  %".69" = load i32, i32* %"j"
  %".70" = getelementptr inbounds [100 x i32], [100 x i32]* %"list", i32 0, i32 %".69"
  %".71" = load i32, i32* %"j"
  %".72" = add i32 %".71", 1
  %".73" = getelementptr inbounds [100 x i32], [100 x i32]* %"list", i32 0, i32 %".72"
  %".74" = load i32, i32* %".73"
  store i32 %".74", i32* %".70"
  %".76" = load i32, i32* %"j"
  %".77" = add i32 %".76", 1
  %".78" = getelementptr inbounds [100 x i32], [100 x i32]* %"list", i32 0, i32 %".77"
  %".79" = load i32, i32* %"temp"
  store i32 %".79", i32* %".78"
  br label %".45.endif"
.45.endif:
  %".82" = load i32, i32* %"j"
  %".83" = add i32 %".82", 1
  store i32 %".83", i32* %"j"
  br label %".44"
.91:
  %".95" = load i32, i32* %"i"
  %".96" = load i32, i32* %"count"
  %".97" = icmp slt i32 %".95", %".96"
  %".98" = icmp ne i1 %".97", 0
  br i1 %".98", label %".92", label %".93"
.92:
  %".100" = getelementptr inbounds [4 x i8], [4 x i8]* @".str6", i32 0, i32 0
  %".101" = load i32, i32* %"i"
  %".102" = getelementptr inbounds [100 x i32], [100 x i32]* %"list", i32 0, i32 %".101"
  %".103" = load i32, i32* %".102"
  %".104" = call i32 (i8*, ...) @"printf"(i8* %".100", i32 %".103")
  %".105" = load i32, i32* %"i"
  %".106" = add i32 %".105", 1
  store i32 %".106", i32* %"i"
  br label %".91"
.93:
  ret void
}

@".str0" = constant [4 x i8] c"%s \00"
@".str1" = constant [47 x i8] c"Enter a line of integers, separated by spaces\0a\00"
declare i32 @"printf"(i8* %".1", ...)

@".str2" = constant [3 x i8] c"%d\00"
declare i32 @"scanf"(i8* %".1", ...)

@".str3" = constant [3 x i8] c"%c\00"
@".str4" = constant [3 x i8] c"%d\00"
@".str5" = constant [3 x i8] c"%c\00"
@".str6" = constant [4 x i8] c"%d \00"
define i32 @"main"()
{
entry:
  call void @"myRank"()
  ret i32 0
}

