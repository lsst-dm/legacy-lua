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

	sed -i '.prev' "s/PLAT= none/PLAT= ${PLAT}/" Makefile &&
	sed -i '.prev' "s,INSTALL_TOP= /usr/local,INSTALL_TOP= ${PREFIX}," Makefile &&
	sed -i '.prev' "s,CFLAGS= -O2,CFLAGS= -I${PREFIX}/include -fPIC -O2," src/Makefile &&
	sed -i '.prev' "s,LIBS= -lm,LIBS= -L${PREFIX}/lib -lm," src/Makefile &&
	sed -i '.prev' "s,#define LUA_ROOT\t\"/usr/local/\",#define LUA_ROOT\t\"${PREFIX}/\"," src/luaconf.h
}
