# C++ #include files packer

Produce a file with all local ```#include "xx"``` directive recursively resolved and expanded, but keeping system ```#include <xx>``` as is.

This can be usefull for sending code on online platform that accept only one uber file, like [Codingame](https://www.codingame.com) for eg. (note that in general they also have a limits on the uber file size: 100k for Codingame).

### Usage
only usefull file in this repo is ```rubyprep.rb```, others serve as testbed.

```ruby \[-Ifolder1\]  \[-I folder2\] ./rubyprep.rb yourfile.cc > result.cc```

ex: 
```ruby -I~/DEV/cpp ./rubyprep.rb local.h > out```


<pre style="white-space: pre-wrap;">
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f2" style="color: #55FF55; font-weight: normal;">main.cc</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">+- 1: ./const.hh (723b)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">+- 2: ./1-optime.hh (95b)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">+- 3: ./2-arch_type.hh (168b)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">+- 13: /home/yves/DEV/cpp/myFunc/input_logger.hh (1k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">+- 14: /home/yves/DEV/cpp/myFunc/elapsed.hh (1k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">+- 19: ./state.hh (11k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   +- 6: /home/yves/DEV/cpp/myFunc/vec.hh (2k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   +- 7: /home/yves/DEV/cpp/myFunc/to_s.hh (1k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   +- 8: /home/yves/DEV/cpp/myFunc/bits.hh (832b)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   +- 9: /home/yves/DEV/cpp/myFunc/color.hh (1k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 11: ./const.hh (723b) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   +- 12: ./bitboard.hh (2k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 5: ./const.hh (723b) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   +- 13: ./zobrist.hh (2k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 2: /home/yves/DEV/cpp/myFunc/vec.hh (2k) =&gt; already included - skipping
</span><span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  +- 3: /home/yves/DEV/cpp/myFunc/random/splitmix64.hh (1k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  |  +- 2: /home/yves/DEV/cpp/myFunc/random/rd.hh (54b)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 5: ./const.hh (723b) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   +- 14: ./action.hh (974b)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 5: /home/yves/DEV/cpp/myFunc/vec.hh (2k) =&gt; already included - skipping
</span><span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  +- 6: ./array.hh (3k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 8: ./const.hh (723b) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">+- 20: ./sim.hh (21k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 2: /home/yves/DEV/cpp/myFunc/bits.hh (832b) =&gt; already included - skipping
</span><span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   +- 3: /home/yves/DEV/cpp/myFunc/vec_stream.hh (578b)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 4: /home/yves/DEV/cpp/myFunc/to_s.hh (1k) =&gt; already included - skipping
</span><span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 5: /home/yves/DEV/cpp/myFunc/vec.hh (2k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 5: ./state.hh (11k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 6: ./action.hh (974b) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   +- 7: ./bfs.hh (2k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 4: /home/yves/DEV/cpp/myFunc/bits.hh (832b) =&gt; already included - skipping
</span><span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 5: ./bitboard.hh (2k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">+- 21: ./fitness.hh (1k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 3: ./sim.hh (21k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 4: /home/yves/DEV/cpp/myFunc/vec.hh (2k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">+- 22: ./beam_search.hh (10k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 4: /home/yves/DEV/cpp/myFunc/elapsed.hh (1k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 5: /home/yves/DEV/cpp/myFunc/to_s.hh (1k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 10: ./const.hh (723b) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 11: ./state.hh (11k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 12: ./sim.hh (21k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   +- 13: ./legal_action.hh (2k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 1: ./action.hh (974b) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 2: ./state.hh (11k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  +- 81: /home/yves/DEV/cpp/myFunc/ruby.hh (1k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  |  </span></span><span class="f7" style="color: #AAAAAA;">+- 5: /home/yves/DEV/cpp/myFunc/color.hh (1k) =&gt; already included - skipping
</span><span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   +- 14: ./metrics.hh (6k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 1: ./const.hh (723b) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 2: ./2-arch_type.hh (168b) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   |  </span></span><span class="f7" style="color: #AAAAAA;">+- 4: ./sim.hh (21k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f4" style="color: #5555FF; font-weight: normal;">   </span></span><span class="f7" style="color: #AAAAAA;">+- 15: ./fitness.hh (1k) =&gt; already included - skipping</span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f2" style="color: #55FF55; font-weight: normal;">-&gt; main.cc (81k)</span></span>
<span class="bold" style="color: #000000; font-weight: bold;"><span class="f2" style="color: #55FF55; font-weight: normal;">Total (81k)</span></span>
</pre>

  
### Notes & Limitations

The expansions is done:
- without interpreting condition ```#if``` and ```#ifndef```
  - This will cause some wrong behavior when reporting file/line if you guard ```#include "something"``` conditionaly inside ```#if```/```#endif```
- without expanding macros and ```#define```
- as if ```#pragma once``` was used within each files.
- actual  ```#pragma once``` find in local header are commented out, to avoid generating warning when compiling final file

