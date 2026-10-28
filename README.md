# bpara (better paragraph) for micro editor

Better paragraph jumps to the closest line with only whitespace characters. (Micros only jumps to completly empty lines)
If multiple whitespace lines are after an other they get skipped and count only as a single paragraph stop.

## Install

Install with:

`git clone https://github.com/AR-234/micro-bpara.git ~/.config/micro/plug/bpara`

## Bindings `~/.config/mirco/bindings.json`

### Keybindings for bindings.json:

```
"CtrlUp":        "lua:bpara.ParagraphPrevious",
"CtrlDown":      "lua:bpara.ParagraphNext",
"ShiftCtrlDown": "lua:bpara.SelectParagraphNext",
"ShiftCtrlUp":   "lua:bpara.SelectParagraphPrevious"
```

### Keybindings with micro-ydir:

```
"CtrlDown": "lua:bpara.ParagraphNext,lua:ydir.ydir_cursor_end",
"CtrlUp": "lua:bpara.ParagraphPrevious,lua:ydir.ydir_cursor_start",
"ShiftCtrlDown": "lua:bpara.SelectParagraphNext",
"ShiftCtrlUp":   "lua:bpara.SelectParagraphPrevious"
```

## Settings `~/.config/mirco/settings.json`
 - `"bpara.Margin": 5,`
    minimum lines in view, if those are not present center cursor
