.PHONY: all clean
all:
	clang++ -g -fsanitize=address,fuzzer fuzz_target.cpp

clean:
	rm -f a.out
	rm -f crash*
