local M = {}

function M:peek(job)
    local child = Command("xlsx2csv")
        :args({ "--limit", "50", tostring(job.file.url) })
        :stdout(Command.PIPED)
        :spawn()

    if not child then return end

    local limit = job.area.h
    local i = 0
    repeat
        local line, event = child:read_line()
        if event ~= 0 then break end
        -- Satırları önizleme alanına yazdır
        ya.preview_widgets(job, {
            ui.Text(line):area(ui.Rect(job.area.x, job.area.y + i, job.area.w, 1))
        })
        i = i + 1
    until i >= limit

    child:wait()
end

function M:seek(job) end

return M
