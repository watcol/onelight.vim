let s:colors = onelight#get_colors()

let s:black  = s:colors.dark_black
let s:white  = s:colors.bg
let s:grey   = s:colors.special_grey
let s:blue   = s:colors.blue
let s:green  = s:colors.green
let s:purple = s:colors.purple
let s:red    = s:colors.dark_red
let s:yellow = s:colors.yellow
let s:green  = s:colors.green

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.inactive.left   = [ [ s:white,  s:grey ], [ s:white, s:grey ] ]
let s:p.inactive.middle = [ [ s:grey, s:white ] ]
let s:p.inactive.right  = [ [ s:white, s:grey ] ]
let s:p.normal.left     = [ [ s:white, s:green, 'bold' ], [ s:black, s:grey ] ]
let s:p.normal.middle   = [ [ s:black, s:white ] ]
let s:p.normal.right    = [ [ s:white, s:green, 'bold' ], [ s:black, s:grey ] ]
let s:p.normal.error    = [ [ s:red, s:white ] ]
let s:p.normal.warning  = [ [ s:yellow, s:white ] ]
let s:p.insert.right    = [ [ s:white, s:blue, 'bold' ], [ s:black, s:grey ] ]
let s:p.insert.left     = [ [ s:white, s:blue, 'bold' ], [ s:black, s:grey ] ]
let s:p.replace.right   = [ [ s:white, s:red, 'bold' ], [ s:black, s:grey ] ]
let s:p.replace.left    = [ [ s:white, s:red, 'bold' ], [ s:black, s:grey ] ]
let s:p.visual.right    = [ [ s:white, s:purple, 'bold' ], [ s:black, s:grey ] ]
let s:p.visual.left     = [ [ s:white, s:purple, 'bold' ], [ s:black, s:grey ] ]
let s:p.tabline.left    = [ [ s:black, s:grey ] ]
let s:p.tabline.tabsel  = [ [ s:white, s:blue, 'bold' ] ]
let s:p.tabline.middle  = [ [ s:grey, s:white ] ]
let s:p.tabline.right   = [ [ s:black, s:grey ] ]

let g:lightline#colorscheme#onelight#palette = lightline#colorscheme#flatten(s:p)
