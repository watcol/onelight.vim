let s:colors = onelight#get_colors()

let s:black     = s:colors.dark_black
let s:white     = s:colors.bg
let s:grey      = s:colors.cursor
let s:dark_grey = s:colors.visual_grey
let s:blue      = s:colors.blue
let s:green     = s:colors.green
let s:purple    = s:colors.purple
let s:red1      = s:colors.dark_red
let s:red2      = s:colors.red
let s:yellow    = s:colors.yellow
let s:green     = s:colors.green

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.inactive.left   = [ [ s:bg,  s:dark_grey ], [ s:bg, s:dark_grey ] ]
let s:p.inactive.middle = [ [ s:dark_grey, s:grey ] ]
let s:p.inactive.right  = [ [ s:bg, s:dark_grey ] ]
let s:p.normal.left    = [ [ s:bg, s:green, 'bold' ], [ s:fg, s:dark_grey ] ]
let s:p.normal.middle  = [ [ s:fg, s:grey ] ]
let s:p.normal.right   = [ [ s:bg, s:green, 'bold' ], [ s:fg, s:dark_grey ] ]
let s:p.normal.error   = [ [ s:red2, s:bg ] ]
let s:p.normal.warning = [ [ s:yellow, s:bg ] ]
let s:p.insert.right   = [ [ s:bg, s:blue, 'bold' ], [ s:fg, s:dark_grey ] ]
let s:p.insert.left    = [ [ s:bg, s:blue, 'bold' ], [ s:fg, s:dark_grey ] ]
let s:p.replace.right  = [ [ s:bg, s:red1, 'bold' ], [ s:fg, s:dark_grey ] ]
let s:p.replace.left   = [ [ s:bg, s:red1, 'bold' ], [ s:fg, s:dark_grey ] ]
let s:p.visual.right   = [ [ s:bg, s:purple, 'bold' ], [ s:fg, s:dark_grey ] ]
let s:p.visual.left    = [ [ s:bg, s:purple, 'bold' ], [ s:fg, s:dark_grey ] ]
let s:p.tabline.left   = [ [ s:fg, s:dark_grey ] ]
let s:p.tabline.tabsel = [ [ s:bg, s:purple, 'bold' ] ]
let s:p.tabline.middle = [ [ s:dark_grey, s:grey ] ]
let s:p.tabline.right  = copy(s:p.normal.right)

let g:lightline#colorscheme#onelight#palette = lightline#colorscheme#flatten(s:p)
