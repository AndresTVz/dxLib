Container = {}
Container.__index = Container

function Container:create(posX, posY, width, height, color)
  local self = setmetatable({}, Container)
  self.posX = posX or 0
  self.posY = posY or 0
  self.width = width or 100
  self.height = height or 100
  self.color = color or tocolor(255, 255, 255, 100)
  self.border_radius = 0
  self.paddingLeft = 0
  self.paddingUp = 0
  self.paddingRight = 0
  self.paddingDown = 0
  return self
end

function Container:backgroundColor(r, g, b, a)
  if type(r) ~= "number" and type(g) ~= "number" and type(b) ~= "number" and type(a) ~= "number" then
    return
  end
  self.color = tocolor(r, g, b, a)
end

function Container:width()
  -- TODO: COME ON
end
function Container:width()
  -- TODO: COME ON
end
function Container:maxWidth()
  -- TODO: COME ON
end
function Container:maxHeight()
  -- TODO: COME ON
end

function Container:borderRadius(border_radius)
  if type(border_radius) ~= "number" then
    self.border_radius = 0
    return
  end
  self.border_radius = border_radius
end

function Container:padding(left, up, right, down)
  if type(left) ~= "number" and type(up) ~= "number" and type(right) ~= "number" and type(down) ~= "number" then
    return
  end
  self.paddingLeft = left
  self.paddingUp = up
  self.paddingRight = right
  self.paddingDown = down
end

function Container:paddingAll(padding)
  if type(padding) ~= "number" then
    return
  end
  self.paddingLeft = padding
  self.paddingUp = padding
  self.paddingRight = padding
  self.paddingDown = padding
end

function Container:render()
  if self.border_radius then
    local offset = self.border_radius * 2

    dxDrawRectangle(
      self.posX - self.paddingLeft,
      self.posY + self.border_radius - self.paddingUp,
      self.width + self.paddingLeft + self.paddingRight,
      self.height - offset + self.paddingUp + self.paddingDown,
      self.color
    ) -- center

    dxDrawRectangle(
      self.posX + self.border_radius - self.paddingLeft,
      self.posY - self.paddingUp,
      self.width - offset + self.paddingLeft + self.paddingRight,
      self.border_radius,
      self.color
    ) -- up
    dxDrawRectangle(
      self.posX + self.border_radius - self.paddingLeft,
      self.posY + self.height - self.border_radius + self.paddingDown,
      self.width - offset + self.paddingLeft + self.paddingRight,
      self.border_radius,
      self.color
    ) -- down

    dxDrawCircle(
      self.posX + self.border_radius - self.paddingLeft,
      self.posY + self.border_radius - self.paddingUp,
      self.border_radius,
      180,
      270,
      self.color,
      self.color,
      7
    ) -- up left
    dxDrawCircle(
      self.posX + self.width - self.border_radius + self.paddingRight,
      self.posY + self.border_radius - self.paddingUp,
      self.border_radius,
      270,
      360,
      self.color,
      self.color,
      7
    ) -- up right

    dxDrawCircle(
      self.posX + self.border_radius - self.paddingLeft,
      self.posY + self.height - self.border_radius + self.paddingDown,
      self.border_radius,
      90,
      180,
      self.color,
      self.color,
      7
    ) -- left down
    dxDrawCircle(
      self.posX + self.width - self.border_radius + self.paddingRight,
      self.posY + self.height - self.border_radius + self.paddingDown,
      self.border_radius,
      0,
      90,
      self.color,
      self.color,
      7
    ) -- right down
    dxDrawRectangle(self.posX, self.posY, self.width, self.height, tocolor(0, 0, 0, 200)) -- orginal rectangle
  else
    dxDrawRectangle(self.posX, self.posY, self.width, self.height, self.color)
  end
end
