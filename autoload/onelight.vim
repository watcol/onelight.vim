let s:colors = {
\ "dark_black": ['#494b53', 23],
\ "black": ['#696c77', 60],
\ "dark_grey": ['#a0a1a7', 145],
\ "grey": ['#c2c2c3', 250],
\ "cyan": ['#0184bc', 31],
\ "blue": ['#4078f2', 33],
\ "purple": ['#a626a4', 127],
\ "green": ['#50a14f', 71],
\ "dark_red": ['#e45649', 166],
\ "red": ['#ca1243', 160],
\ "dark_yellow": ['#986801', 94],
\ "yellow": ['#c18401', 136],
\ "bg_green": ['#98c379', 76],
\ "bg_purple": ['#c678dd', 176],
\ "bg_yellow": ['#e5c07b', 180],
\ "bg": ['#fafafa', 255],
\ "gutter": ['#9e9e9e', 247],
\ "cursor": ['#f0f0f0', 254],
\ "accent": ['#526fff', 63],
\ "accent2": ['#0083be', 31],
\ "vertsplit": ['#e7e9e1', 188],
\ "special_grey": ['#d3d3d3', 251],
\ "visual_grey": ['#d0d0d0', 251],
\ "pmenu": ['#dfdfdf', 253],
\}

function! onelight#get_colors()
  return s:colors
endfunction
