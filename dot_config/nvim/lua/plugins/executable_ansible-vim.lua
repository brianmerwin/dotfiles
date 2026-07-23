return {
  "pearofducks/ansible-vim",
  config = function()
    vim.g.ansible_unindent_after_newline = 1
    vim.g.ansible_name_highlight = 1
    vim.g.ansible_loop_keywords_highlight = 1
  end,
}
