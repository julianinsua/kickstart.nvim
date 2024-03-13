local debuggerPath = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug'

return {
  debugger_path = debuggerPath,
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
}
