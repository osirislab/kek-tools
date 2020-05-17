.PHONY: all plain clean
all:
	clang++ -g -fsanitize=address,fuzzer fuzz_target.cpp

nonfuzz:
	clang++ -g nonfuzz.cpp -o nonfuzz -ldl

clean:
	rm -f a.out
	rm -f nonfuzz
	rm -f crash*
