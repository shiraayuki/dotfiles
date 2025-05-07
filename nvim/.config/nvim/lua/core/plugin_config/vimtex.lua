vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.tex_flavor = 'latex'
vim.g.vimtex_compiler_latexmk = {
  build_dir = '',
  callback = 1,
  continuous = 0,
  executable = 'latexmk',
  options = {
    '-pdf',
    '-silent',
    '-shell-escape',
    '-file-line-error',
    '-interaction=nonstopmode',
    '-synctex=0',
  },
}
