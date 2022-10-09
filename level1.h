// hello this is test.h
#include <stdio.h>
#include "level2.h" // hello world #include "hello"

// include below will fail since they are not part of this repos
#include "myFunc/input_logger.hh"

#define FMT_HEADER_ONLY
#include "myFunc/fmt/format.h"