local M = {}
function M:peek(job)
    local child = Command("pdfinfo"):arg(tostring(job.file.url)):stdout(Command.PIPED):spawn()
    if not child then return end
    local pages = "Bilinmiyor"
    repeat
        local line = child:read_line()
        if not line then break end
        if line:find("Pages:") then pages = line:match("Pages:%s+(%d+)") end
    until false
    ya.preview_build(job, function()
        return ui.Text("   PDF Sayfa Sayısı: " .. pages):area(job.area):fg("#89b4fa")
    end)
end
return M
