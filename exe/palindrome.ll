define i32 @"main"()
{
entry:
  %"n" = alloca i32
  store i32 0, i32* %"n"
  %"a" = alloca [999 x i8]
  %".3" = getelementptr inbounds [18 x i8], [18 x i8]* @".str0", i32 0, i32 0
  %".4" = call i32 (i8*, ...) @"printf"(i8* %".3")
  %".5" = getelementptr inbounds [999 x i8], [999 x i8]* %"a", i32 0, i32 0
  %".6" = call i32 (...) @"gets"(i8* %".5")
  %".7" = getelementptr inbounds [999 x i8], [999 x i8]* %"a", i32 0, i32 0
  %".8" = call i32 @"strlen"(i8* %".7")
  store i32 %".8", i32* %"n"
  %"i" = alloca i32
  store i32 0, i32* %"i"
  br label %".11"
.11:
  %".15" = load i32, i32* %"i"
  %".16" = load i32, i32* %"n"
  %".17" = icmp slt i32 %".15", %".16"
  %".18" = icmp ne i1 %".17", 0
  br i1 %".18", label %".12", label %".13"
.12:
  %".20" = load i32, i32* %"i"
  %".21" = getelementptr inbounds [999 x i8], [999 x i8]* %"a", i32 0, i32 %".20"
  %".22" = load i8, i8* %".21"
  %".23" = load i32, i32* %"n"
  %".24" = load i32, i32* %"i"
  %".25" = sub i32 %".23", %".24"
  %".26" = sub i32 %".25", 1
  %".27" = getelementptr inbounds [999 x i8], [999 x i8]* %"a", i32 0, i32 %".26"
  %".28" = load i8, i8* %".27"
  %".29" = icmp ne i8 %".22", %".28"
  %".30" = icmp ne i1 %".29", 0
  br i1 %".30", label %".12.if", label %".12.endif"
.13:
  %".39" = getelementptr inbounds [30 x i8], [30 x i8]* @".str2", i32 0, i32 0
  %".40" = call i32 (i8*, ...) @"printf"(i8* %".39")
  ret i32 0
.12.if:
  %".32" = getelementptr inbounds [34 x i8], [34 x i8]* @".str1", i32 0, i32 0
  %".33" = call i32 (i8*, ...) @"printf"(i8* %".32")
  ret i32 0
.12.endif:
  %".35" = load i32, i32* %"i"
  %".36" = add i32 %".35", 1
  store i32 %".36", i32* %"i"
  br label %".11"
}

@".str0" = constant [18 x i8] c"type in a string\0a\00"
declare i32 @"printf"(i8* %".1", ...)

declare i32 @"gets"(...)

declare i32 @"strlen"(i8* %".1")

@".str1" = constant [34 x i8] c"this string is not a palindrome.\0a\00"
@".str2" = constant [30 x i8] c"this string is a palindrome.\0a\00"
