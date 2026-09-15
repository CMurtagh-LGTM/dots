local M = {}

function M.get()
    local file = io.open("/etc/hostname", "r")
    if not file then
        return ""
    end

    local hostname = file:read("*l") or ""
    file:close()

    return hostname
end

return M
