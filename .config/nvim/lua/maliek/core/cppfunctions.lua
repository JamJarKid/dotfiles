local function CompileCpp()
    local dir = vim.fn.expand('%:p:h')
    local output = vim.fn.expand('%:t:r')
    local cmd = string.format("g++-13 -std=c++23 -fdiagnostics-color=always -g -pedantic-errors -Wall -Weffc++ -Wextra -Wsign-conversion -Werror %s/*.cpp -o %s/%s", dir, dir, output)
    vim.api.nvim_command('! '..cmd)
end

local function CompileCppFile()
    local file = vim.fn.expand('%')
    local dir = vim.fn.expand('%:p:h')
    local output = vim.fn.expand('%:t:r')
    local cmd = string.format("g++-13 -std=c++23 -g -pedantic-errors -Wall -Weffc++ -Wextra -Wsign-conversion -Werror %s -o %s/%s", file, dir, output)
    vim.api.nvim_command('! '..cmd)
end

return {
    Compile = CompileCpp,
    CompileFile = CompileCppFile,
}
