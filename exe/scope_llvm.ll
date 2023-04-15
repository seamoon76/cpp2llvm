@"b" = global i32 1
define void @"show1"()
{
entry:
  %".2" = getelementptr inbounds [7 x i8], [7 x i8]* @".str1", i32 0, i32 0
  %".3" = getelementptr inbounds [45 x i8], [45 x i8]* @".str2", i32 0, i32 0
  %".4" = load i32, i32* @"b"
  %".5" = call i32 (i8*, ...) @"printf"(i8* %".2", i8* %".3", i32 %".4")
  ret void
}

@".str1" = constant [7 x i8] c"%s %d\0a\00"
@".str2" = constant [45 x i8] c"int function show1, the global variable b is\00"
declare i32 @"printf"(i8* %".1", ...)

define void @"show2"()
{
entry:
  %"c" = alloca i32
  store i32 3, i32* %"c"
  %".3" = getelementptr inbounds [7 x i8], [7 x i8]* @".str3", i32 0, i32 0
  %".4" = getelementptr inbounds [44 x i8], [44 x i8]* @".str4", i32 0, i32 0
  %".5" = load i32, i32* %"c"
  %".6" = call i32 (i8*, ...) @"printf"(i8* %".3", i8* %".4", i32 %".5")
  ret void
}

@".str3" = constant [7 x i8] c"%s %d\0a\00"
@".str4" = constant [44 x i8] c"int function show2, the local variable c is\00"
define i32 @"main"()
{
entry:
  call void @"show1"()
  call void @"show2"()
  %".4" = getelementptr inbounds [7 x i8], [7 x i8]* @".str5", i32 0, i32 0
  %".5" = getelementptr inbounds [42 x i8], [42 x i8]* @".str6", i32 0, i32 0
  %".6" = load i32, i32* @"b"
  %".7" = call i32 (i8*, ...) @"printf"(i8* %".4", i8* %".5", i32 %".6")
  %"a" = alloca i32
  store i32 2, i32* %"a"
  %".9" = getelementptr inbounds [7 x i8], [7 x i8]* @".str7", i32 0, i32 0
  %".10" = getelementptr inbounds [41 x i8], [41 x i8]* @".str8", i32 0, i32 0
  %".11" = load i32, i32* %"a"
  %".12" = call i32 (i8*, ...) @"printf"(i8* %".9", i8* %".10", i32 %".11")
  ret i32 0
}

@".str5" = constant [7 x i8] c"%s %d\0a\00"
@".str6" = constant [42 x i8] c"in main fuction, the global variable b is\00"
@".str7" = constant [7 x i8] c"%s %d\0a\00"
@".str8" = constant [41 x i8] c"in main fuction, the local variable a is\00"
