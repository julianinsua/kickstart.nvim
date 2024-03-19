return {
  cmd = { vim.fn.expand '~/.local/share/nvim-kickstart/mason/bin/jdtls' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  runtimes = {
    { name = 'JavaSE-21', path = '/usr/lib/jvm/java-21-openjdk/' },
    { name = 'JavaSE-17', path = '/usr/lib/jvm/java-17-openjdk/' },
  },
}
