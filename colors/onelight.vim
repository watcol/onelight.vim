" Name:    one vim colorscheme
" Author:  Ramzi Akremi
" License: MIT
" Version: 1.1.1-pre

" Global setup =============================================================={{{

if exists("*<SID>X")
  delf <SID>X
  delf <SID>XAPI
  delf <SID>rgb
  delf <SID>color
  delf <SID>rgb_color
  delf <SID>rgb_level
  delf <SID>rgb_number
  delf <SID>grey_color
  delf <SID>grey_level
  delf <SID>grey_number
endif

hi clear
syntax reset
if exists('g:colors_name')
  unlet g:colors_name
endif
let g:colors_name = 'onelight'

if !exists('g:onelight_allow_italics')
  let g:onelight_allow_italics = 0
endif

let s:italic = ''
if g:onelight_allow_italics == 1
  let s:italic = 'italic'
endif
" }}}

if has('gui_running') || has('termguicolors') || &t_Co == 88 || &t_Co == 256
  " functions
  " returns an approximate grey index for the given grey level

  " Utility functions -------------------------------------------------------{{{
  fun <SID>grey_number(x)
    if &t_Co == 88
      if a:x < 23
        return 0
      elseif a:x < 69
        return 1
      elseif a:x < 103
        return 2
      elseif a:x < 127
        return 3
      elseif a:x < 150
        return 4
      elseif a:x < 173
        return 5
      elseif a:x < 196
        return 6
      elseif a:x < 219
        return 7
      elseif a:x < 243
        return 8
      else
        return 9
      endif
    else
      if a:x < 14
        return 0
      else
        let l:n = (a:x - 8) / 10
        let l:m = (a:x - 8) % 10
        if l:m < 5
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " returns the actual grey level represented by the grey index
  fun <SID>grey_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 46
      elseif a:n == 2
        return 92
      elseif a:n == 3
        return 115
      elseif a:n == 4
        return 139
      elseif a:n == 5
        return 162
      elseif a:n == 6
        return 185
      elseif a:n == 7
        return 208
      elseif a:n == 8
        return 231
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 8 + (a:n * 10)
      endif
    endif
  endfun

  " returns the palette index for the given grey index
  fun <SID>grey_color(n)
    if &t_Co == 88
      if a:n == 0
        return 16
      elseif a:n == 9
        return 79
      else
        return 79 + a:n
      endif
    else
      if a:n == 0
        return 16
      elseif a:n == 25
        return 231
      else
        return 231 + a:n
      endif
    endif
  endfun

  " returns an approximate color index for the given color level
  fun <SID>rgb_number(x)
    if &t_Co == 88
      if a:x < 69
        return 0
      elseif a:x < 172
        return 1
      elseif a:x < 230
        return 2
      else
        return 3
      endif
    else
      if a:x < 75
        return 0
      else
        let l:n = (a:x - 55) / 40
        let l:m = (a:x - 55) % 40
        if l:m < 20
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " returns the actual color level for the given color index
  fun <SID>rgb_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 139
      elseif a:n == 2
        return 205
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 55 + (a:n * 40)
      endif
    endif
  endfun

  " returns the palette index for the given R/G/B color indices
  fun <SID>rgb_color(x, y, z)
    if &t_Co == 88
      return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
      return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
  endfun

  " returns the palette index to approximate the given R/G/B color levels
  fun <SID>color(r, g, b)
    " get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)

    " get the closest color
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)

    if l:gx == l:gy && l:gy == l:gz
      " there are two possibilities
      let l:dgr = <SID>grey_level(l:gx) - a:r
      let l:dgg = <SID>grey_level(l:gy) - a:g
      let l:dgb = <SID>grey_level(l:gz) - a:b
      let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
      let l:dr = <SID>rgb_level(l:gx) - a:r
      let l:dg = <SID>rgb_level(l:gy) - a:g
      let l:db = <SID>rgb_level(l:gz) - a:b
      let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
      if l:dgrey < l:drgb
        " use the grey
        return <SID>grey_color(l:gx)
      else
        " use the color
        return <SID>rgb_color(l:x, l:y, l:z)
      endif
    else
      " only one possibility
      return <SID>rgb_color(l:x, l:y, l:z)
    endif
  endfun

  " returns the palette index to approximate the 'rrggbb' hex string
  fun <SID>rgb(rgb)
    let l:r = ('0x' . strpart(a:rgb, 0, 2)) + 0
    let l:g = ('0x' . strpart(a:rgb, 2, 2)) + 0
    let l:b = ('0x' . strpart(a:rgb, 4, 2)) + 0

    return <SID>color(l:r, l:g, l:b)
  endfun

  " sets the highlighting for the given group
  fun <SID>XAPI(group, fg, bg, attr)
    let l:attr = a:attr
    if g:one_allow_italics == 0 && l:attr ==? 'italic'
      let l:attr= 'none'
    endif

    let l:bg = ""
    let l:fg = ""
    let l:decoration = ""

    if a:bg != ''
      let l:bg = " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
    endif

    if a:fg != ''
      let l:fg = " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
    endif

    if a:attr != ''
      let l:decoration = " gui=" . l:attr . " cterm=" . l:attr
    endif

    let l:exec = l:fg . l:bg . l:decoration

    if l:exec != ''
      exec "hi " . a:group . l:exec
    endif

  endfun

  " Highlight function
  " the original one is borrowed from mhartington/oceanic-next
  function! <SID>X(group, fg, bg, attr, ...)
    let l:attrsp = get(a:, 1, "")
    " fg, bg, attr, attrsp
    if !empty(a:fg)
      exec "hi " . a:group . " guifg=" .  a:fg[0]
      exec "hi " . a:group . " ctermfg=" . a:fg[1]
    endif
    if !empty(a:bg)
      exec "hi " . a:group . " guibg=" .  a:bg[0]
      exec "hi " . a:group . " ctermbg=" . a:bg[1]
    endif
    if a:attr != ""
      exec "hi " . a:group . " gui=" .   a:attr
      exec "hi " . a:group . " cterm=" . a:attr
    endif
    if !empty(l:attrsp)
      exec "hi " . a:group . " guisp=" . l:attrsp[0]
    endif
  endfunction

  " }}}

  " Color definition --------------------------------------------------------{{{
  let s:colors = onelight#get_colors()

  let s:dark_black = s:colors.dark_black
  let s:black = s:colors.black
  let s:dark_grey = s:colors.dark_grey
  let s:grey = s:colors.grey

  let s:cyan  = s:colors.cyan
  let s:blue  = s:colors.blue
  let s:purple  = s:colors.purple
  let s:green  = s:colors.green

  let s:dark_red   = s:colors.dark_red
  let s:red = s:colors.red

  let s:dark_yellow   = s:colors.dark_yellow
  let s:yellow = s:colors.yellow

  let s:bg     = s:colors.bg
  let s:gutter = s:colors.gutter
  let s:cursor = s:colors.cursor

  let s:accent = s:colors.accent
  let s:accent2 = s:colors.accent2

  let s:vertsplit    = s:colors.vertsplit
  let s:special_grey = s:colors.special_grey
  let s:visual_grey  = s:colors.visual_grey
  let s:pmenu        = s:colors.pmenu

  let s:fg = s:dark_black
  let s:fold_bg = s:dark_grey

  " }}}

  " Terminal Colors --------------------------------------------------------{{{
  if has('nvim')
    let g:terminal_color_0  = s:dark_black[0]
    let g:terminal_color_1  = s:dark_red[0]
    let g:terminal_color_2  = s:green[0]
    let g:terminal_color_3  = s:dark_yellow[0]
    let g:terminal_color_4  = s:blue[0]
    let g:terminal_color_5  = s:purple[0]
    let g:terminal_color_6  = s:cyan[0]
    let g:terminal_color_7  = s:dark_grey[0]
    let g:terminal_color_8  = s:black[0]
    let g:terminal_color_9  = s:red[0]
    let g:terminal_color_10 = s:green[0]
    let g:terminal_color_11 = s:yellow[0]
    let g:terminal_color_12 = s:blue[0]
    let g:terminal_color_13 = s:purple[0]
    let g:terminal_color_14 = s:cyan[0]
    let g:terminal_color_15 = s:grey[0]
  else
    let g:terminal_ansi_colors = [
    \ s:dark_black[0],
    \ s:dark_red[0],
    \ s:green[0],
    \ s:dark_yellow[0],
    \ s:blue[0],
    \ s:purple[0],
    \ s:cyan[0],
    \ s:dark_grey[0],
    \ s:black[0],
    \ s:red[0],
    \ s:green[0],
    \ s:yellow[0],
    \ s:blue[0],
    \ s:purple[0],
    \ s:cyan[0],
    \ s:grey[0],
    \]
  endif
  " }}}

  " Vim editor color --------------------------------------------------------{{{
  call <sid>X('Normal',       s:fg,           s:bg,          '')
  call <sid>X('bold',         '',             '',            'bold')
  call <sid>X('ColorColumn',  '',             s:cursor,      '')
  call <sid>X('Conceal',      s:grey,         s:bg,          '')
  call <sid>X('Cursor',       '',             s:accent,      '')
  call <sid>X('CursorIM',     '',             '',            '')
  call <sid>X('CursorColumn', '',             s:cursor,      '')
  call <sid>X('CursorLine',   '',             s:cursor,      'none')
  call <sid>X('Directory',    s:blue,         '',            '')
  call <sid>X('ErrorMsg',     s:dark_red,     s:bg,          'none')
  call <sid>X('VertSplit',    s:cursor,       s:cursor,      'none')
  call <sid>X('Folded',       s:fg,           s:bg,          'none')
  call <sid>X('FoldColumn',   s:dark_grey,    s:cursor,      '')
  call <sid>X('IncSearch',    s:yellow,       s:visual_grey, 'none')
  call <sid>X('LineNr',       s:grey,         '',            '')
  call <sid>X('CursorLineNr', s:fg,           s:cursor,      'none')
  call <sid>X('MatchParen',   s:dark_red,     s:cursor,      'underline,bold')
  call <sid>X('Italic',       '',             '',            s:italic)
  call <sid>X('ModeMsg',      s:fg,           '',            '')
  call <sid>X('MoreMsg',      s:fg,           '',            '')
  call <sid>X('NonText',      s:dark_grey,    '',            'none')
  call <sid>X('PMenu',        '',             s:pmenu,       '')
  call <sid>X('PMenuSel',     '',             s:grey,        '')
  call <sid>X('PMenuSbar',    '',             s:bg,          '')
  call <sid>X('PMenuThumb',   '',             s:dark_black,  '')
  call <sid>X('Question',     s:blue,         '',            '')
  call <sid>X('Search',       s:yellow,       s:visual_grey, '')
  call <sid>X('SpecialKey',   s:special_grey, '',            'none')
  call <sid>X('Whitespace',   s:special_grey, '',            'none')
  call <sid>X('StatusLine',   s:fg,           s:cursor,      'none')
  call <sid>X('StatusLineNC', s:dark_grey,    '',            '')
  call <sid>X('TabLine',      s:black,        s:visual_grey, 'none')
  call <sid>X('TabLineFill',  s:dark_grey,    s:visual_grey, 'none')
  call <sid>X('TabLineSel',   s:bg,           s:blue,        '')
  call <sid>X('Title',        s:fg,           '',            'bold')
  call <sid>X('Visual',       '',             s:visual_grey, '')
  call <sid>X('VisualNOS',    '',             s:visual_grey, '')
  call <sid>X('WarningMsg',   s:dark_red,     '',            '')
  call <sid>X('TooLong',      s:dark_red,     '',            '')
  call <sid>X('WildMenu',     s:fg,           s:dark_grey,   '')
  call <sid>X('SignColumn',   '',             s:bg,          '')
  call <sid>X('Special',      s:blue,         '',            '')
  " }}}

  " Vim Help highlighting ---------------------------------------------------{{{
  call <sid>X('helpCommand',      s:yellow,     '', '')
  call <sid>X('helpExample',      s:yellow,     '', '')
  call <sid>X('helpHeader',       s:dark_black, '', 'bold')
  call <sid>X('helpSectionDelim', s:dark_grey,  '', '')
  " }}}

  " Standard syntax highlighting --------------------------------------------{{{
  call <sid>X('Comment',        s:dark_grey,   '',   s:italic)
  call <sid>X('Constant',       s:green,       '',   '')
  call <sid>X('String',         s:green,       '',   '')
  call <sid>X('Character',      s:green,       '',   '')
  call <sid>X('Number',         s:dark_yellow, '',   '')
  call <sid>X('Boolean',        s:dark_yellow, '',   '')
  call <sid>X('Float',          s:dark_yellow, '',   '')
  call <sid>X('Identifier',     s:dark_red,    '',   'none')
  call <sid>X('Function',       s:blue,        '',   '')
  call <sid>X('Statement',      s:purple,      '',   'none')
  call <sid>X('Conditional',    s:purple,      '',   '')
  call <sid>X('Repeat',         s:purple,      '',   '')
  call <sid>X('Label',          s:purple,      '',   '')
  call <sid>X('Operator',       s:accent,      '',   'none')
  call <sid>X('Keyword',        s:dark_red,    '',   '')
  call <sid>X('Exception',      s:purple,      '',   '')
  call <sid>X('PreProc',        s:yellow,      '',   '')
  call <sid>X('Include',        s:blue,        '',   '')
  call <sid>X('Define',         s:purple,      '',   'none')
  call <sid>X('Macro',          s:purple,      '',   '')
  call <sid>X('PreCondit',      s:yellow,      '',   '')
  call <sid>X('Type',           s:yellow,      '',   'none')
  call <sid>X('StorageClass',   s:yellow,      '',   '')
  call <sid>X('Structure',      s:yellow,      '',   '')
  call <sid>X('Typedef',        s:yellow,      '',   '')
  call <sid>X('Special',        s:blue,        '',   '')
  call <sid>X('SpecialChar',    '',            '',   '')
  call <sid>X('Tag',            '',            '',   '')
  call <sid>X('Delimiter',      '',            '',   '')
  call <sid>X('SpecialComment', '',            '',   '')
  call <sid>X('Debug',          '',            '',   '')
  call <sid>X('Underlined',     '',            '',   'underline')
  call <sid>X('Ignore',         '',            '',   '')
  call <sid>X('Error',          s:dark_red,    s:bg, 'bold')
  call <sid>X('Todo',           s:purple,      s:bg, '')
  " }}}

  " Diff highlighting -------------------------------------------------------{{{
  call <sid>X('DiffAdd',     s:green,       '', '')
  call <sid>X('DiffChange',  s:dark_yellow, '', '')
  call <sid>X('DiffDelete',  s:dark_red,    '', '')
  call <sid>X('DiffText',    s:blue,        '', '')
  call <sid>X('DiffAdded',   s:green,       '', '')
  call <sid>X('DiffFile',    s:dark_red,    '', '')
  call <sid>X('DiffNewFile', s:green,       '', '')
  call <sid>X('DiffLine',    s:blue,        '', '')
  call <sid>X('DiffRemoved', s:dark_red,    '', '')
  " }}}

  " Asciidoc highlighting ---------------------------------------------------{{{
  call <sid>X('asciidocListingBlock', s:black, '', '')
  " }}}

  " C/C++ highlighting ------------------------------------------------------{{{
  call <sid>X('cInclude',           s:purple,      '', '')
  call <sid>X('cPreCondit',         s:purple,      '', '')
  call <sid>X('cPreConditMatch',    s:purple,      '', '')

  call <sid>X('cType',              s:purple,      '', '')
  call <sid>X('cStorageClass',      s:purple,      '', '')
  call <sid>X('cStructure',         s:purple,      '', '')
  call <sid>X('cOperator',          s:purple,      '', '')
  call <sid>X('cStatement',         s:purple,      '', '')
  call <sid>X('cTODO',              s:purple,      '', '')
  call <sid>X('cConstant',          s:dark_yellow, '', '')
  call <sid>X('cSpecial',           s:cyan,        '', '')
  call <sid>X('cSpecialCharacter',  s:cyan,        '', '')
  call <sid>X('cString',            s:green,       '', '')

  call <sid>X('cppType',            s:purple,      '', '')
  call <sid>X('cppStorageClass',    s:purple,      '', '')
  call <sid>X('cppStructure',       s:purple,      '', '')
  call <sid>X('cppModifier',        s:purple,      '', '')
  call <sid>X('cppOperator',        s:purple,      '', '')
  call <sid>X('cppAccess',          s:purple,      '', '')
  call <sid>X('cppStatement',       s:purple,      '', '')
  call <sid>X('cppConstant',        s:dark_red,    '', '')
  call <sid>X('cCppString',         s:green,       '', '')
  " }}}

  " Cucumber highlighting ---------------------------------------------------{{{
  call <sid>X('cucumberGiven',           s:blue,        '', '')
  call <sid>X('cucumberWhen',            s:blue,        '', '')
  call <sid>X('cucumberWhenAnd',         s:blue,        '', '')
  call <sid>X('cucumberThen',            s:blue,        '', '')
  call <sid>X('cucumberThenAnd',         s:blue,        '', '')
  call <sid>X('cucumberUnparsed',        s:dark_yellow, '', '')
  call <sid>X('cucumberFeature',         s:dark_red,    '', 'bold')
  call <sid>X('cucumberBackground',      s:purple,      '', 'bold')
  call <sid>X('cucumberScenario',        s:purple,      '', 'bold')
  call <sid>X('cucumberScenarioOutline', s:purple,      '', 'bold')
  call <sid>X('cucumberTags',            s:dark_grey,   '', 'bold')
  call <sid>X('cucumberDelimiter',       s:dark_grey,   '', 'bold')
  " }}}

  " CSS/Sass highlighting ---------------------------------------------------{{{
  call <sid>X('cssAttrComma',         s:purple,      '', '')
  call <sid>X('cssAttributeSelector', s:green,       '', '')
  call <sid>X('cssBraces',            s:black,       '', '')
  call <sid>X('cssClassName',         s:dark_yellow, '', '')
  call <sid>X('cssClassNameDot',      s:dark_yellow, '', '')
  call <sid>X('cssDefinition',        s:purple,      '', '')
  call <sid>X('cssFontAttr',          s:dark_yellow, '', '')
  call <sid>X('cssFontDescriptor',    s:purple,      '', '')
  call <sid>X('cssFunctionName',      s:blue,        '', '')
  call <sid>X('cssIdentifier',        s:blue,        '', '')
  call <sid>X('cssImportant',         s:purple,      '', '')
  call <sid>X('cssInclude',           s:dark_black,  '', '')
  call <sid>X('cssIncludeKeyword',    s:purple,      '', '')
  call <sid>X('cssMediaType',         s:dark_yellow, '', '')
  call <sid>X('cssProp',              s:cyan,        '', '')
  call <sid>X('cssPseudoClassId',     s:dark_yellow, '', '')
  call <sid>X('cssSelectorOp',        s:purple,      '', '')
  call <sid>X('cssSelectorOp2',       s:purple,      '', '')
  call <sid>X('cssStringQ',           s:green,       '', '')
  call <sid>X('cssStringQQ',          s:green,       '', '')
  call <sid>X('cssTagName',           s:dark_red,    '', '')
  call <sid>X('cssAttr',              s:dark_yellow, '', '')

  call <sid>X('sassAmpersand',      s:dark_red,   '', '')
  call <sid>X('sassClass',          s:yellow,     '', '')
  call <sid>X('sassControl',        s:purple,     '', '')
  call <sid>X('sassExtend',         s:purple,     '', '')
  call <sid>X('sassFor',            s:dark_black, '', '')
  call <sid>X('sassProperty',       s:cyan,       '', '')
  call <sid>X('sassFunction',       s:cyan,       '', '')
  call <sid>X('sassId',             s:blue,       '', '')
  call <sid>X('sassInclude',        s:purple,     '', '')
  call <sid>X('sassMedia',          s:purple,     '', '')
  call <sid>X('sassMediaOperators', s:dark_black, '', '')
  call <sid>X('sassMixin',          s:purple,     '', '')
  call <sid>X('sassMixinName',      s:blue,       '', '')
  call <sid>X('sassMixing',         s:purple,     '', '')

  call <sid>X('scssSelectorName',   s:yellow,     '', '')
  " }}}

  " Elixir highlighting------------------------------------------------------{{{
  hi link elixirModuleDefine Define
  call <sid>X('elixirAlias',             s:yellow,      '', '')
  call <sid>X('elixirAtom',              s:cyan,        '', '')
  call <sid>X('elixirBlockDefinition',   s:purple,      '', '')
  call <sid>X('elixirModuleDeclaration', s:dark_yellow, '', '')
  call <sid>X('elixirInclude',           s:dark_red,    '', '')
  call <sid>X('elixirOperator',          s:dark_yellow, '', '')
  " }}}

  " Git and git related plugins highlighting --------------------------------{{{
  call <sid>X('gitcommitComment',       s:dark_grey, '', '')
  call <sid>X('gitcommitUnmerged',      s:green,     '', '')
  call <sid>X('gitcommitOnBranch',      '',          '', '')
  call <sid>X('gitcommitBranch',        s:purple,    '', '')
  call <sid>X('gitcommitDiscardedType', s:dark_red,  '', '')
  call <sid>X('gitcommitSelectedType',  s:green,     '', '')
  call <sid>X('gitcommitHeader',        '',          '', '')
  call <sid>X('gitcommitUntrackedFile', s:cyan,      '', '')
  call <sid>X('gitcommitDiscardedFile', s:dark_red,  '', '')
  call <sid>X('gitcommitSelectedFile',  s:green,     '', '')
  call <sid>X('gitcommitUnmergedFile',  s:yellow,    '', '')
  call <sid>X('gitcommitFile',          '',          '', '')
  hi link gitcommitNoBranch       gitcommitBranch
  hi link gitcommitUntracked      gitcommitComment
  hi link gitcommitDiscarded      gitcommitComment
  hi link gitcommitSelected       gitcommitComment
  hi link gitcommitDiscardedArrow gitcommitDiscardedFile
  hi link gitcommitSelectedArrow  gitcommitSelectedFile
  hi link gitcommitUnmergedArrow  gitcommitUnmergedFile

  call <sid>X('SignifySignAdd',    s:green,    '', '')
  call <sid>X('SignifySignChange', s:yellow,   '', '')
  call <sid>X('SignifySignDelete', s:dark_red, '', '')
  hi link GitGutterAdd    SignifySignAdd
  hi link GitGutterChange SignifySignChange
  hi link GitGutterDelete SignifySignDelete
  call <sid>X('diffAdded',         s:green,    '', '')
  call <sid>X('diffRemoved',       s:dark_red, '', '')
  " }}}

  " Go highlighting ---------------------------------------------------------{{{
  call <sid>X('goDeclaration',         s:purple,   '', '')
  call <sid>X('goField',               s:dark_red, '', '')
  call <sid>X('goMethod',              s:cyan,     '', '')
  call <sid>X('goType',                s:purple,   '', '')
  call <sid>X('goUnsignedInts',        s:cyan,     '', '')
  " }}}

  " Haskell highlighting ----------------------------------------------------{{{
  call <sid>X('haskellDeclKeyword',    s:blue,        '', '')
  call <sid>X('haskellType',           s:green,       '', '')
  call <sid>X('haskellWhere',          s:dark_red,    '', '')
  call <sid>X('haskellImportKeywords', s:blue,        '', '')
  call <sid>X('haskellOperators',      s:dark_red,    '', '')
  call <sid>X('haskellDelimiter',      s:blue,        '', '')
  call <sid>X('haskellIdentifier',     s:dark_yellow, '', '')
  call <sid>X('haskellKeyword',        s:dark_red,    '', '')
  call <sid>X('haskellNumber',         s:cyan,        '', '')
  call <sid>X('haskellString',         s:cyan,        '', '')
  "}}}

  " HTML highlighting -------------------------------------------------------{{{
  call <sid>X('htmlArg',            s:dark_yellow,  '', '')
  call <sid>X('htmlTagName',        s:dark_red,     '', '')
  call <sid>X('htmlTagN',           s:dark_red,     '', '')
  call <sid>X('htmlSpecialTagName', s:dark_red,     '', '')
  call <sid>X('htmlTag',            s:black,        '', '')
  call <sid>X('htmlEndTag',         s:black,        '', '')

  call <sid>X('MatchTag', s:dark_red, s:cursor, 'underline,bold')
  " }}}

  " JavaScript highlighting -------------------------------------------------{{{
  call <sid>X('coffeeString',           s:green,       '', '')

  call <sid>X('javaScriptBraces',       s:black,       '', '')
  call <sid>X('javaScriptFunction',     s:purple,      '', '')
  call <sid>X('javaScriptIdentifier',   s:purple,      '', '')
  call <sid>X('javaScriptNull',         s:dark_yellow, '', '')
  call <sid>X('javaScriptNumber',       s:dark_yellow, '', '')
  call <sid>X('javaScriptRequire',      s:cyan,        '', '')
  call <sid>X('javaScriptReserved',     s:purple,      '', '')
  " https://github.com/pangloss/vim-javascript
  call <sid>X('jsArrowFunction',        s:purple,      '', '')
  call <sid>X('jsBraces',               s:black,       '', '')
  call <sid>X('jsClassBraces',          s:black,       '', '')
  call <sid>X('jsClassKeywords',        s:purple,      '', '')
  call <sid>X('jsDocParam',             s:blue,        '', '')
  call <sid>X('jsDocTags',              s:purple,      '', '')
  call <sid>X('jsFuncBraces',           s:black,       '', '')
  call <sid>X('jsFuncCall',             s:blue,        '', '')
  call <sid>X('jsFuncParens',           s:black,       '', '')
  call <sid>X('jsFunction',             s:purple,      '', '')
  call <sid>X('jsGlobalObjects',        s:yellow,      '', '')
  call <sid>X('jsModuleWords',          s:purple,      '', '')
  call <sid>X('jsModules',              s:purple,      '', '')
  call <sid>X('jsNoise',                s:black,       '', '')
  call <sid>X('jsNull',                 s:dark_yellow, '', '')
  call <sid>X('jsOperator',             s:purple,      '', '')
  call <sid>X('jsParens',               s:black,       '', '')
  call <sid>X('jsStorageClass',         s:purple,      '', '')
  call <sid>X('jsTemplateBraces',       s:red,         '', '')
  call <sid>X('jsTemplateVar',          s:green,       '', '')
  call <sid>X('jsThis',                 s:dark_red,    '', '')
  call <sid>X('jsUndefined',            s:dark_yellow, '', '')
  call <sid>X('jsObjectValue',          s:blue,        '', '')
  call <sid>X('jsObjectKey',            s:cyan,        '', '')
  call <sid>X('jsReturn',               s:purple,      '', '')
  " https://github.com/othree/yajs.vim
  call <sid>X('javascriptArrowFunc',    s:purple,      '', '')
  call <sid>X('javascriptClassExtends', s:purple,      '', '')
  call <sid>X('javascriptClassKeyword', s:purple,      '', '')
  call <sid>X('javascriptDocNotation',  s:purple,      '', '')
  call <sid>X('javascriptDocParamName', s:blue,        '', '')
  call <sid>X('javascriptDocTags',      s:purple,      '', '')
  call <sid>X('javascriptEndColons',    s:dark_grey,   '', '')
  call <sid>X('javascriptExport',       s:purple,      '', '')
  call <sid>X('javascriptFuncArg',      s:dark_black,  '', '')
  call <sid>X('javascriptFuncKeyword',  s:purple,      '', '')
  call <sid>X('javascriptIdentifier',   s:dark_red,    '', '')
  call <sid>X('javascriptImport',       s:purple,      '', '')
  call <sid>X('javascriptObjectLabel',  s:dark_black,  '', '')
  call <sid>X('javascriptOpSymbol',     s:cyan,        '', '')
  call <sid>X('javascriptOpSymbols',    s:cyan,        '', '')
  call <sid>X('javascriptPropertyName', s:green,       '', '')
  call <sid>X('javascriptTemplateSB',   s:red,         '', '')
  call <sid>X('javascriptVariable',     s:purple,      '', '')
  " }}}

  " JSON highlighting -------------------------------------------------------{{{
  call <sid>X('jsonCommentError',         s:dark_black,  '', '')
  call <sid>X('jsonKeyword',              s:dark_red,    '', '')
  call <sid>X('jsonQuote',                s:dark_grey,   '', '')
  call <sid>X('jsonTrailingCommaError',   s:dark_red,    '', 'reverse')
  call <sid>X('jsonMissingCommaError',    s:dark_red,    '', 'reverse')
  call <sid>X('jsonNoQuotesError',        s:dark_red,    '', 'reverse')
  call <sid>X('jsonNumError',             s:dark_red,    '', 'reverse')
  call <sid>X('jsonString',               s:green,       '', '')
  call <sid>X('jsonBoolean',              s:purple,      '', '')
  call <sid>X('jsonNumber',               s:dark_yellow, '', '')
  call <sid>X('jsonStringSQError',        s:dark_red,    '', 'reverse')
  call <sid>X('jsonSemicolonError',       s:dark_red,    '', 'reverse')
  " }}}

  " Markdown highlighting ---------------------------------------------------{{{
  call <sid>X('markdownUrl',              s:dark_grey,   '', '')
  call <sid>X('markdownBold',             s:dark_yellow, '', 'bold')
  call <sid>X('markdownItalic',           s:dark_yellow, '', 'bold')
  call <sid>X('markdownCode',             s:green,       '', '')
  call <sid>X('markdownCodeBlock',        s:dark_red,    '', '')
  call <sid>X('markdownCodeDelimiter',    s:green,       '', '')
  call <sid>X('markdownHeadingDelimiter', s:red,         '', '')
  call <sid>X('markdownH1',               s:dark_red,    '', '')
  call <sid>X('markdownH2',               s:dark_red,    '', '')
  call <sid>X('markdownH3',               s:dark_red,    '', '')
  call <sid>X('markdownH3',               s:dark_red,    '', '')
  call <sid>X('markdownH4',               s:dark_red,    '', '')
  call <sid>X('markdownH5',               s:dark_red,    '', '')
  call <sid>X('markdownH6',               s:dark_red,    '', '')
  call <sid>X('markdownListMarker',       s:dark_red,    '', '')
  " }}}

  " Perl highlighting -------------------------------------------------------{{{
  call <sid>X('perlFunction',      s:purple,    '', '')
  call <sid>X('perlMethod',        s:fg,        '', '')
  call <sid>X('perlPackageConst',  s:purple,    '', '')
  call <sid>X('perlPOD',           s:dark_grey, '', '')
  call <sid>X('perlSubName',       s:fg,        '', '')
  call <sid>X('perlSharpBang',     s:dark_grey, '', '')
  call <sid>X('perlSpecialString', s:green,     '', '')
  call <sid>X('perlVarPlain',      s:blue,      '', '')
  call <sid>X('podCommand',        s:dark_grey, '', '')
  " }}}

  " PHP highlighting --------------------------------------------------------{{{
  call <sid>X('phpClass',        s:yellow,    '', '')
  call <sid>X('phpFunction',     s:blue,      '', '')
  call <sid>X('phpFunctions',    s:blue,      '', '')
  call <sid>X('phpInclude',      s:purple,    '', '')
  call <sid>X('phpKeyword',      s:purple,    '', '')
  call <sid>X('phpParent',       s:dark_grey, '', '')
  call <sid>X('phpType',         s:purple,    '', '')
  call <sid>X('phpSuperGlobals', s:dark_red,  '', '')
  " }}}

  " Pug (Formerly Jade) highlighting ----------------------------------------{{{
  call <sid>X('pugAttributesDelimiter',   s:dark_yellow, '', '')
  call <sid>X('pugClass',                 s:dark_yellow, '', '')
  call <sid>X('pugDocType',               s:dark_grey,   '', s:italic)
  call <sid>X('pugTag',                   s:dark_red,    '', '')
  " }}}

  " PureScript highlighting -------------------------------------------------{{{
  call <sid>X('purescriptKeyword',          s:purple,   '', '')
  call <sid>X('purescriptModuleName',       s:fg,       '', '')
  call <sid>X('purescriptIdentifier',       s:fg,       '', '')
  call <sid>X('purescriptType',             s:yellow,   '', '')
  call <sid>X('purescriptTypeVar',          s:dark_red, '', '')
  call <sid>X('purescriptConstructor',      s:dark_red, '', '')
  call <sid>X('purescriptOperator',         s:fg,       '', '')
  " }}}

  " Python highlighting -----------------------------------------------------{{{
  call <sid>X('pythonImport',               s:purple,      '', '')
  call <sid>X('pythonBuiltin',              s:cyan,        '', '')
  call <sid>X('pythonStatement',            s:purple,      '', '')
  call <sid>X('pythonParam',                s:dark_yellow, '', '')
  call <sid>X('pythonEscape',               s:dark_red,    '', '')
  call <sid>X('pythonSelf',                 s:black,       '', s:italic)
  call <sid>X('pythonClass',                s:blue,        '', '')
  call <sid>X('pythonOperator',             s:purple,      '', '')
  call <sid>X('pythonEscape',               s:dark_red,    '', '')
  call <sid>X('pythonFunction',             s:blue,        '', '')
  call <sid>X('pythonKeyword',              s:blue,        '', '')
  call <sid>X('pythonModule',               s:purple,      '', '')
  call <sid>X('pythonStringDelimiter',      s:green,       '', '')
  call <sid>X('pythonSymbol',               s:cyan,        '', '')
  " }}}

  " Ruby highlighting -------------------------------------------------------{{{
  call <sid>X('rubyBlock',                     s:purple,   '', '')
  call <sid>X('rubyBlockParameter',            s:dark_red, '', '')
  call <sid>X('rubyBlockParameterList',        s:dark_red, '', '')
  call <sid>X('rubyCapitalizedMethod',         s:purple,   '', '')
  call <sid>X('rubyClass',                     s:purple,   '', '')
  call <sid>X('rubyConstant',                  s:yellow,   '', '')
  call <sid>X('rubyControl',                   s:purple,   '', '')
  call <sid>X('rubyDefine',                    s:purple,   '', '')
  call <sid>X('rubyEscape',                    s:dark_red, '', '')
  call <sid>X('rubyFunction',                  s:blue,     '', '')
  call <sid>X('rubyGlobalVariable',            s:dark_red, '', '')
  call <sid>X('rubyInclude',                   s:blue,     '', '')
  call <sid>X('rubyIncluderubyGlobalVariable', s:dark_red, '', '')
  call <sid>X('rubyInstanceVariable',          s:dark_red, '', '')
  call <sid>X('rubyInterpolation',             s:cyan,     '', '')
  call <sid>X('rubyInterpolationDelimiter',    s:dark_red, '', '')
  call <sid>X('rubyKeyword',                   s:blue,     '', '')
  call <sid>X('rubyModule',                    s:purple,   '', '')
  call <sid>X('rubyPseudoVariable',            s:dark_red, '', '')
  call <sid>X('rubyRegexp',                    s:cyan,     '', '')
  call <sid>X('rubyRegexpDelimiter',           s:cyan,     '', '')
  call <sid>X('rubyStringDelimiter',           s:green,    '', '')
  call <sid>X('rubySymbol',                    s:cyan,     '', '')
  " }}}

  " Spelling highlighting ---------------------------------------------------{{{
  call <sid>X('SpellBad',     '', s:bg, 'undercurl')
  call <sid>X('SpellLocal',   '', s:bg, 'undercurl')
  call <sid>X('SpellCap',     '', s:bg, 'undercurl')
  call <sid>X('SpellRare',    '', s:bg, 'undercurl')
  " }}}

  " Vim highlighting --------------------------------------------------------{{{
  call <sid>X('vimCommand',      s:purple,    '', '')
  call <sid>X('vimCommentTitle', s:dark_grey, '', 'bold')
  call <sid>X('vimFunction',     s:cyan,      '', '')
  call <sid>X('vimFuncName',     s:purple,    '', '')
  call <sid>X('vimHighlight',    s:blue,      '', '')
  call <sid>X('vimLineComment',  s:dark_grey, '', s:italic)
  call <sid>X('vimParenSep',     s:black,     '', '')
  call <sid>X('vimSep',          s:black,     '', '')
  call <sid>X('vimUserFunc',     s:cyan,      '', '')
  call <sid>X('vimVar',          s:dark_red,  '', '')
  " }}}

  " XML highlighting --------------------------------------------------------{{{
  call <sid>X('xmlAttrib',  s:yellow,   '', '')
  call <sid>X('xmlEndTag',  s:dark_red, '', '')
  call <sid>X('xmlTag',     s:dark_red, '', '')
  call <sid>X('xmlTagName', s:dark_red, '', '')
  " }}}

  " ZSH highlighting --------------------------------------------------------{{{
  call <sid>X('zshCommands',     s:fg,          '', '')
  call <sid>X('zshDeref',        s:dark_red,    '', '')
  call <sid>X('zshShortDeref',   s:dark_red,    '', '')
  call <sid>X('zshFunction',     s:cyan,        '', '')
  call <sid>X('zshKeyword',      s:purple,      '', '')
  call <sid>X('zshSubst',        s:dark_red,    '', '')
  call <sid>X('zshSubstDelim',   s:dark_grey,   '', '')
  call <sid>X('zshTypes',        s:purple,      '', '')
  call <sid>X('zshVariableDef',  s:dark_yellow, '', '')
  " }}}

  " Rust highlighting -------------------------------------------------------{{{
  call <sid>X('rustExternCrate',          s:dark_red,  '', 'bold')
  call <sid>X('rustIdentifier',           s:blue,      '', '')
  call <sid>X('rustDeriveTrait',          s:green,     '', '')
  call <sid>X('SpecialComment',           s:dark_grey, '', '')
  call <sid>X('rustCommentLine',          s:dark_grey, '', '')
  call <sid>X('rustCommentLineDoc',       s:dark_grey, '', '')
  call <sid>X('rustCommentLineDocError',  s:dark_grey, '', '')
  call <sid>X('rustCommentBlock',         s:dark_grey, '', '')
  call <sid>X('rustCommentBlockDoc',      s:dark_grey, '', '')
  call <sid>X('rustCommentBlockDocError', s:dark_grey, '', '')
  " }}}

  " man highlighting --------------------------------------------------------{{{
  hi link manTitle String
  call <sid>X('manFooter', s:dark_grey, '', '')
  " }}}

  " ALE (Asynchronous Lint Engine) highlighting -----------------------------{{{
  call <sid>X('ALEWarningSign', s:yellow, '', '')
  call <sid>X('ALEErrorSign', s:dark_red, '', '')
  " }}}

  " Vim-lsp highlightings ---------------------------------------------------{{{
  call <sid>X('LspError',                  s:dark_red, '', '')
  call <sid>X('LspWarning',                s:yellow,   '', '')
  call <sid>X('LspInformation',            s:green,    '', '')
  call <sid>X('LspHint',                   s:grey,     '', '')
  call <sid>X('LspErrorVirtualText',       s:dark_red, '', 'reverse')
  call <sid>X('LspWarningVirtualText',     s:yellow,   '', 'reverse')
  call <sid>X('LspInformationVirtualText', s:green,    '', 'reverse')
  call <sid>X('LspHintVirtualText',        s:grey,     '', 'reverse')
  call <sid>X('LspErrorHighlight',         s:dark_red, '', 'underline')
  call <sid>X('LspWarningHighlight',       s:yellow,   '', 'underline')
  call <sid>X('LspInformationHighlight',   s:green,    '', 'underline')
  call <sid>X('LspHintHighlight',          s:grey,     '', 'underline')
  " }}}

   " Neovim NERDTree Background fix ------------------------------------------{{{
  call <sid>X('NERDTreeFile', s:fg, '', '')
  " }}}

  " Delete functions =========================================================={{{
  " delf <SID>X
  " delf <SID>XAPI
  " delf <SID>rgb
  " delf <SID>color
  " delf <SID>rgb_color
  " delf <SID>rgb_level
  " delf <SID>rgb_number
  " delf <SID>grey_color
  " delf <SID>grey_level
  " delf <SID>grey_number
  " }}}

endif

" vim: set fdl=0 fdm=marker:
