DxRectangle = {}
DxRectangle.__index = DxRectangle

function DxRectangle:create(posX, posY, width, height, border, color)
  local self = setmetatable({}, DxRectangle)
  self.posX = type(posX) == "number" and posX or 0
  self.posY = type(posY) == "number" and posY or 0
  self.width = type(width) == "number" and width or 100
  self.height = type(height) == "number" and height or 100
  self.border = border or false
  self.color = color or tocolor(255, 255, 255, 255)
  self.paddingLeft = 0
  self.paddingUp = 0
  self.paddingRight = 0
  self.paddingDown = 0
  return self
end

function DxRectangle:background_color(r, g, b, a)
  if type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number" or type(a) ~= "number" then
    return outputDebugString("Bad Argument @'background_color' [ Expected Number at argument 1,2,3,4 ]", 2)
  end

  self.color = tocolor(r, g, b, a)
end

function DxRectangle:border_radius(border)
  if not border then
    self.border = false
  else
    if type(border) ~= "number" then
      return outputDebugString("Bad Argument @'border_radius' [ Expected Number at argument 1 ]", 2)
    end
    self.border = border
  end
end

function DxRectangle:padding(left, up, right, down)
  if type(left) ~= "number" or type(up) ~= "number" or type(right) ~= "number" or type(down) ~= "number" then
    return outputDebugString("Bad Argument @'padding' [ Expected Number at argument 1,2,3,4 ]", 2)
  end
  self.paddingLeft = left
  self.paddingUp = up
  self.paddingRight = right
  self.paddingDown = down
end

function DxRectangle:paddingAll(padding)
  if type(padding) ~= "number" then
    return outputDebugString("Bad Argument @'paddingAll' [ Expected Number at argument 1 ]", 2)
  end
  self.paddingLeft = padding
  self.paddingUp = padding
  self.paddingRight = padding
  self.paddingDown = padding
end

function DxRectangle:width(width)
  if type(width) ~= "number" then
    return outputDebugString("Bad Argument @'width' [ Expected Number at argument 1 ]", 2)
  end
  self.width = width
end

function DxRectangle:height(height)
  if type(height) ~= "number" then
    return outputDebugString("Bad Argument @'height' [ Expected Number at argument 1 ]", 2)
  end

  self.height = height
end

function DxRectangle:render()
  if self.border then
    self.border = self.border >= self.height and self.height or self.border
    local offset = self.border / 2

    dxDrawRectangle(
      self.posX + offset - self.paddingLeft,
      self.posY - self.paddingUp,
      self.width - offset * 2 + self.paddingLeft + self.paddingRight,
      offset,
      self.color
    ) -- up
    dxDrawRectangle(
      self.posX + offset - self.paddingLeft,
      self.posY + self.height - offset + self.paddingDown,
      self.width - offset * 2 + self.paddingLeft + self.paddingRight,
      offset,
      self.color
    ) -- down

    dxDrawRectangle(
      self.posX - self.paddingLeft,
      self.posY + offset - self.paddingUp,
      self.width + self.paddingLeft + self.paddingRight,
      self.height - offset * 2 + self.paddingUp + self.paddingDown,
      self.color
    ) -- center

    dxDrawCircle(self.posX + offset - self.paddingLeft, self.posY + offset - self.paddingUp, offset, 180, 270, self.color, self.color, 7) --left up
    dxDrawCircle(
      self.posX + self.width - offset + self.paddingRight,
      self.posY + offset - self.paddingUp,
      offset,
      270,
      360,
      self.color,
      self.color,
      7
    ) -- right up
    dxDrawCircle(
      self.posX + offset - self.paddingLeft,
      self.posY + self.height - offset + self.paddingDown,
      offset,
      90,
      180,
      self.color,
      self.color,
      7
    ) -- left down
    dxDrawCircle(
      self.posX + self.width - offset + self.paddingRight,
      self.posY + self.height - offset + self.paddingDown,
      offset,
      0,
      90,
      self.color,
      self.color,
      7
    ) -- right down
  else
    dxDrawRectangle(self.posX, self.posY, self.width, self.height, self.color)
  end
end

