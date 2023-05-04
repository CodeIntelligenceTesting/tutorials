#!/bin/bash
set -e

MODE=0
BUILD_DIR="BUILD"

while (("$#")); do
	case "$1" in
	-m | --mode)
		# Sets the mode
		MODE=$2
		shift 2
		;;
	-b | --build_dir)
		# Sets the build dir
		BUILD_DIR=$2
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
	echo "[+] Building target library"
	rm -rf "$BUILD_DIR"
	cp -rf "${LIBPNG}" "$BUILD_DIR"
	cd "$BUILD_DIR" &&
		cp ../png_mutator.cpp . &&
		init_cifuzz &&
		./configure --disable-shared &>/dev/null &&
		make -j"$(nproc)" &>/dev/null
}

init_cifuzz() {
	echo "[+] Initializing cifuzz and patching fuzz test"
	cifuzz init &>/dev/null &&
		patch CMakeLists.txt <../cifuzz_enable.patch &>/dev/null &&
		cifuzz create cpp &>/dev/null &&
		patch my_fuzz_test_1.cpp <../fuzz_test.patch &>/dev/null
}

run_cifuzz() {
	echo "[+] Running cifuzz"
	if [ "$1" -eq 0 ]; then
		echo "[>] Using default settings"
		sed -i '/add_fuzz_test/s/^#*//;/png_mutator/s/^#*/#/' CMakeLists.txt
	else
		echo "[>] Using custom mutator settings"
		sed -i '/add_fuzz_test/s/^#*/#/;/png_mutator/s/^#*//' CMakeLists.txt
	fi
	(
		mkdir seed-corpus &&
			pushd seed-corpus &>/dev/null &&
			wget -qO 1.png https://github.com/dvyukov/go-fuzz-corpus/raw/master/png/corpus/0027e9c17f97bc035782fee6b4c725abb5e25f5f-2 &&
			popd &>/dev/null
	)

	CC="$(which clang)" CXX="$(which clang++)" cifuzz run my_fuzz_test_1 -s seed-corpus

}

build_libpng || exit 255

run_cifuzz "$MODE"
