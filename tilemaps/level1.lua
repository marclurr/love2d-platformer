return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.2",
  orientation = "orthogonal",
  renderorder = "left-down",
  width = 20,
  height = 12,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 3,
  nextobjectid = 27,
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
          properties = {
            ["one_way"] = false,
            ["solid"] = true
          }
        },
        {
          id = 1,
          properties = {
            ["one_way"] = false,
            ["solid"] = true
          }
        },
        {
          id = 2,
          properties = {
            ["one_way"] = false,
            ["solid"] = true
          }
        },
        {
          id = 3,
          properties = {
            ["solid"] = false
          }
        },
        {
          id = 4,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 5,
          properties = {
            ["solid"] = false
          }
        },
        {
          id = 6,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 7,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 8,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 10,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 12,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 14,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 15,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 17,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 18,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 20,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 21,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 23,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 24,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 25,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 26,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 27,
          properties = {
            ["solid"] = false
          }
        },
        {
          id = 28,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 29,
          properties = {
            ["solid"] = false
          }
        },
        {
          id = 30,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 31,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 32,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 34,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 42,
          properties = {
            ["drop_through"] = true,
            ["one_way"] = true,
            ["solid"] = true
          }
        },
        {
          id = 43,
          properties = {
            ["drop_through"] = true,
            ["one_way"] = true,
            ["solid"] = true
          }
        },
        {
          id = 44,
          properties = {
            ["drop_through"] = true,
            ["one_way"] = true,
            ["solid"] = true
          }
        },
        {
          id = 54,
          properties = {
            ["one_way"] = true,
            ["solid"] = true
          }
        },
        {
          id = 55,
          properties = {
            ["one_way"] = true,
            ["solid"] = true
          }
        },
        {
          id = 56,
          properties = {
            ["one_way"] = true,
            ["solid"] = true
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 12,
      id = 1,
      name = "Tile Layer 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12,
        22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24,
        22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24,
        22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24,
        22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24,
        22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24,
        22, 0, 7, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24,
        22, 0, 31, 32, 33, 55, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 57, 0, 0, 24,
        22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24,
        22, 0, 0, 7, 8, 9, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 36,
        34, 35, 35, 36, 20, 34, 35, 36, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20,
        20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Object Layer 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = -48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 144,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "player_spawn",
          shape = "rectangle",
          x = 203,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "stone",
          shape = "rectangle",
          x = 240,
          y = 96,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "stone",
          shape = "rectangle",
          x = 192,
          y = 128,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          type = "button",
          shape = "polyline",
          x = 272,
          y = 144,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = 0 }
          },
          properties = {}
        },
        {
          id = 26,
          name = "",
          type = "trap_spikes",
          shape = "polyline",
          x = 16,
          y = 160,
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
        }
      }
    }
  }
}
