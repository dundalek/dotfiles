# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

# unset! in keymap config does not do the trick
# https://discuss.atom.io/t/disable-default-keybindings/1077/27

# removeBindings = {
#   'packages/vim-mode': ['ctrl-c', 'ctrl-v', 'ctrl-[', 'ctrl-]']
# };
# _ = require 'lodash'
# atom.keymaps.keyBindings = atom.keymaps.keyBindings.filter((b) =>
#   _(removeBindings)
#     .map((keystrokes, source) => (keystrokes.indexOf(b.keystrokes) >= 0 && b.source.indexOf(source) >= 0))
#     .every(false)
#     .value()
# )

source = 'packages/vim-mode'
keystrokes =  ['ctrl-c', 'ctrl-v', 'ctrl-[', 'ctrl-]', 'ctrl-f', 'ctrl-w']
atom.keymaps.keyBindings = atom.keymaps.keyBindings.filter((b) =>
  !(keystrokes.indexOf(b.keystrokes) >= 0 and b.source.indexOf(source) >= 0) and
  !(b.selector == 'atom-text-editor.vim-mode' and b.keystrokes == 'escape')
)
