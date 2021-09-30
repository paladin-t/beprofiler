--[[
The MIT License

Copyright (C) 2021 Tony Wang

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

require 'libs/beProfiler/beProfiler'

Debug.setTimeout(0) -- Disable timeout.

local function sleep(sec)
	local start = DateTime.ticks()
	while true do
		local now = DateTime.ticks()
		local diff = DateTime.toSeconds(now - start)
		if diff >= sec then
			return
		end
	end
end

local function func1_1()
	-- Do nothing.
end
local function func1_2()
	func1_1()
end
local function test1()
	func1_2()
end

local function func2_1()
	sleep(0.5)
end
local function func2_2()
	func2_1()
end
local function test2()
	func2_2()
end

local function test()
	test1()
	test2()
end

local ticks = 0

function quit()
	print('beProfiler v' .. beProfiler.version)

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
	test()

	ticks = ticks + delta
	if ticks >= 3 then -- Run for 3 seconds.
		exit()
	end
end
