define i32 @"fun"()
{
entry:
  ret i32 666
}

define i32 @"main"()
{
entry:
  %"r" = alloca i32
  %".2" = call i32 @"fun"()
  store i32 %".2", i32* %"r"
  %".4" = getelementptr inbounds [17 x i8], [17 x i8]* @".str0", i32 0, i32 0
  %".5" = load i32, i32* %"r"
  %".6" = call i32 (i8*, ...) @"printf"(i8* %".4", i32 %".5")
  %".7" = getelementptr inbounds [15 x i8], [15 x i8]* @".str1", i32 0, i32 0
  %".8" = call i32 (i8*, ...) @"printf"(i8* %".7", i32 6)
  ret i32 0
}

@".str0" = constant [17 x i8] c"test include:%d\0a\00"
declare i32 @"printf"(i8* %".1", ...)

@".str1" = constant [15 x i8] c"test define:%d\00"
