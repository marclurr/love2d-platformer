return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.2",
  orientation = "orthogonal",
  renderorder = "left-down",
  width = 66,
  height = 28,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 6,
  nextobjectid = 69,
  properties = {},
  tilesets = {
    {
      name = "tileset",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 12,
      image = "../assets/tilesets/tileset.png",
      imagewidth = 192,
      imageheight = 96,
      objectalignment = "topleft",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 72,
      tiles = {
        {
          id = 0,
          type = "normal_block"
        },
        {
          id = 1,
          type = "normal_block"
        },
        {
          id = 2,
          type = "normal_block"
        },
        {
          id = 4,
          type = "normal_block"
        },
        {
          id = 12,
          type = "normal_block"
        },
        {
          id = 14,
          type = "normal_block"
        },
        {
          id = 15,
          type = "normal_block"
        },
        {
          id = 17,
          type = "normal_block"
        },
        {
          id = 24,
          type = "normal_block"
        },
        {
          id = 25,
          type = "normal_block"
        },
        {
          id = 26,
          type = "normal_block"
        },
        {
          id = 28,
          type = "normal_block"
        },
        {
          id = 36,
          type = "normal_block"
        },
        {
          id = 37,
          type = "normal_block"
        },
        {
          id = 38,
          type = "normal_block"
        },
        {
          id = 40,
          type = "normal_block"
        },
        {
          id = 42,
          type = "one_way_block"
        },
        {
          id = 43,
          type = "one_way_block"
        },
        {
          id = 44,
          type = "one_way_block"
        },
        {
          id = 48,
          type = "normal_block"
        },
        {
          id = 50,
          type = "normal_block"
        },
        {
          id = 51,
          type = "normal_block"
        },
        {
          id = 53,
          type = "normal_block"
        },
        {
          id = 54,
          type = "one_way_block"
        },
        {
          id = 55,
          type = "one_way_block"
        },
        {
          id = 56,
          type = "one_way_block"
        },
        {
          id = 60,
          type = "normal_block"
        },
        {
          id = 61,
          type = "normal_block"
        },
        {
          id = 62,
          type = "normal_block"
        },
        {
          id = 64,
          type = "normal_block"
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 66,
      height = 28,
      id = 1,
      name = "foreground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["has_collision"] = true
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 6,
        0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
        0, 0, 0, 25, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 6, 14, 14, 15, 0, 0, 0, 1, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 26, 26, 27, 0, 0, 0, 25, 26, 26, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 30, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 30,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 25, 26, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 26, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 15, 13, 14, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 26, 27, 25, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 1, 2, 3, 13, 14, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 15, 13, 14, 15, 25, 26, 27, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 26, 27, 25, 26, 27, 0, 0, 0, 13, 14, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 14, 14, 14, 15, 43, 44, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 15, 43, 44, 45, 0, 0, 0, 0, 0, 0, 1, 2,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 14, 14, 14, 15, 43, 44, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 13, 14, 15, 0, 0, 43, 44, 45, 0, 0, 0, 0, 18, 14,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43, 44, 45, 18, 14, 14, 14, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 15, 0, 0, 0, 13, 14, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 14,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 26, 26, 26, 27, 43, 44, 45, 0, 0, 0, 0, 0, 0, 0, 13, 14, 28, 2, 2, 2, 3, 0, 1, 2, 3, 0, 0, 13, 14, 15, 0, 0, 0, 13, 14, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 14,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 14, 14, 14, 14, 15, 2, 13, 14, 15, 0, 0, 13, 14, 15, 0, 0, 0, 25, 26, 27, 0, 0, 0, 0, 0, 0, 1, 2, 3, 18, 14,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43, 44, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 14, 14, 14, 14, 15, 14, 25, 26, 27, 43, 45, 13, 14, 15, 43, 44, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 15, 18, 14,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 1, 29, 29, 29, 3, 43, 44, 45, 0, 0, 0, 0, 43, 44, 45, 13, 14, 14, 4, 26, 26, 27, 0, 0, 0, 0, 0, 0, 25, 26, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 26, 27, 18, 14,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 30, 15, 0, 0, 0, 0, 0, 0, 18, 14, 14, 4, 27, 43, 44, 45, 0, 1, 2, 3, 0, 0, 0, 25, 26, 26, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 30, 14,
        14, 16, 0, 0, 0, 0, 0, 0, 0, 25, 26, 27, 0, 0, 0, 0, 0, 0, 25, 26, 26, 27, 0, 0, 0, 0, 0, 25, 26, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 30, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
        14, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 37, 38, 39, 1, 2, 3, 1, 2, 2, 2, 30, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
        14, 28, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 0, 1, 3, 49, 50, 51, 13, 14, 15, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
        14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 28, 29, 30, 15, 61, 62, 63, 25, 26, 27, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
        14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 28, 29, 29, 29, 29, 29, 29, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "objects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 3,
          name = "",
          type = "player_spawn",
          shape = "rectangle",
          x = 768,
          y = 48,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          type = "trap_spikes",
          shape = "polyline",
          x = 288,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["direction"] = "up"
          }
        },
        {
          id = 24,
          name = "",
          type = "trap_spikes",
          shape = "polyline",
          x = 288,
          y = 384,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 64, y = 0 }
          },
          properties = {}
        },
        {
          id = 25,
          name = "",
          type = "trap_spikes",
          shape = "polyline",
          x = 784,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 48, y = 0 }
          },
          properties = {
            ["direction"] = "up"
          }
        },
        {
          id = 26,
          name = "",
          type = "trap_spikes",
          shape = "polyline",
          x = 160,
          y = 336,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 32, y = 0 }
          },
          properties = {
            ["direction"] = "up"
          }
        },
        {
          id = 29,
          name = "",
          type = "stone",
          shape = "rectangle",
          x = 656,
          y = 352,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "",
          type = "strange_door",
          shape = "rectangle",
          x = 832,
          y = 320,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "",
          type = "strange_door",
          shape = "rectangle",
          x = 688,
          y = 240,
          width = 16,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "",
          type = "stone",
          shape = "rectangle",
          x = 672,
          y = 272,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "",
          type = "button",
          shape = "polyline",
          x = 698,
          y = 368,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["ref"] = { id = 35 }
          }
        },
        {
          id = 33,
          name = "",
          type = "button",
          shape = "polyline",
          x = 640,
          y = 304,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["ref"] = { id = 36 }
          }
        },
        {
          id = 41,
          name = "",
          type = "stone",
          shape = "rectangle",
          x = 416,
          y = 208,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "",
          type = "button",
          shape = "polyline",
          x = 464,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["ref"] = { id = 0 }
          }
        },
        {
          id = 44,
          name = "",
          type = "push_ability_pickup",
          shape = "rectangle",
          x = 384,
          y = 224,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "",
          type = "attack_ability_pickup",
          shape = "rectangle",
          x = 384,
          y = 272,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "",
          type = "trigger",
          shape = "rectangle",
          x = 480,
          y = 272,
          width = 48,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 48,
          name = "",
          type = "stone",
          shape = "rectangle",
          x = 752,
          y = 240,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 49,
          name = "",
          type = "stone",
          shape = "rectangle",
          x = 448,
          y = 224,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 50,
          name = "",
          type = "mushroom",
          shape = "rectangle",
          x = 752,
          y = 352,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "",
          type = "mushroom",
          shape = "rectangle",
          x = 384,
          y = 384,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 52,
          name = "",
          type = "mushroom",
          shape = "rectangle",
          x = 272,
          y = 16,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 53,
          name = "",
          type = "mushroom",
          shape = "rectangle",
          x = 400,
          y = 320,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 54,
          name = "",
          type = "mushroom",
          shape = "rectangle",
          x = 288,
          y = 320,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 55,
          name = "",
          type = "stone",
          shape = "rectangle",
          x = 288,
          y = 384,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 56,
          name = "",
          type = "mushroom",
          shape = "rectangle",
          x = 304,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 57,
          name = "",
          type = "mushroom",
          shape = "rectangle",
          x = 208,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 58,
          name = "",
          type = "mushroom",
          shape = "rectangle",
          x = 96,
          y = 288,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "",
          type = "trap_spikes",
          shape = "polyline",
          x = 832,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 32, y = 0 }
          },
          properties = {
            ["direction"] = "up"
          }
        },
        {
          id = 60,
          name = "",
          type = "trap_spikes",
          shape = "polyline",
          x = 912,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["direction"] = "up"
          }
        },
        {
          id = 61,
          name = "",
          type = "trap_spikes",
          shape = "polyline",
          x = 976,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["direction"] = "up"
          }
        },
        {
          id = 62,
          name = "",
          type = "button",
          shape = "polyline",
          x = 512,
          y = 336,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["ref"] = { id = 0 }
          }
        },
        {
          id = 63,
          name = "",
          type = "button",
          shape = "polyline",
          x = 879,
          y = 352,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["ref"] = { id = 0 }
          }
        },
        {
          id = 64,
          name = "",
          type = "button",
          shape = "polyline",
          x = 895,
          y = 350,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["ref"] = { id = 0 }
          }
        },
        {
          id = 65,
          name = "",
          type = "button",
          shape = "polyline",
          x = 911,
          y = 348,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["ref"] = { id = 0 }
          }
        },
        {
          id = 66,
          name = "",
          type = "button",
          shape = "polyline",
          x = 927,
          y = 346,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["ref"] = { id = 0 }
          }
        },
        {
          id = 67,
          name = "",
          type = "button",
          shape = "polyline",
          x = 943,
          y = 344,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["ref"] = { id = 0 }
          }
        },
        {
          id = 68,
          name = "",
          type = "button",
          shape = "polyline",
          x = 959,
          y = 342,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {
            ["ref"] = { id = 0 }
          }
        }
      }
    }
  }
}
