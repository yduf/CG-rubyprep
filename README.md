# C++ #include files packer

Produce a file with all local ```#include "xx"``` directive recursively resolved and expanded, but keeping system ```#include <xx>``` as is.

This can be usefull for sending code on online platform that accept only one uber file, like [Codingame](https://www.codingame.com) for eg.

### Usage
only usefull file in this repo is ```rubyprep.rb```, others serve as testbed.

```ruby \[-Ifolder1\]  \[-I folder2\] ./rubyprep.rb yourfile.cc > result.cc```

ex: 
```ruby -I~/DEV/cpp ./rubyprep.rb local.h > out```