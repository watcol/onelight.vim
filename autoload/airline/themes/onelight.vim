let g:airline#themes#onelight#palette = {}

function! airline#themes#onelight#refresh()
  let s:colors   = onelight#get_colors()
  let s:white    = s:colors.bg
  let s:black    = s:colors.dark_black
  let s:inactive = s:colors.special_grey
  let s:modified = s:colors.purple
  let s:normal   = s:colors.green
  let s:insert   = s:colors.blue
  let s:replace  = s:colors.dark_red
  let s:visual   = s:colors.purple
  let s:inactive = s:colors.dark_grey

  let g:airline#themes#onelight#palette.accents = {
        \ 'red': [s:colors.red[0], '', s:colors.red[1], 0],
        \}

  let s:N  = [ s:white[0],    s:normal[0],  s:white[1],    s:normal[1]  ]
  let s:I  = [ s:white[0],    s:insert[0],  s:white[1],    s:insert[1]  ]
  let s:R  = [ s:white[0],    s:replace[0], s:white[1],    s:replace[1] ]
  let s:V  = [ s:white[0],    s:visual[0],  s:white[1],    s:visual[1]  ]
  let s:IA = [ s:inactive[0], s:white[0],   s:inactive[1], s:white[1]   ]

  let s:A = [ s:black[0], s:grey[0],   s:black[1], s:grey[1]   ]
  let s:B = [ s:black[0], s:white[0],  s:black[1], s:white[1]  ]


  let g:airline#themes#onelight#palette.normal   = airline#themes#generate_color_map(s:N,  s:A,  s:B)
  let g:airline#themes#onelight#palette.insert   = airline#themes#generate_color_map(s:I,  s:A,  s:B)
  let g:airline#themes#onelight#palette.replace  = airline#themes#generate_color_map(s:R,  s:A,  s:B)
  let g:airline#themes#onelight#palette.visual   = airline#themes#generate_color_map(s:V,  s:A,  s:B)
  let g:airline#themes#onelight#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)

  let g:airline#themes#onelight#palette.normal_modified = {
  \ 'airline_c': [ s:modified[0], '', s:modified[1], '', '' ]
  \}
  let g:airline#themes#onelight#palette.insert_modified = g:airline#themes#onelight#palette.normal_modified
  let g:airline#themes#onelight#palette.replace_modified = g:airline#themes#onelight#palette.normal_modified
  let g:airline#themes#onelight#palette.visual_modified = g:airline#themes#onelight#palette.normal_modified
  let g:airline#themes#onelight#palette.inactive_modified = g:airline#themes#onelight#palette.normal_modified
endfunction

call airline#themes#onelight#refresh()

