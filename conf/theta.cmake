set(CMAKE_C_COMPILER "cc")
set(CMAKE_CXX_COMPILER "CC")
set(CMAKE_C_FLAGS "-craympich-mt")
set(CMAKE_CXX_FLAGS "-O2 -std=c++11 -craympich-mt")
set(MPIEXEC "aprun")
set(MPIEXEC_NUMPROC_FLAG "-n")
