local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local strings = import("strings")

local function isBlank(bp, y)
	return strings.TrimSpace(bp.Buf:Line(y)) == ""
end

local function target(bp, dir)
	local y = bp.Cursor.Y
	local last = bp.Buf:LinesNum() - 1

	y = y + dir
	-- Skip empty lines following the current
	while y >= 0 and y <= last and isBlank(bp, y) do
		y = y + dir
	end

	-- Find the next blank line
	while y >= 0 and y <= last and not isBlank(bp, y) do
		y = y + dir
	end

	if y < 0 then y = 0 end
	if y > last then y = last end
	return y
end

local function jump(bp, dir, select)
	local y = target(bp, dir)

	if select then
		bp.Cursor:SetSelectionStart(buffer.Loc(0, y))
		bp.Cursor:SetSelectionEnd(buffer.Loc(bp.Cursor.X, bp.Cursor.Y))
	else
		bp.Cursor:Deselect(true)
		bp.Cursor:GotoLoc(buffer.Loc(0, y))
	end

	local margin = config.GetGlobalOption("bpara.Margin")
	local view = bp:GetView()
	local top = view.StartLine.Line
	local bottom = top + view.Height - 1
	local outside = y < top + margin or y > bottom - margin

	if outside then
		bp:Center()
	else
		bp.Cursor:Relocate()
	end
end

function ParagraphPrevious(bp)
	jump(bp, -1, false)
end

function ParagraphNext(bp)
	jump(bp, 1, false)
end

function SelectParagraphPrevious(bp)
	jump(bp, -1, true)
end

function SelectParagraphNext(bp)
	jump(bp, 1, true)
end

function init()
	config.RegisterCommonOption("bpara", "Margin", 5)
end
--[[     

Keybindings for bindings.json:

"CtrlUp":        "lua:bpara.ParagraphPrevious",
"CtrlDown":      "lua:bpara.ParagraphNext",
"ShiftCtrlDown": "lua:bpara.SelectParagraphNext",
"ShiftCtrlUp":   "lua:bpara.SelectParagraphPrevious"


Keybindings with micro-ydir:
"CtrlDown": "lua:bpara.ParagraphNext,lua:ydir.ydir_cursor_end",
"CtrlUp": "lua:bpara.ParagraphPrevious,lua:ydir.ydir_cursor_start",
"ShiftCtrlDown": "lua:bpara.SelectParagraphNext",
"ShiftCtrlUp":   "lua:bpara.SelectParagraphPrevious"
]]
