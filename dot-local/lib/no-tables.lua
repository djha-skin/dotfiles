-- https://stackoverflow.com/a/75461419
function Table (tbl)
    local simpleTable = pandoc.utils.to_simple_table(tbl)
    local blocks = pandoc.Blocks{}
    for _, headercell in ipairs(simpleTable.header) do
      blocks:extend(headercell)
    end
    for _, row in ipairs(simpleTable.rows) do
      for _, cell in ipairs(row) do
        blocks:extend(cell)
      end
    end
    return blocks, false
end