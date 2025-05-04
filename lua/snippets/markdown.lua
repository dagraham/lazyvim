local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = os.date

return {
  s("meta", {
    t({
      "---",
      'title: "',
    }),
    i(1),
    t({
      '"',
      "created: " .. d("%Y-%m-%d"),
      "modified: " .. d("%Y-%m-%d"),
      "tags: []",
      'context: ""',
      "---",
      "",
      "# ",
    }),
    i(0),
  }),
}
