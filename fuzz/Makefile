.PHONY: all plain clean
all:
	/usr/lib/llvm-9/bin/clang++ -m32 -g -fsanitize=address,fuzzer fuzz_target.cpp

nonfuzz:
	/usr/lib/llvm-9/bin/clang++ -m32 -g nonfuzz.cpp -o nonfuzz -ldl

clean:
	rm -f a.out
	rm -f nonfuzz
	rm -f crash*
