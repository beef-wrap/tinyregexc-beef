mkdir libs
mkdir libs\debug
mkdir libs\release

clang -c -g -gcodeview -o tinyregexc.lib -target x86_64-pc-windows -fuse-ld=llvm-lib -Wall tiny-regex-c/re.c
move tinyregexc.lib libs\debug

clang -c -o tinyregexc.lib -target x86_64-pc-windows -fuse-ld=llvm-lib -Wall tiny-regex-c/re.c
move tinyregexc.lib libs\release