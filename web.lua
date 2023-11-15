-- 导入 Turbo 模块
local turbo = require("turbo")

local i=1

local stats1
-- 模拟查询 API（stats）的操作
function query_stats()
    -- 假设这里是实际的 API 查询逻辑
    
    i=i+1
    local stats_data = {
        requests = 1000-i,
        errors = 10,
        success_rate = 90
    }
    return stats_data
end



-- 创建处理程序类
local StatsHandler = class("StatsHandler", turbo.web.RequestHandler)

-- 实现 GET 请求处理逻辑
function StatsHandler:get()
    -- 在此处执行查询 API（stats）的逻辑
    -- 返回查询到的数据作为响应
    self:write(turbo.escape.json_encode(stats))
     stats = stats1
end
-- 创建 Turbo 应用
local app = turbo.web.Application({
    {"^/$", turbo.web.StaticFileHandler, "index.html"},
    {"^/stats$", StatsHandler} -- 将路径映射到处理程序
})

-- 启动 Turbo 服务器
app:listen(8888)
print("Turbo server is running on port 8888")

-- 每秒查询一次 API（stats）
    turbo.ioloop.instance():set_interval(1000, function()
        -- 这里执行查询 API（stats）的操作
        stats1 = query_stats()
        print("Stats:", stats1)
    end)


-- 启动事件循环
turbo.ioloop.instance():start()
