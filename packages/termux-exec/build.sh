TERMUX_PKG_HOMEPAGE=https://github.com/termux/termux-exec-package
TERMUX_PKG_DESCRIPTION="Utils and libraries for Termux exec including a LD_PRELOAD shared library for proper functioning of the Termux execution environment"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1:2.0.0
TERMUX_PKG_SRCURL=https://github.com/termux/termux-exec-package/archive/refs/tags/v${TERMUX_PKG_VERSION:2}.tar.gz
TERMUX_PKG_SHA256=480452bd0b9cf7b6eb6549825a8faebb2a4afa8c88b9e1d621fb05528ba7ee6e
TERMUX_PKG_BUILD_DEPENDS="termux-core"
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_MAKE_ARGS="TERMUX_EXEC_PKG__VERSION=${TERMUX_PKG_VERSION} TERMUX_EXEC_PKG__ARCH=${TERMUX_ARCH} \
TERMUX__NAME=${TERMUX__NAME} TERMUX__LNAME=${TERMUX__LNAME} \
TERMUX_APP__NAME=${TERMUX_APP__NAME} \
TERMUX_APP__PACKAGE_NAME=${TERMUX_APP__PACKAGE_NAME} TERMUX_APP__DATA_DIR=${TERMUX_APP__DATA_DIR} \
TERMUX__ROOTFS=${TERMUX__ROOTFS} TERMUX__PREFIX=${TERMUX__PREFIX} \
TERMUX_ENV__S_ROOT=${TERMUX_ENV__S_ROOT} \
TERMUX_ENV__SS_TERMUX=${TERMUX_ENV__SS_TERMUX} TERMUX_ENV__S_TERMUX=${TERMUX_ENV__S_TERMUX} \
TERMUX_ENV__SS_TERMUX_APP=${TERMUX_ENV__SS_TERMUX_APP} TERMUX_ENV__S_TERMUX_APP=${TERMUX_ENV__S_TERMUX_APP} \
TERMUX_ENV__SS_TERMUX_ROOTFS=${TERMUX_ENV__SS_TERMUX_ROOTFS} TERMUX_ENV__S_TERMUX_ROOTFS=${TERMUX_ENV__S_TERMUX_ROOTFS} \
TERMUX_ENV__SS_TERMUX_EXEC=${TERMUX_ENV__SS_TERMUX_EXEC} TERMUX_ENV__S_TERMUX_EXEC=${TERMUX_ENV__S_TERMUX_EXEC} \
TERMUX_ENV__SS_TERMUX_EXEC__TESTS=${TERMUX_ENV__SS_TERMUX_EXEC__TESTS} TERMUX_ENV__S_TERMUX_EXEC__TESTS=${TERMUX_ENV__S_TERMUX_EXEC__TESTS} \
LIBTERMUX_EXEC__NOS__C__EXECVE_CALL__CHECK_ARGV0_BUFFER_OVERFLOW=1"

termux_step_install_license() {
	mkdir -p "$TERMUX_PREFIX/share/doc/$TERMUX_PKG_NAME/licenses"
	mv "$TERMUX_PKG_SRCDIR/LICENSE" "$TERMUX_PREFIX/share/doc/$TERMUX_PKG_NAME/copyright"
	mv "$TERMUX_PKG_SRCDIR/licenses/"* "$TERMUX_PREFIX/share/doc/$TERMUX_PKG_NAME/licenses/"
}

termux_step_strip_elf_symbols() {
	termux_step_strip_elf_symbols__from_paths . \
	\( \
		\( -path "./bin/*" -o -path "./lib/*" -o -path "./libexec/*" \) -a \
		\( ! -path "./libexec/installed-tests/termux-exec/*" \) \
	\)
}

termux_step_create_debscripts() {
	termux_step_create_debscripts__copy_from_dir "$TERMUX_PKG_SRCDIR/build/output/packaging/debian" .
}
