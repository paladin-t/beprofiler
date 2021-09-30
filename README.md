# beProfiler

beProfiler is a fast function profiler implemented in pure Lua for [Bitty Engine](https://github.com/paladin-t/bitty/). It is ported from [charlesmallah/lua-profiler](https://github.com/charlesmallah/lua-profiler).

### Usage

Setup:

1. Clone this repository
2. Open "src" directly or import it to your own projects with [Bitty Engine](https://github.com/paladin-t/bitty/), "src/libs" is all what you need
3. See code and comments for details

Code:

```lua
require 'libs/beProfiler/beProfiler'

function quit()
  -- Stop profiling.
  beProfiler.stop()
  -- Get report path.
  local path = Project.main:fullPath()
  if Path.existsFile(path) then
    path = FileInfo.new(path):parentPath()
  elseif Path.existsDirectory(path) then
    path = DirectoryInfo.new(path):parentPath()
  end
  path = Path.combine(path, 'profiler.log')
  -- Report it.
  beProfiler.report(path)

  print('Report: ' .. path)
end

function setup()
  -- Start profiling.
  beProfiler.start()
end

function update(delta)
  ...
end
```

Output:

```txt
> Total time: 3.501602 s
--------------------------------------------------------------------------------------
| FILE                : FUNCTION                    : LINE   : TIME   : %     : #    |
--------------------------------------------------------------------------------------
| main                : Anon                        :    90  : 3.5013 : 100.0 :    7 |
| main                : test                        :    59  : 3.5012 : 100.0 :    7 |
| main                : test2                       :    55  : 3.5007 : 100.0 :    7 |
| main                : func2_2                     :    52  : 3.5006 : 100.0 :    7 |
| main                : func2_1                     :    49  : 3.5005 : 100.0 :    7 |
| main                : sleep                       :    28  : 3.5003 : 100.0 :    7 |
| main                : test1                       :    45  : 0.0003 : 0.0   :    7 |
| main                : func1_2                     :    42  : 0.0002 : 0.0   :    7 |
| main                : func1_1                     :    39  : 0.0001 : 0.0   :    7 |
--------------------------------------------------------------------------------------
| [string "libs/beProf: getTime                     :    97  : ~      : ~     :    1 |
| [string "libs/beProf: stop                        :   227  : ~      : ~     :    1 |
| main                : Anon                        :    66  : ~      : ~     :    1 |
--------------------------------------------------------------------------------------
```
