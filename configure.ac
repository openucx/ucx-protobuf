#
# Copyright (C) Mellanox Technologies Ltd. 2017.  ALL RIGHTS RESERVED.
# See file LICENSE for terms.
#
#

AC_PREREQ([2.63])
AC_INIT([ucxprotobuf], [0.1])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE([foreign])

# Checks for programs.
AC_PROG_CXX
AC_PROG_AWK
AC_PROG_INSTALL
AC_PROG_RANLIB
AC_PROG_CPP
AC_PROG_MKDIR_P

# Checks for libraries.
#AC_CHECK_LIB([libname], [funcname])

# Checks for header files.
#AC_CHECK_HEADERS([fenv.h float.h inttypes.h limits.h locale.h stddef.h stdint.h stdlib.h string.h wchar.h wctype.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_SIZE_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_CHECK_TYPES([ptrdiff_t])

# Checks for library functions.
#AC_CHECK_FUNCS([memset])

AC_CONFIG_FILES([Makefile
                 src/Makefile
                 test/Makefile
                 ])
AC_OUTPUT

