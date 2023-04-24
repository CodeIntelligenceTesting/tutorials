#!/bin/bash
set -e

MODE=regular

while (("$#")); do
	case "$1" in
	-m | --mode)
		# Sets the mode
		MODE=$2
		shift 2
		;;
	-*)
		echo "Error: Unknown option: $1" >&2
		exit 1
		;;
	*) # No more options
		break
		;;
	esac
done

LIBPNG_VERSION=1.6.39
LIBPNG=libpng-${LIBPNG_VERSION}

[ ! -e "${LIBPNG}.tar.xz" ] && wget https://download.sourceforge.net/libpng/"${LIBPNG}".tar.xz
[ ! -e "${LIBPNG}" ] && tar xf "${LIBPNG}.tar.xz"

build_libpng() {
	rm -rf BUILD
	cp -rf "${LIBPNG}" BUILD
	cd BUILD &&
		wget -qO png_mutator.cpp https://raw.githubusercontent.com/google/fuzzer-test-suite/master/libpng-1.2.56/png_mutator.h &&
		init_cifuzz &&
		./configure --disable-shared &>/dev/null &&
		make -j"$(nproc)" &>/dev/null
}

init_cifuzz() {
	cifuzz init
	patch CMakeLists.txt <../cifuzz_enable.patch
	cifuzz create cpp
	patch my_fuzz_test_1.cpp <../fuzz_test.patch
}

run_cifuzz() {
	if [ "$1" == "regular" ]; then
		echo "[>] Using default settings"
		sed -i '/add_fuzz_test/s/^#*//;/png_mutator/s/^#*/#/' CMakeLists.txt
	else
		echo "[>] Using custom mutator settings"
		sed -i '/add_fuzz_test/s/^#*/#/;/png_mutator/s/^#*//' CMakeLists.txt
	fi
	cifuzz run my_fuzz_test_1

}

build_libpng || exit 255

run_cifuzz "$MODE"
