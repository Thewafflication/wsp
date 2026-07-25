-- Rewrite Markdown source-file links as internal PDF destinations.

local function normalize(path)
  path = path:gsub('\\', '/')
  local drive = path:match('^([A-Za-z]:)/')
  if drive then
    path = path:sub(4)
  end
  local parts = {}
  for part in path:gmatch('[^/]+') do
    if part == '..' then
      if #parts > 0 then
        table.remove(parts)
      end
    elseif part ~= '.' and part ~= '' then
      table.insert(parts, part)
    end
  end
  local result = table.concat(parts, '/')
  if drive then
    result = drive:lower() .. '/' .. result
  end
  return result:lower()
end

local function directory(path)
  return path:match('^(.*)/[^/]+$') or ''
end

local function load_manifest()
  local path = os.getenv('WSP_DOCUMENT_MANIFEST')
  if not path or path == '' then
    error('WSP_DOCUMENT_MANIFEST is not set')
  end
  local file = assert(io.open(path, 'rb'))
  local contents = file:read('*all')
  file:close()
  return pandoc.json.decode(contents)
end

function Pandoc(document)
  local manifest = load_manifest()
  local files = {}
  for _, path in ipairs(manifest.files) do
    table.insert(files, normalize(path))
  end

  local identifiers = {}
  local file_index = 0
  local current_file = nil

  for _, block in ipairs(document.blocks) do
    if block.t == 'Header' and block.level == 1 then
      file_index = file_index + 1
      current_file = files[file_index]
      if current_file then
        identifiers[current_file] = identifiers[current_file] or {}
        identifiers[current_file][''] = block.identifier
      end
    elseif block.t == 'Header' and current_file then
      local suffix = block.identifier:match('__([^_].*)$')
      if suffix then
        identifiers[current_file][suffix] = block.identifier
      end
    end
  end

  file_index = 0
  current_file = nil
  local rewritten = {}
  for _, block in ipairs(document.blocks) do
    if block.t == 'Header' and block.level == 1 then
      file_index = file_index + 1
      current_file = files[file_index]
    end
    local updated = pandoc.walk_block(block, {
      Link = function(link)
        if not current_file then
          return link
        end
        local path, fragment = link.target:match('^([^#]+)#?(.*)$')
        if not path or not path:lower():match('%.md$') then
          return link
        end
        local resolved = normalize(directory(current_file) .. '/' .. path)
        local targets = identifiers[resolved]
        if not targets then
          return link
        end
        local identifier = targets[fragment or '']
        if not identifier and fragment and fragment ~= '' then
          for suffix, candidate in pairs(targets) do
            if suffix:sub(-#fragment) == fragment then
              identifier = candidate
              break
            end
          end
        end
        if identifier then
          link.target = '#' .. identifier
        end
        return link
      end
    })
    table.insert(rewritten, updated)
  end
  document.blocks = rewritten
  return document
end
