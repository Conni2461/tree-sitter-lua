require('plenary.test_harness'):setup_busted()

local methods = require('nlsp.methods')
local state = require('nlsp.state')
-- local structures = require('nlsp.structures')

describe('text_document_sync', function()
  before_each(function()
    -- Clear the state between executions.
    state._clear()
  end)

  it('should support opening a textDocument', function()
    local uri = vim.uri_from_fname("/home/fake.lua")
    local item = {
      uri = uri,
      text = "local hello = 'world'",
    }


    methods["textDocument/didOpen"] {
      textDocument = item
    }

    local saved_item = state.get_text_document_item(uri)
    assert.are.same(saved_item.text, item.text)
  end)

  it('should support changing a textDocument', function()
    local uri = vim.uri_from_fname("/home/fake.lua")
    local item = {
      uri = uri,
      text = "local hello = 'world'",
    }

    local new_text = "local hello = 'goodbye'"

    methods["textDocument/didOpen"] {
      textDocument = vim.deepcopy(item)
    }

    methods["textDocument/didChange"] {
      textDocument = {
        uri = uri,
      },
      contentChanges = {
        { text = new_text }
      }
    }

    local saved_item = state.get_text_document_item(uri)
    assert.are.same(saved_item.text, new_text)
    assert.are_not.same(item.text, new_text)
  end)

  it('should not allow calling didChange before didOpen', function()
    local uri = vim.uri_from_fname("/home/fake.lua")

    local ok = pcall(methods["textDocument/didChange"], {
      textDocument = {
        uri = uri,
      },
      contentChanges = {
        { text = "this should not matter" }
      }
    })

    assert(not ok)
  end)

  it('should support saving', function()
    local uri = vim.uri_from_fname("/home/fake.lua")
    local item = {
      uri = uri,
      text = "local hello = 'world'",
    }

    local new_text = "local hello = 'goodbye'"

    methods["textDocument/didOpen"] {
      textDocument = vim.deepcopy(item)
    }

    methods["textDocument/didSave"] {
      textDocument = {
        uri = uri,
      },
      text = new_text,
    }

    local saved_item = state.get_text_document_item(uri)
    assert.are.same(saved_item.text, new_text)
    assert.are_not.same(item.text, new_text)
  end)

  it('should not allow calling didSave before didOpen', function()
    local uri = vim.uri_from_fname("/home/fake.lua")

    local ok = pcall(methods["textDocument/didSave"], {
      textDocument = {
        uri = uri,
      },
      text = "this should not matter",
    })

    assert(not ok)
  end)

  it('should allow closing documents', function()
    local uri = vim.uri_from_fname("/home/fake.lua")
    local item = {
      uri = uri,
      text = "local hello = 'world'",
    }

    methods["textDocument/didOpen"] {
      textDocument = vim.deepcopy(item)
    }

    methods["textDocument/didClose"] {
      textDocument = {
        uri = uri,
      },
    }

    local saved_item = state.get_text_document_item(uri)
    assert(saved_item == nil)
  end)
end)
