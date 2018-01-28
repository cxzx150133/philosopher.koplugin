--[[
    Philosopher For KOReader
    Version: V0.0.3
    Another: cxzx150133
    License: GPL v3
--]]
local _               = require("gettext")
local UIManager       = require("ui/uimanager")
local InfoMessage     = require("ui/widget/infomessage")
local WidgetContainer = require("ui/widget/container/widgetcontainer")

---------------------------------------------------------------------------------------
local TXT_File_Path   = "/mnt/onboard/.adds/koreader/plugins/philosopher.koplugin/data.txt"
---------------------------------------------------------------------------------------
local Philosopher = WidgetContainer:new {
    name = 'philosopher',
}

function Philosopher:init()
    self.ui.menu:registerToMainMenu(self)
end

function Philosopher:addToMainMenu(menu_items)
    menu_items.philosopher = {
        text = _("Philosopher"),
        callback = function()
            UIManager:show(InfoMessage:new{
                text = _(
                    self:GetRandomLineFromTXT(TXT_File_Path)
                ),
                show_icon = false,
            })
        end,
        hold_callback = function()
            UIManager:show(InfoMessage:new{
                text = _(
                    "<About/>\n"..
                    "Philosopher for KOReader\n"..
                    "Version: V0.0.3\n"..
                    "Another: cxzx150133\n"..
                    "License: GPL v3"
                ),
            })
        end
    }
end
---------------------------------------------------------------------------------------
function Philosopher:GetTotalNumberOfLine(file_path)
    local file = io.open(file_path,"r")
    if file == nil then
        return -1
    end

    local n = 0
    for line in file:lines() do
        n = n + 1
    end
    file:close()

    return n
end

function Philosopher:IsRightNumberOfLine(LineNumber)
    if type(LineNumber) ~= "number" then
        LineNumber = tonumber(LineNumber)
    end

    if tonumber(string.format("%.f",LineNumber)) ~= LineNumber then
        return false
    elseif not (LineNumber>0) then
        return false
    end

  return true
end
  
function Philosopher:GetContentOfSpecifiedLine(file_path,LineNumber,TotalNumberLine)
    if file_path == nil then
        return "Error:Please set the file path."
    elseif  LineNumber == nil then
        return "Error:Please set the line number."
    elseif self:IsRightNumberOfLine(LineNumber) == false then
        return "Error:Please check the line number."
    elseif TotalNumberLine == nil then
        TotalNumberLine = self:GetTotalNumberOfLine(file_path)
    end

    if LineNumber > TotalNumberLine then
        return "Error:The line number cannot be greater than the total number of lines."
    elseif TotalNumberLine == -1 then
        return "Error:File path does not exist."
    end

    local file = io.open(file_path,"r")
    if file == nil then
        return "Error:File path does not exist."
    end
    
    local n = 0
    for line in file:lines() do
        n = n + 1
        if n == LineNumber then
          return line
        end
    end
    file:close()
    return "Error:The total number of rows is set incorrectly.\n" .. 
           "If you are not sure how many rows, please do not fill in this parameter, the program will automatically detect."
end

function Philosopher:GetOneLineAtRandom(file_path,TotalNumberLine)
    if file_path == nil then
        return "Error:Please set the file path."
    elseif TotalNumberLine == nil then
        TotalNumberLine = self:GetTotalNumberOfLine(file_path)
    end

    if TotalNumberLine == -1 then
        return "Error:File path does not exist."
    end
    
    math.randomseed(os.time())
    local NumberLine = math.random(TotalNumberLine) -- [1,LineNumber]
    return self:GetContentOfSpecifiedLine(file_path,NumberLine,TotalNumberLine),line
end
---------------------------------------------------------------------------------------
function Philosopher:GetRandomLineFromTXT(TXT_FILE_PATH)
    return_str = self:GetOneLineAtRandom(TXT_FILE_PATH)
    return return_str
end

return Philosopher