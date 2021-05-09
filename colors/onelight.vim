" Name:    onelight.vim colorscheme
" Author:  Kanta Amano, Ramzi Akremi (Original)
" License: MIT
" Version: 1.1.1-pre

" Global setup =============================================================={{{

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

  " Utility function --------------------------------------------------------{{{
  function! s:h(group, fg, bg, attr, ...)
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

  let s:none = ['NONE', 'NONE']
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
  call s:h('Normal',       s:fg,           s:bg,          '')
  call s:h('bold',         '',             '',            'bold')
  call s:h('ColorColumn',  '',             s:cursor,      '')
  call s:h('Conceal',      s:grey,         s:none,        '')
  call s:h('Cursor',       s:fg,           s:visual_grey, '')
  call s:h('CursorIM',     s:fg,           s:visual_grey, '')
  call s:h('CursorColumn', '',             s:cursor,      '')
  call s:h('CursorLine',   '',             s:cursor,      'none')
  call s:h('Directory',    s:blue,         '',            '')
  call s:h('ErrorMsg',     s:dark_red,     s:bg,          'none')
  call s:h('VertSplit',    s:cursor,       s:cursor,      'none')
  call s:h('Folded',       s:fg,           s:bg,          'none')
  call s:h('FoldColumn',   s:dark_grey,    s:cursor,      '')
  call s:h('IncSearch',    s:yellow,       s:visual_grey, 'none')
  call s:h('LineNr',       s:grey,         '',            '')
  call s:h('CursorLineNr', s:fg,           s:cursor,      'none')
  call s:h('MatchParen',   s:dark_red,     s:none,        'underline')
  call s:h('Italic',       '',             '',            s:italic)
  call s:h('ModeMsg',      s:fg,           '',            '')
  call s:h('MoreMsg',      s:fg,           '',            '')
  call s:h('NonText',      s:dark_grey,    '',            'none')
  call s:h('PMenu',        '',             s:pmenu,       '')
  call s:h('PMenuSel',     '',             s:grey,        '')
  call s:h('PMenuSbar',    '',             s:bg,          '')
  call s:h('PMenuThumb',   '',             s:dark_black,  '')
  call s:h('Question',     s:blue,         '',            '')
  call s:h('Search',       s:yellow,       s:visual_grey, '')
  call s:h('SpecialKey',   s:special_grey, '',            'none')
  call s:h('Whitespace',   s:special_grey, '',            'none')
  call s:h('StatusLine',   s:fg,           s:cursor,      'none')
  call s:h('StatusLineNC', s:dark_grey,    '',            '')
  call s:h('TabLine',      s:black,        s:visual_grey, 'none')
  call s:h('TabLineFill',  s:dark_grey,    s:visual_grey, 'none')
  call s:h('TabLineSel',   s:bg,           s:blue,        '')
  call s:h('Title',        s:fg,           '',            'bold')
  call s:h('Visual',       '',             s:visual_grey, '')
  call s:h('VisualNOS',    '',             s:visual_grey, '')
  call s:h('WarningMsg',   s:dark_red,     '',            '')
  call s:h('TooLong',      s:dark_red,     '',            '')
  call s:h('WildMenu',     s:fg,           s:dark_grey,   '')
  call s:h('SignColumn',   '',             s:bg,          '')
  call s:h('Special',      s:blue,         '',            '')
  " }}}

  " Vim Help highlighting ---------------------------------------------------{{{
  call s:h('helpCommand',      s:yellow,     '', '')
  call s:h('helpExample',      s:yellow,     '', '')
  call s:h('helpHeader',       s:dark_black, '', 'bold')
  call s:h('helpSectionDelim', s:dark_grey,  '', '')
  " }}}

  " Standard syntax highlighting --------------------------------------------{{{
  call s:h('Comment',        s:dark_grey,   '',   s:italic)
  call s:h('Constant',       s:green,       '',   '')
  call s:h('String',         s:green,       '',   '')
  call s:h('Character',      s:green,       '',   '')
  call s:h('Number',         s:dark_yellow, '',   '')
  call s:h('Boolean',        s:dark_yellow, '',   '')
  call s:h('Float',          s:dark_yellow, '',   '')
  call s:h('Identifier',     s:dark_red,    '',   'none')
  call s:h('Function',       s:blue,        '',   '')
  call s:h('Statement',      s:purple,      '',   'none')
  call s:h('Conditional',    s:purple,      '',   '')
  call s:h('Repeat',         s:purple,      '',   '')
  call s:h('Label',          s:purple,      '',   '')
  call s:h('Operator',       s:accent,      '',   'none')
  call s:h('Keyword',        s:dark_red,    '',   '')
  call s:h('Exception',      s:purple,      '',   '')
  call s:h('PreProc',        s:yellow,      '',   '')
  call s:h('Include',        s:blue,        '',   '')
  call s:h('Define',         s:purple,      '',   'none')
  call s:h('Macro',          s:purple,      '',   '')
  call s:h('PreCondit',      s:yellow,      '',   '')
  call s:h('Type',           s:yellow,      '',   'none')
  call s:h('StorageClass',   s:yellow,      '',   '')
  call s:h('Structure',      s:yellow,      '',   '')
  call s:h('Typedef',        s:yellow,      '',   '')
  call s:h('Special',        s:blue,        '',   '')
  call s:h('SpecialChar',    '',            '',   '')
  call s:h('Tag',            '',            '',   '')
  call s:h('Delimiter',      '',            '',   '')
  call s:h('SpecialComment', '',            '',   '')
  call s:h('Debug',          '',            '',   '')
  call s:h('Underlined',     '',            '',   'underline')
  call s:h('Ignore',         '',            '',   '')
  call s:h('Error',          s:dark_red,    s:bg, 'bold')
  call s:h('Todo',           s:purple,      s:bg, '')
  " }}}

  " Diff highlighting -------------------------------------------------------{{{
  call s:h('DiffAdd',     s:green,       '', '')
  call s:h('DiffChange',  s:dark_yellow, '', '')
  call s:h('DiffDelete',  s:dark_red,    '', '')
  call s:h('DiffText',    s:blue,        '', '')
  call s:h('DiffAdded',   s:green,       '', '')
  call s:h('DiffFile',    s:dark_red,    '', '')
  call s:h('DiffNewFile', s:green,       '', '')
  call s:h('DiffLine',    s:blue,        '', '')
  call s:h('DiffRemoved', s:dark_red,    '', '')
  " }}}

  " Asciidoc highlighting ---------------------------------------------------{{{
  call s:h('asciidocListingBlock', s:black, '', '')
  " }}}

  " C/C++ highlighting ------------------------------------------------------{{{
  call s:h('cInclude',           s:purple,      '', '')
  call s:h('cPreCondit',         s:purple,      '', '')
  call s:h('cPreConditMatch',    s:purple,      '', '')

  call s:h('cType',              s:purple,      '', '')
  call s:h('cStorageClass',      s:purple,      '', '')
  call s:h('cStructure',         s:purple,      '', '')
  call s:h('cOperator',          s:purple,      '', '')
  call s:h('cStatement',         s:purple,      '', '')
  call s:h('cTODO',              s:purple,      '', '')
  call s:h('cConstant',          s:dark_yellow, '', '')
  call s:h('cSpecial',           s:cyan,        '', '')
  call s:h('cSpecialCharacter',  s:cyan,        '', '')
  call s:h('cString',            s:green,       '', '')

  call s:h('cppType',            s:purple,      '', '')
  call s:h('cppStorageClass',    s:purple,      '', '')
  call s:h('cppStructure',       s:purple,      '', '')
  call s:h('cppModifier',        s:purple,      '', '')
  call s:h('cppOperator',        s:purple,      '', '')
  call s:h('cppAccess',          s:purple,      '', '')
  call s:h('cppStatement',       s:purple,      '', '')
  call s:h('cppConstant',        s:dark_red,    '', '')
  call s:h('cCppString',         s:green,       '', '')
  " }}}

  " Cucumber highlighting ---------------------------------------------------{{{
  call s:h('cucumberGiven',           s:blue,        '', '')
  call s:h('cucumberWhen',            s:blue,        '', '')
  call s:h('cucumberWhenAnd',         s:blue,        '', '')
  call s:h('cucumberThen',            s:blue,        '', '')
  call s:h('cucumberThenAnd',         s:blue,        '', '')
  call s:h('cucumberUnparsed',        s:dark_yellow, '', '')
  call s:h('cucumberFeature',         s:dark_red,    '', 'bold')
  call s:h('cucumberBackground',      s:purple,      '', 'bold')
  call s:h('cucumberScenario',        s:purple,      '', 'bold')
  call s:h('cucumberScenarioOutline', s:purple,      '', 'bold')
  call s:h('cucumberTags',            s:dark_grey,   '', 'bold')
  call s:h('cucumberDelimiter',       s:dark_grey,   '', 'bold')
  " }}}

  " CSS/Sass highlighting ---------------------------------------------------{{{
  call s:h('cssAttrComma',         s:purple,      '', '')
  call s:h('cssAttributeSelector', s:green,       '', '')
  call s:h('cssBraces',            s:black,       '', '')
  call s:h('cssClassName',         s:dark_yellow, '', '')
  call s:h('cssClassNameDot',      s:dark_yellow, '', '')
  call s:h('cssDefinition',        s:purple,      '', '')
  call s:h('cssFontAttr',          s:dark_yellow, '', '')
  call s:h('cssFontDescriptor',    s:purple,      '', '')
  call s:h('cssFunctionName',      s:blue,        '', '')
  call s:h('cssIdentifier',        s:blue,        '', '')
  call s:h('cssImportant',         s:purple,      '', '')
  call s:h('cssInclude',           s:dark_black,  '', '')
  call s:h('cssIncludeKeyword',    s:purple,      '', '')
  call s:h('cssMediaType',         s:dark_yellow, '', '')
  call s:h('cssProp',              s:cyan,        '', '')
  call s:h('cssPseudoClassId',     s:dark_yellow, '', '')
  call s:h('cssSelectorOp',        s:purple,      '', '')
  call s:h('cssSelectorOp2',       s:purple,      '', '')
  call s:h('cssStringQ',           s:green,       '', '')
  call s:h('cssStringQQ',          s:green,       '', '')
  call s:h('cssTagName',           s:dark_red,    '', '')
  call s:h('cssAttr',              s:dark_yellow, '', '')

  call s:h('sassAmpersand',      s:dark_red,   '', '')
  call s:h('sassClass',          s:yellow,     '', '')
  call s:h('sassControl',        s:purple,     '', '')
  call s:h('sassExtend',         s:purple,     '', '')
  call s:h('sassFor',            s:dark_black, '', '')
  call s:h('sassProperty',       s:cyan,       '', '')
  call s:h('sassFunction',       s:cyan,       '', '')
  call s:h('sassId',             s:blue,       '', '')
  call s:h('sassInclude',        s:purple,     '', '')
  call s:h('sassMedia',          s:purple,     '', '')
  call s:h('sassMediaOperators', s:dark_black, '', '')
  call s:h('sassMixin',          s:purple,     '', '')
  call s:h('sassMixinName',      s:blue,       '', '')
  call s:h('sassMixing',         s:purple,     '', '')

  call s:h('scssSelectorName',   s:yellow,     '', '')
  " }}}

  " Elixir highlighting------------------------------------------------------{{{
  hi link elixirModuleDefine Define
  call s:h('elixirAlias',             s:yellow,      '', '')
  call s:h('elixirAtom',              s:cyan,        '', '')
  call s:h('elixirBlockDefinition',   s:purple,      '', '')
  call s:h('elixirModuleDeclaration', s:dark_yellow, '', '')
  call s:h('elixirInclude',           s:dark_red,    '', '')
  call s:h('elixirOperator',          s:dark_yellow, '', '')
  " }}}

  " Git and git related plugins highlighting --------------------------------{{{
  call s:h('gitcommitComment',       s:dark_grey, '', '')
  call s:h('gitcommitUnmerged',      s:green,     '', '')
  call s:h('gitcommitOnBranch',      '',          '', '')
  call s:h('gitcommitBranch',        s:purple,    '', '')
  call s:h('gitcommitDiscardedType', s:dark_red,  '', '')
  call s:h('gitcommitSelectedType',  s:green,     '', '')
  call s:h('gitcommitHeader',        '',          '', '')
  call s:h('gitcommitUntrackedFile', s:cyan,      '', '')
  call s:h('gitcommitDiscardedFile', s:dark_red,  '', '')
  call s:h('gitcommitSelectedFile',  s:green,     '', '')
  call s:h('gitcommitUnmergedFile',  s:yellow,    '', '')
  call s:h('gitcommitFile',          '',          '', '')
  hi link gitcommitNoBranch       gitcommitBranch
  hi link gitcommitUntracked      gitcommitComment
  hi link gitcommitDiscarded      gitcommitComment
  hi link gitcommitSelected       gitcommitComment
  hi link gitcommitDiscardedArrow gitcommitDiscardedFile
  hi link gitcommitSelectedArrow  gitcommitSelectedFile
  hi link gitcommitUnmergedArrow  gitcommitUnmergedFile

  call s:h('SignifySignAdd',    s:green,    '', '')
  call s:h('SignifySignChange', s:yellow,   '', '')
  call s:h('SignifySignDelete', s:dark_red, '', '')
  hi link GitGutterAdd    SignifySignAdd
  hi link GitGutterChange SignifySignChange
  hi link GitGutterDelete SignifySignDelete
  call s:h('diffAdded',         s:green,    '', '')
  call s:h('diffRemoved',       s:dark_red, '', '')
  " }}}

  " Go highlighting ---------------------------------------------------------{{{
  call s:h('goDeclaration',         s:purple,   '', '')
  call s:h('goField',               s:dark_red, '', '')
  call s:h('goMethod',              s:cyan,     '', '')
  call s:h('goType',                s:purple,   '', '')
  call s:h('goUnsignedInts',        s:cyan,     '', '')
  " }}}

  " Haskell highlighting ----------------------------------------------------{{{
  call s:h('haskellDeclKeyword',    s:blue,        '', '')
  call s:h('haskellType',           s:green,       '', '')
  call s:h('haskellWhere',          s:dark_red,    '', '')
  call s:h('haskellImportKeywords', s:blue,        '', '')
  call s:h('haskellOperators',      s:dark_red,    '', '')
  call s:h('haskellDelimiter',      s:blue,        '', '')
  call s:h('haskellIdentifier',     s:dark_yellow, '', '')
  call s:h('haskellKeyword',        s:dark_red,    '', '')
  call s:h('haskellNumber',         s:cyan,        '', '')
  call s:h('haskellString',         s:cyan,        '', '')
  "}}}

  " HTML highlighting -------------------------------------------------------{{{
  call s:h('htmlArg',            s:dark_yellow,  '', '')
  call s:h('htmlTagName',        s:dark_red,     '', '')
  call s:h('htmlTagN',           s:dark_red,     '', '')
  call s:h('htmlSpecialTagName', s:dark_red,     '', '')
  call s:h('htmlTag',            s:black,        '', '')
  call s:h('htmlEndTag',         s:black,        '', '')

  call s:h('MatchTag', s:dark_red, s:cursor, 'underline,bold')
  " }}}

  " JavaScript highlighting -------------------------------------------------{{{
  call s:h('coffeeString',           s:green,       '', '')

  call s:h('javaScriptBraces',       s:black,       '', '')
  call s:h('javaScriptFunction',     s:purple,      '', '')
  call s:h('javaScriptIdentifier',   s:purple,      '', '')
  call s:h('javaScriptNull',         s:dark_yellow, '', '')
  call s:h('javaScriptNumber',       s:dark_yellow, '', '')
  call s:h('javaScriptRequire',      s:cyan,        '', '')
  call s:h('javaScriptReserved',     s:purple,      '', '')
  " https://github.com/pangloss/vim-javascript
  call s:h('jsArrowFunction',        s:purple,      '', '')
  call s:h('jsBraces',               s:black,       '', '')
  call s:h('jsClassBraces',          s:black,       '', '')
  call s:h('jsClassKeywords',        s:purple,      '', '')
  call s:h('jsDocParam',             s:blue,        '', '')
  call s:h('jsDocTags',              s:purple,      '', '')
  call s:h('jsFuncBraces',           s:black,       '', '')
  call s:h('jsFuncCall',             s:blue,        '', '')
  call s:h('jsFuncParens',           s:black,       '', '')
  call s:h('jsFunction',             s:purple,      '', '')
  call s:h('jsGlobalObjects',        s:yellow,      '', '')
  call s:h('jsModuleWords',          s:purple,      '', '')
  call s:h('jsModules',              s:purple,      '', '')
  call s:h('jsNoise',                s:black,       '', '')
  call s:h('jsNull',                 s:dark_yellow, '', '')
  call s:h('jsOperator',             s:purple,      '', '')
  call s:h('jsParens',               s:black,       '', '')
  call s:h('jsStorageClass',         s:purple,      '', '')
  call s:h('jsTemplateBraces',       s:red,         '', '')
  call s:h('jsTemplateVar',          s:green,       '', '')
  call s:h('jsThis',                 s:dark_red,    '', '')
  call s:h('jsUndefined',            s:dark_yellow, '', '')
  call s:h('jsObjectValue',          s:blue,        '', '')
  call s:h('jsObjectKey',            s:cyan,        '', '')
  call s:h('jsReturn',               s:purple,      '', '')
  " https://github.com/othree/yajs.vim
  call s:h('javascriptArrowFunc',    s:purple,      '', '')
  call s:h('javascriptClassExtends', s:purple,      '', '')
  call s:h('javascriptClassKeyword', s:purple,      '', '')
  call s:h('javascriptDocNotation',  s:purple,      '', '')
  call s:h('javascriptDocParamName', s:blue,        '', '')
  call s:h('javascriptDocTags',      s:purple,      '', '')
  call s:h('javascriptEndColons',    s:dark_grey,   '', '')
  call s:h('javascriptExport',       s:purple,      '', '')
  call s:h('javascriptFuncArg',      s:dark_black,  '', '')
  call s:h('javascriptFuncKeyword',  s:purple,      '', '')
  call s:h('javascriptIdentifier',   s:dark_red,    '', '')
  call s:h('javascriptImport',       s:purple,      '', '')
  call s:h('javascriptObjectLabel',  s:dark_black,  '', '')
  call s:h('javascriptOpSymbol',     s:cyan,        '', '')
  call s:h('javascriptOpSymbols',    s:cyan,        '', '')
  call s:h('javascriptPropertyName', s:green,       '', '')
  call s:h('javascriptTemplateSB',   s:red,         '', '')
  call s:h('javascriptVariable',     s:purple,      '', '')
  " }}}

  " JSON highlighting -------------------------------------------------------{{{
  call s:h('jsonCommentError',         s:dark_black,  '', '')
  call s:h('jsonKeyword',              s:dark_red,    '', '')
  call s:h('jsonQuote',                s:dark_grey,   '', '')
  call s:h('jsonTrailingCommaError',   s:dark_red,    '', 'reverse')
  call s:h('jsonMissingCommaError',    s:dark_red,    '', 'reverse')
  call s:h('jsonNoQuotesError',        s:dark_red,    '', 'reverse')
  call s:h('jsonNumError',             s:dark_red,    '', 'reverse')
  call s:h('jsonString',               s:green,       '', '')
  call s:h('jsonBoolean',              s:purple,      '', '')
  call s:h('jsonNumber',               s:dark_yellow, '', '')
  call s:h('jsonStringSQError',        s:dark_red,    '', 'reverse')
  call s:h('jsonSemicolonError',       s:dark_red,    '', 'reverse')
  " }}}

  " Markdown highlighting ---------------------------------------------------{{{
  call s:h('markdownUrl',              s:dark_grey,   '', '')
  call s:h('markdownBold',             s:dark_yellow, '', 'bold')
  call s:h('markdownItalic',           s:dark_yellow, '', 'bold')
  call s:h('markdownCode',             s:green,       '', '')
  call s:h('markdownCodeBlock',        s:dark_red,    '', '')
  call s:h('markdownCodeDelimiter',    s:green,       '', '')
  call s:h('markdownHeadingDelimiter', s:red,         '', '')
  call s:h('markdownH1',               s:dark_red,    '', '')
  call s:h('markdownH2',               s:dark_red,    '', '')
  call s:h('markdownH3',               s:dark_red,    '', '')
  call s:h('markdownH3',               s:dark_red,    '', '')
  call s:h('markdownH4',               s:dark_red,    '', '')
  call s:h('markdownH5',               s:dark_red,    '', '')
  call s:h('markdownH6',               s:dark_red,    '', '')
  call s:h('markdownListMarker',       s:dark_red,    '', '')
  " }}}

  " Perl highlighting -------------------------------------------------------{{{
  call s:h('perlFunction',      s:purple,    '', '')
  call s:h('perlMethod',        s:fg,        '', '')
  call s:h('perlPackageConst',  s:purple,    '', '')
  call s:h('perlPOD',           s:dark_grey, '', '')
  call s:h('perlSubName',       s:fg,        '', '')
  call s:h('perlSharpBang',     s:dark_grey, '', '')
  call s:h('perlSpecialString', s:green,     '', '')
  call s:h('perlVarPlain',      s:blue,      '', '')
  call s:h('podCommand',        s:dark_grey, '', '')
  " }}}

  " PHP highlighting --------------------------------------------------------{{{
  call s:h('phpClass',        s:yellow,    '', '')
  call s:h('phpFunction',     s:blue,      '', '')
  call s:h('phpFunctions',    s:blue,      '', '')
  call s:h('phpInclude',      s:purple,    '', '')
  call s:h('phpKeyword',      s:purple,    '', '')
  call s:h('phpParent',       s:dark_grey, '', '')
  call s:h('phpType',         s:purple,    '', '')
  call s:h('phpSuperGlobals', s:dark_red,  '', '')
  " }}}

  " Pug (Formerly Jade) highlighting ----------------------------------------{{{
  call s:h('pugAttributesDelimiter',   s:dark_yellow, '', '')
  call s:h('pugClass',                 s:dark_yellow, '', '')
  call s:h('pugDocType',               s:dark_grey,   '', s:italic)
  call s:h('pugTag',                   s:dark_red,    '', '')
  " }}}

  " PureScript highlighting -------------------------------------------------{{{
  call s:h('purescriptKeyword',          s:purple,   '', '')
  call s:h('purescriptModuleName',       s:fg,       '', '')
  call s:h('purescriptIdentifier',       s:fg,       '', '')
  call s:h('purescriptType',             s:yellow,   '', '')
  call s:h('purescriptTypeVar',          s:dark_red, '', '')
  call s:h('purescriptConstructor',      s:dark_red, '', '')
  call s:h('purescriptOperator',         s:fg,       '', '')
  " }}}

  " Python highlighting -----------------------------------------------------{{{
  call s:h('pythonImport',               s:purple,      '', '')
  call s:h('pythonBuiltin',              s:cyan,        '', '')
  call s:h('pythonStatement',            s:purple,      '', '')
  call s:h('pythonParam',                s:dark_yellow, '', '')
  call s:h('pythonEscape',               s:dark_red,    '', '')
  call s:h('pythonSelf',                 s:black,       '', s:italic)
  call s:h('pythonClass',                s:blue,        '', '')
  call s:h('pythonOperator',             s:purple,      '', '')
  call s:h('pythonEscape',               s:dark_red,    '', '')
  call s:h('pythonFunction',             s:blue,        '', '')
  call s:h('pythonKeyword',              s:blue,        '', '')
  call s:h('pythonModule',               s:purple,      '', '')
  call s:h('pythonStringDelimiter',      s:green,       '', '')
  call s:h('pythonSymbol',               s:cyan,        '', '')
  " }}}

  " Ruby highlighting -------------------------------------------------------{{{
  call s:h('rubyBlock',                     s:purple,   '', '')
  call s:h('rubyBlockParameter',            s:dark_red, '', '')
  call s:h('rubyBlockParameterList',        s:dark_red, '', '')
  call s:h('rubyCapitalizedMethod',         s:purple,   '', '')
  call s:h('rubyClass',                     s:purple,   '', '')
  call s:h('rubyConstant',                  s:yellow,   '', '')
  call s:h('rubyControl',                   s:purple,   '', '')
  call s:h('rubyDefine',                    s:purple,   '', '')
  call s:h('rubyEscape',                    s:dark_red, '', '')
  call s:h('rubyFunction',                  s:blue,     '', '')
  call s:h('rubyGlobalVariable',            s:dark_red, '', '')
  call s:h('rubyInclude',                   s:blue,     '', '')
  call s:h('rubyIncluderubyGlobalVariable', s:dark_red, '', '')
  call s:h('rubyInstanceVariable',          s:dark_red, '', '')
  call s:h('rubyInterpolation',             s:cyan,     '', '')
  call s:h('rubyInterpolationDelimiter',    s:dark_red, '', '')
  call s:h('rubyKeyword',                   s:blue,     '', '')
  call s:h('rubyModule',                    s:purple,   '', '')
  call s:h('rubyPseudoVariable',            s:dark_red, '', '')
  call s:h('rubyRegexp',                    s:cyan,     '', '')
  call s:h('rubyRegexpDelimiter',           s:cyan,     '', '')
  call s:h('rubyStringDelimiter',           s:green,    '', '')
  call s:h('rubySymbol',                    s:cyan,     '', '')
  " }}}

  " Spelling highlighting ---------------------------------------------------{{{
  call s:h('SpellBad',     '', s:bg, 'undercurl')
  call s:h('SpellLocal',   '', s:bg, 'undercurl')
  call s:h('SpellCap',     '', s:bg, 'undercurl')
  call s:h('SpellRare',    '', s:bg, 'undercurl')
  " }}}

  " Vim highlighting --------------------------------------------------------{{{
  call s:h('vimCommand',      s:purple,    '', '')
  call s:h('vimCommentTitle', s:dark_grey, '', 'bold')
  call s:h('vimFunction',     s:cyan,      '', '')
  call s:h('vimFuncName',     s:purple,    '', '')
  call s:h('vimHighlight',    s:blue,      '', '')
  call s:h('vimLineComment',  s:dark_grey, '', s:italic)
  call s:h('vimParenSep',     s:black,     '', '')
  call s:h('vimSep',          s:black,     '', '')
  call s:h('vimUserFunc',     s:cyan,      '', '')
  call s:h('vimVar',          s:dark_red,  '', '')
  " }}}

  " XML highlighting --------------------------------------------------------{{{
  call s:h('xmlAttrib',  s:yellow,   '', '')
  call s:h('xmlEndTag',  s:dark_red, '', '')
  call s:h('xmlTag',     s:dark_red, '', '')
  call s:h('xmlTagName', s:dark_red, '', '')
  " }}}

  " ZSH highlighting --------------------------------------------------------{{{
  call s:h('zshCommands',     s:fg,          '', '')
  call s:h('zshDeref',        s:dark_red,    '', '')
  call s:h('zshShortDeref',   s:dark_red,    '', '')
  call s:h('zshFunction',     s:cyan,        '', '')
  call s:h('zshKeyword',      s:purple,      '', '')
  call s:h('zshSubst',        s:dark_red,    '', '')
  call s:h('zshSubstDelim',   s:dark_grey,   '', '')
  call s:h('zshTypes',        s:purple,      '', '')
  call s:h('zshVariableDef',  s:dark_yellow, '', '')
  " }}}

  " Rust highlighting -------------------------------------------------------{{{
  call s:h('rustExternCrate',          s:dark_red,  '', '')
  call s:h('rustIdentifier',           s:blue,      '', '')
  call s:h('rustDeriveTrait',          s:green,     '', '')
  call s:h('SpecialComment',           s:dark_grey, '', s:italic)
  call s:h('rustCommentLine',          s:dark_grey, '', s:italic)
  call s:h('rustCommentLineDoc',       s:dark_grey, '', s:italic)
  call s:h('rustCommentLineDocError',  s:dark_grey, '', s:italic)
  call s:h('rustCommentBlock',         s:dark_grey, '', s:italic)
  call s:h('rustCommentBlockDoc',      s:dark_grey, '', s:italic)
  call s:h('rustCommentBlockDocError', s:dark_grey, '', s:italic)
  " }}}

  " man highlighting --------------------------------------------------------{{{
  hi link manTitle String
  call s:h('manFooter', s:dark_grey, '', '')
  " }}}

  " ALE (Asynchronous Lint Engine) highlighting -----------------------------{{{
  call s:h('ALEWarningSign', s:yellow, '', '')
  call s:h('ALEErrorSign', s:dark_red, '', '')
  " }}}

  " Neovim Buildin LSP highlightings ----------------------------------------{{{
  call s:h('LspDiagnosticsDefaultError',         s:dark_red, '', '')
  call s:h('LspDiagnosticsDefaultWarning',       s:yellow,   '', '')
  call s:h('LspDiagnosticsDefaultInformation',   s:green,    '', '')
  call s:h('LspDiagnosticsDefaultHint',          s:grey,     '', '')
  call s:h('LspDiagnosticsUnderlineError',       s:dark_red, '', 'underline')
  call s:h('LspDiagnosticsUnderlineWarning',     s:yellow,   '', 'underline')
  call s:h('LspDiagnosticsUnderlineInformation', s:green,    '', 'underline')
  call s:h('LspDiagnosticsUnderlineHint',        s:grey,     '', 'underline')
  " }}}

  " vim-lsp highlightings ---------------------------------------------------{{{
  call s:h('LspCodeActionText',         s:purple,   '', '')
  call s:h('LspError',                  s:dark_red, '', '')
  call s:h('LspErrorText',              s:dark_red, '', '')
  call s:h('LspErrorHighlight',         s:dark_red, '', 'underline')
  call s:h('LspErrorVirtualText',       s:dark_red, '', 'reverse')
  call s:h('LspWarning',                s:yellow,   '', '')
  call s:h('LspWarningText',            s:yellow,   '', '')
  call s:h('LspWarningHighlight',       s:yellow,   '', 'underline')
  call s:h('LspWarningVirtualText',     s:yellow,   '', 'reverse')
  call s:h('LspInformation',            s:green,    '', '')
  call s:h('LspInformationText',        s:green,    '', '')
  call s:h('LspInformationHighlight',   s:green,    '', 'underline')
  call s:h('LspInformationVirtualText', s:green,    '', 'reverse')
  call s:h('LspHint',                   s:grey,     '', '')
  call s:h('LspHintText',               s:grey,     '', '')
  call s:h('LspHintHighlight',          s:grey,     '', 'underline')
  call s:h('LspHintVirtualText',        s:grey,     '', 'reverse')
  " }}}

   " Neovim NERDTree Background fix ------------------------------------------{{{
  call s:h('NERDTreeFile', s:fg, '', '')
  " }}}


endif

" vim: set fdl=0 fdm=marker:
