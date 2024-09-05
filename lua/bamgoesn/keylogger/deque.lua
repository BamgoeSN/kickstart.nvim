local M = {}

local Deque = {}
Deque.__index = Deque

function Deque.new()
  local list = setmetatable({ front = 0, back = 0 }, Deque)
  return list
end

function Deque:len()
  return self.back - self.front
end

function Deque:is_empty()
  return self.front == self.back
end

-- Push a value to the front of a queue.
function Deque:push_front(value)
  self.front = self.front - 1
  self[self.front] = value
  vim.print(self)
end

-- Push a value to the back of a queue.
function Deque:push_back(value)
  self[self.back] = value
  self.back = self.back + 1
  vim.print(self)
end

-- Pop a value from the front of a queue.
function Deque:pop_front()
  if self:is_empty() then
    error 'Attempted to pop_front on an empty queue'
  end
  local value = self[self.first]
  self[self.first] = nil
  self.first = self.first + 1
  vim.print(self)
  return value
end

-- Pop a value from the back of a queue.
function Deque:pop_back()
  if self:is_empty() then
    error 'Attempted to pop_back on an empty queue'
  end
  self.back = self.back - 1
  local value = self[self.back]
  self[self.back] = nil
  vim.print(self)
  return value
end

-- Get the front value of a queue.
function Deque:get_front()
  if self:is_empty() then
    error 'Attempted to get_front on an empty queue'
  end
  return self[self.first]
end

-- Get the front value of a queue.
function Deque:get_back()
  if self:is_empty() then
    error 'Attempted to get_back on an empty queue'
  end
  return self[self.back - 1]
end

function Deque:get(index)
  return self[self.front + index]
end

M.Deque = Deque
return M

-- local q = Deque.new()
-- q:push_front(3)
-- q:push_front(4)
-- q:push_back(5)
-- for i = 0, q:len() - 1, 1 do
--   vim.print(q:get(i))
-- end
-- vim.print(q)
