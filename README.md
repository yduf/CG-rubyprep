# C++ #include files packer

Produce a file with all local ```#include "xx"``` directive recursively resolved and expanded, but keeping system ```#include <xx>``` as is.

This can be usefull for sending code on online platform that accept only one uber file, like [Codingame](https://www.codingame.com) for eg. (note that in general they also have a limits on the uber file size: 100k for Codingame).

### Usage
only usefull file in this repo is ```rubyprep.rb```, others serve as testbed.

```ruby \[-Ifolder1\]  \[-I folder2\] ./rubyprep.rb yourfile.cc > result.cc```

ex: 
```ruby -I~/DEV/cpp ./rubyprep.rb local.h > out```

```ansi
[1m[32mmain.cc[0m[22m
[1m[34m+- 1: ./const.hh (723b)[0m[22m
[1m[34m+- 2: ./1-optime.hh (95b)[0m[22m
[1m[34m+- 3: ./2-arch_type.hh (168b)[0m[22m
[1m[34m+- 13: /home/yves/DEV/cpp/myFunc/input_logger.hh (1k)[0m[22m
[1m[34m+- 14: /home/yves/DEV/cpp/myFunc/elapsed.hh (1k)[0m[22m
[1m[34m+- 19: ./state.hh (11k)[0m[22m
[1m[34m   +- 6: /home/yves/DEV/cpp/myFunc/vec.hh (2k)[0m[22m
[1m[34m   +- 7: /home/yves/DEV/cpp/myFunc/to_s.hh (1k)[0m[22m
[1m[34m+- 22: ./beam_search.hh (10k)[0m[22m
...
[1m[32m-> main.cc (81k)[0m[22m
[1m[32mTotal (81k)[0m[22m
```

### Notes & Limitations

The expansions is done:
- without interpreting condition ```#if``` and ```#ifndef```
  - This will cause some wrong behavior when reporting file/line if you guard ```#include "something"``` conditionaly inside ```#if```/```#endif```
- without expanding macros and ```#define```
- as if ```#pragma once``` was used within each files.
- actual  ```#pragma once``` find in local header are commented out, to avoid generating warning when compiling final file

