-- Neovim LazyVim 诊断脚本
-- 使用方法: nvim --headless -c "luafile nvim-diagnostic.lua" -c "qa"

print("=== Neovim LazyVim 诊断报告 ===")

-- 1. 检查 Neovim 版本
print(string.format("Neovim 版本: %s", vim.version().string))

-- 2. 检查 lazy.nvim 是否安装
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.loop.fs_stat(lazypath) then
  print("✅ lazy.nvim 已安装")
else
  print("❌ lazy.nvim 未安装")
end

-- 3. 检查 LazyVim 是否加载
local ok, lazy = pcall(require, "lazy")
if ok then
  print("✅ Lazy 插件管理器加载成功")

  -- 检查插件状态
  local plugins = lazy.plugins()
  local loaded_count = 0
  local total_count = 0

  for _, plugin in pairs(plugins) do
    total_count = total_count + 1
    if plugin._.loaded then
      loaded_count = loaded_count + 1
    end
  end

  print(string.format("📦 插件状态: %d/%d 已加载", loaded_count, total_count))

  -- 检查问题插件
  local problem_plugins = {}
  for _, plugin in pairs(plugins) do
    if plugin._.has_errors then
      table.insert(problem_plugins, plugin.name)
    end
  end

  if #problem_plugins > 0 then
    print("❌ 发现问题插件:")
    for _, name in ipairs(problem_plugins) do
      print(string.format("   - %s", name))
    end
  else
    print("✅ 所有插件正常")
  end
else
  print("❌ Lazy 插件管理器加载失败")
end

-- 4. 检查健康状态
print("\n=== 健康检查 ===")
local health = vim.fn["health#check"]()
if health then
  print("健康检查已执行")
end

print("=== 诊断完成 ===")