# EupsPkg config file. Sourced by 'eupspkg'

# Breaks on Darwin w/o this
export LANG=C

config()
{
	# Detect platform
	case "$(uname)" in
	Linux)
		PLAT="linux" ;;
	Darwin)
		PLAT="macosx" ;;
	*)
		die "Unsupported platform $(uname); aborting build."
	esac

	# Work around Darwin vs. GNU sed differences
	[[ $(uname) = Darwin ]] && SED_INPLACE="/usr/bin/sed -i '.prev'" || SED_INPLACE="sed -i"

	$SED_INPLACE "s/PLAT= none/PLAT= ${PLAT}/" Makefile &&
	$SED_INPLACE "s,INSTALL_TOP= /usr/local,INSTALL_TOP= ${PREFIX}," Makefile &&
	$SED_INPLACE "s,CFLAGS= -O2,CFLAGS= -I${PREFIX}/include -fPIC -O2," src/Makefile &&
	$SED_INPLACE "s,LIBS= -lm,LIBS= -L${PREFIX}/lib -lm," src/Makefile &&
	$SED_INPLACE "s,#define LUA_ROOT\t\"/usr/local/\",#define LUA_ROOT\t\"${PREFIX}/\"," src/luaconf.h
}
