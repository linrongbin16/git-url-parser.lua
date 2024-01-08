describe("giturlparser", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function() end)

  local inspect = require("inspect")
  local giturlparser = require("giturlparser")
  describe("[_make_path]", function()
    it("repo.git", function()
      local actual = giturlparser._make_path("repo.git", 1)
      assert_eq(actual.org, nil)
      assert_eq(actual.org_pos, nil)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 1)
      assert_eq(actual.repo_pos.end_pos, 8)
      assert_eq(actual.path, "repo.git")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 8)
    end)
    it("repo.git/", function()
      local actual = giturlparser._make_path("repo.git/", 1)
      assert_eq(actual.org, nil)
      assert_eq(actual.org_pos, nil)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 1)
      assert_eq(actual.repo_pos.end_pos, 8)
      assert_eq(actual.path, "repo.git/")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 9)
    end)
    it("/repo.git/", function()
      local actual = giturlparser._make_path("/repo.git/", 1)
      assert_eq(actual.org, nil)
      assert_eq(actual.org_pos, nil)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 2)
      assert_eq(actual.repo_pos.end_pos, 9)
      assert_eq(actual.path, "/repo.git/")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 10)
    end)
    it("/repo.git", function()
      local actual = giturlparser._make_path("/repo.git", 1)
      assert_eq(actual.org, nil)
      assert_eq(actual.org_pos, nil)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 2)
      assert_eq(actual.repo_pos.end_pos, 9)
      assert_eq(actual.path, "/repo.git")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 9)
    end)
    it("prefix/repo.git", function()
      local actual = giturlparser._make_path("prefix/repo.git", 7)
      assert_eq(actual.org, nil)
      assert_eq(actual.org_pos, nil)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 8)
      assert_eq(actual.repo_pos.end_pos, 15)
      assert_eq(actual.path, "/repo.git")
      assert_eq(actual.path_pos.start_pos, 7)
      assert_eq(actual.path_pos.end_pos, 15)
    end)
    it("prefix/repo.git/", function()
      local actual = giturlparser._make_path("prefix/repo.git/", 7)
      assert_eq(actual.org, nil)
      assert_eq(actual.org_pos, nil)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 8)
      assert_eq(actual.repo_pos.end_pos, 15)
      assert_eq(actual.path, "/repo.git/")
      assert_eq(actual.path_pos.start_pos, 7)
      assert_eq(actual.path_pos.end_pos, 16)
    end)
    it("path/to/the/repo.git", function()
      local actual = giturlparser._make_path("path/to/the/repo.git", 1)
      assert_eq(actual.org, "path/to/the")
      assert_eq(actual.org_pos.start_pos, 1)
      assert_eq(actual.org_pos.end_pos, 11)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 13)
      assert_eq(actual.repo_pos.end_pos, 20)
      assert_eq(actual.path, "path/to/the/repo.git")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 20)
    end)
    it("path/to/the/repo.git/", function()
      local actual = giturlparser._make_path("path/to/the/repo.git/", 1)
      assert_eq(actual.org, "path/to/the")
      assert_eq(actual.org_pos.start_pos, 1)
      assert_eq(actual.org_pos.end_pos, 11)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 13)
      assert_eq(actual.repo_pos.end_pos, 20)
      assert_eq(actual.path, "path/to/the/repo.git/")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 21)
    end)
    it("/abspath/to/the/repo.git", function()
      local actual = giturlparser._make_path("/abspath/to/the/repo.git", 1)
      assert_eq(actual.org, "abspath/to/the")
      assert_eq(actual.org_pos.start_pos, 2)
      assert_eq(actual.org_pos.end_pos, 15)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 17)
      assert_eq(actual.repo_pos.end_pos, 24)
      assert_eq(actual.path, "/abspath/to/the/repo.git")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 24)
    end)
    it("/abspath/to/the/repo.git/", function()
      local actual = giturlparser._make_path("/abspath/to/the/repo.git/", 1)
      assert_eq(actual.org, "abspath/to/the")
      assert_eq(actual.org_pos.start_pos, 2)
      assert_eq(actual.org_pos.end_pos, 15)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 17)
      assert_eq(actual.repo_pos.end_pos, 24)
      assert_eq(actual.path, "/abspath/to/the/repo.git/")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 25)
    end)
    it("prefix/path/to/the/repo.git", function()
      local actual = giturlparser._make_path("prefix/path/to/the/repo.git", 7)
      assert_eq(actual.org, "path/to/the")
      assert_eq(actual.org_pos.start_pos, 8)
      assert_eq(actual.org_pos.end_pos, 18)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 20)
      assert_eq(actual.repo_pos.end_pos, 27)
      assert_eq(actual.path, "/path/to/the/repo.git")
      assert_eq(actual.path_pos.start_pos, 7)
      assert_eq(actual.path_pos.end_pos, 27)
    end)
    it("prefix/path/to/the/repo.git/", function()
      local actual = giturlparser._make_path("prefix/path/to/the/repo.git/", 8)
      assert_eq(actual.org, "path/to/the")
      assert_eq(actual.org_pos.start_pos, 8)
      assert_eq(actual.org_pos.end_pos, 18)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 20)
      assert_eq(actual.repo_pos.end_pos, 27)
      assert_eq(actual.path, "path/to/the/repo.git/")
      assert_eq(actual.path_pos.start_pos, 8)
      assert_eq(actual.path_pos.end_pos, 28)
    end)
    it("~/path/to/the/repo.git", function()
      local actual = giturlparser._make_path("~/path/to/the/repo.git", 1)
      assert_eq(actual.org, "~/path/to/the")
      assert_eq(actual.org_pos.start_pos, 1)
      assert_eq(actual.org_pos.end_pos, 13)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 15)
      assert_eq(actual.repo_pos.end_pos, 22)
      assert_eq(actual.path, "~/path/to/the/repo.git")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 22)
    end)
    it("~/path/to/the/repo.git/", function()
      local actual = giturlparser._make_path("~/path/to/the/repo.git/", 1)
      assert_eq(actual.org, "~/path/to/the")
      assert_eq(actual.org_pos.start_pos, 1)
      assert_eq(actual.org_pos.end_pos, 13)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 15)
      assert_eq(actual.repo_pos.end_pos, 22)
      assert_eq(actual.path, "~/path/to/the/repo.git/")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 23)
    end)
    it("./path/to/the/repo.git", function()
      local actual = giturlparser._make_path("./path/to/the/repo.git", 1)
      assert_eq(actual.org, "./path/to/the")
      assert_eq(actual.org_pos.start_pos, 1)
      assert_eq(actual.org_pos.end_pos, 13)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 15)
      assert_eq(actual.repo_pos.end_pos, 22)
      assert_eq(actual.path, "./path/to/the/repo.git")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 22)
    end)
    it("../path/to/the/repo.git/", function()
      local actual = giturlparser._make_path("../path/to/the/repo.git/", 1)
      assert_eq(actual.org, "../path/to/the")
      assert_eq(actual.org_pos.start_pos, 1)
      assert_eq(actual.org_pos.end_pos, 14)
      assert_eq(actual.repo, "repo.git")
      assert_eq(actual.repo_pos.start_pos, 16)
      assert_eq(actual.repo_pos.end_pos, 23)
      assert_eq(actual.path, "../path/to/the/repo.git/")
      assert_eq(actual.path_pos.start_pos, 1)
      assert_eq(actual.path_pos.end_pos, 24)
    end)
  end)

  describe("[_make_host]", function()
    it("github.com/org/repo.git", function()
      local actual = giturlparser._make_host("github.com/org/repo.git", 1)
      -- print(string.format("_make_host-1:%s\n", inspect(actual)))
      assert_eq(actual.host, "github.com")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 10)
      assert_eq(actual.port, nil)
      assert_eq(actual.port_pos, nil)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, "org")
      assert_eq(path_obj.org_pos.start_pos, 12)
      assert_eq(path_obj.org_pos.end_pos, 14)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 16)
      assert_eq(path_obj.repo_pos.end_pos, 23)
      assert_eq(path_obj.path, "/org/repo.git")
      assert_eq(path_obj.path_pos.start_pos, 11)
      assert_eq(path_obj.path_pos.end_pos, 23)
    end)
    it("github.com/org/repo.git/", function()
      local actual = giturlparser._make_host("github.com/org/repo.git/", 1)
      -- print(string.format("_make_host-2:%s\n", inspect(actual)))
      assert_eq(actual.host, "github.com")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 10)
      assert_eq(actual.port, nil)
      assert_eq(actual.port_pos, nil)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, "org")
      assert_eq(path_obj.org_pos.start_pos, 12)
      assert_eq(path_obj.org_pos.end_pos, 14)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 16)
      assert_eq(path_obj.repo_pos.end_pos, 23)
      assert_eq(path_obj.path, "/org/repo.git/")
      assert_eq(path_obj.path_pos.start_pos, 11)
      assert_eq(path_obj.path_pos.end_pos, 24)
    end)
    it("github.com:port/org/repo.git", function()
      local actual = giturlparser._make_host("github.com:port/org/repo.git", 1)
      -- print(string.format("_make_host-3:%s\n", inspect(actual)))
      assert_eq(actual.host, "github.com")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 10)
      assert_eq(actual.port, "port")
      assert_eq(actual.port_pos.start_pos, 12)
      assert_eq(actual.port_pos.end_pos, 15)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, "org")
      assert_eq(path_obj.org_pos.start_pos, 17)
      assert_eq(path_obj.org_pos.end_pos, 19)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 21)
      assert_eq(path_obj.repo_pos.end_pos, 28)
      assert_eq(path_obj.path, "/org/repo.git")
      assert_eq(path_obj.path_pos.start_pos, 16)
      assert_eq(path_obj.path_pos.end_pos, 28)
    end)
    it("127.0.0.1:12345/org/repo.git/", function()
      local actual = giturlparser._make_host("127.0.0.1:12345/org/repo.git/", 1)
      -- print(string.format("_make_host-4:%s\n", inspect(actual)))
      assert_eq(actual.host, "127.0.0.1")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 9)
      assert_eq(actual.port, "12345")
      assert_eq(actual.port_pos.start_pos, 11)
      assert_eq(actual.port_pos.end_pos, 15)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, "org")
      assert_eq(path_obj.org_pos.start_pos, 17)
      assert_eq(path_obj.org_pos.end_pos, 19)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 21)
      assert_eq(path_obj.repo_pos.end_pos, 28)
      assert_eq(path_obj.path, "/org/repo.git/")
      assert_eq(path_obj.path_pos.start_pos, 16)
      assert_eq(path_obj.path_pos.end_pos, 29)
    end)
    it("github.com/repo.git", function()
      local actual = giturlparser._make_host("github.com/repo.git", 1)
      -- print(string.format("_make_host-3:%s\n", inspect(actual)))
      assert_eq(actual.host, "github.com")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 10)
      assert_eq(actual.port, nil)
      assert_eq(actual.port_pos, nil)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, nil)
      assert_eq(path_obj.org_pos, nil)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 12)
      assert_eq(path_obj.repo_pos.end_pos, 19)
      assert_eq(path_obj.path, "/repo.git")
      assert_eq(path_obj.path_pos.start_pos, 11)
      assert_eq(path_obj.path_pos.end_pos, 19)
    end)
    it("127.0.0.1:12345/repo.git/", function()
      local actual = giturlparser._make_host("127.0.0.1:12345/repo.git/", 1)
      -- print(string.format("_make_host-4:%s\n", inspect(actual)))
      assert_eq(actual.host, "127.0.0.1")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 9)
      assert_eq(actual.port, "12345")
      assert_eq(actual.port_pos.start_pos, 11)
      assert_eq(actual.port_pos.end_pos, 15)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, nil)
      assert_eq(path_obj.org_pos, nil)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 17)
      assert_eq(path_obj.repo_pos.end_pos, 24)
      assert_eq(path_obj.path, "/repo.git/")
      assert_eq(path_obj.path_pos.start_pos, 16)
      assert_eq(path_obj.path_pos.end_pos, 25)
    end)
  end)

  describe("[_make_host_with_omit_ssh]", function()
    it("github.com:org/repo.git", function()
      local actual =
        giturlparser._make_host_with_omit_ssh("github.com:org/repo.git", 1)
      -- print(string.format("_make_host_with_omit_ssh-1:%s\n", inspect(actual)))
      assert_eq(actual.host, "github.com")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 10)
      assert_eq(actual.port, nil)
      assert_eq(actual.port_pos, nil)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, "org")
      assert_eq(path_obj.org_pos.start_pos, 12)
      assert_eq(path_obj.org_pos.end_pos, 14)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 16)
      assert_eq(path_obj.repo_pos.end_pos, 23)
      assert_eq(path_obj.path, "org/repo.git")
      assert_eq(path_obj.path_pos.start_pos, 12)
      assert_eq(path_obj.path_pos.end_pos, 23)
    end)
    it("github.com:org/repo.git/", function()
      local actual =
        giturlparser._make_host_with_omit_ssh("github.com:org/repo.git/", 1)
      -- print(string.format("_make_host_with_omit_ssh-2:%s\n", inspect(actual)))
      assert_eq(actual.host, "github.com")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 10)
      assert_eq(actual.port, nil)
      assert_eq(actual.port_pos, nil)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, "org")
      assert_eq(path_obj.org_pos.start_pos, 12)
      assert_eq(path_obj.org_pos.end_pos, 14)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 16)
      assert_eq(path_obj.repo_pos.end_pos, 23)
      assert_eq(path_obj.path, "org/repo.git/")
      assert_eq(path_obj.path_pos.start_pos, 12)
      assert_eq(path_obj.path_pos.end_pos, 24)
    end)
    it("github.com:port/org/repo.git", function()
      local actual = giturlparser._make_host("github.com:port/org/repo.git", 1)
      -- print(string.format("_make_host-3:%s\n", inspect(actual)))
      assert_eq(actual.host, "github.com")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 10)
      assert_eq(actual.port, "port")
      assert_eq(actual.port_pos.start_pos, 12)
      assert_eq(actual.port_pos.end_pos, 15)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, "org")
      assert_eq(path_obj.org_pos.start_pos, 17)
      assert_eq(path_obj.org_pos.end_pos, 19)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 21)
      assert_eq(path_obj.repo_pos.end_pos, 28)
      assert_eq(path_obj.path, "/org/repo.git")
      assert_eq(path_obj.path_pos.start_pos, 16)
      assert_eq(path_obj.path_pos.end_pos, 28)
    end)
    it("127.0.0.1:12345/org/repo.git/", function()
      local actual = giturlparser._make_host("127.0.0.1:12345/org/repo.git/", 1)
      -- print(string.format("_make_host-4:%s\n", inspect(actual)))
      assert_eq(actual.host, "127.0.0.1")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 9)
      assert_eq(actual.port, "12345")
      assert_eq(actual.port_pos.start_pos, 11)
      assert_eq(actual.port_pos.end_pos, 15)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, "org")
      assert_eq(path_obj.org_pos.start_pos, 17)
      assert_eq(path_obj.org_pos.end_pos, 19)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 21)
      assert_eq(path_obj.repo_pos.end_pos, 28)
      assert_eq(path_obj.path, "/org/repo.git/")
      assert_eq(path_obj.path_pos.start_pos, 16)
      assert_eq(path_obj.path_pos.end_pos, 29)
    end)
    it("github.com/repo.git", function()
      local actual = giturlparser._make_host("github.com/repo.git", 1)
      -- print(string.format("_make_host-3:%s\n", inspect(actual)))
      assert_eq(actual.host, "github.com")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 10)
      assert_eq(actual.port, nil)
      assert_eq(actual.port_pos, nil)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, nil)
      assert_eq(path_obj.org_pos, nil)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 12)
      assert_eq(path_obj.repo_pos.end_pos, 19)
      assert_eq(path_obj.path, "/repo.git")
      assert_eq(path_obj.path_pos.start_pos, 11)
      assert_eq(path_obj.path_pos.end_pos, 19)
    end)
    it("127.0.0.1:12345/repo.git/", function()
      local actual = giturlparser._make_host("127.0.0.1:12345/repo.git/", 1)
      -- print(string.format("_make_host-4:%s\n", inspect(actual)))
      assert_eq(actual.host, "127.0.0.1")
      assert_eq(actual.host_pos.start_pos, 1)
      assert_eq(actual.host_pos.end_pos, 9)
      assert_eq(actual.port, "12345")
      assert_eq(actual.port_pos.start_pos, 11)
      assert_eq(actual.port_pos.end_pos, 15)
      local path_obj = actual.path_obj
      assert_eq(path_obj.org, nil)
      assert_eq(path_obj.org_pos, nil)
      assert_eq(path_obj.repo, "repo.git")
      assert_eq(path_obj.repo_pos.start_pos, 17)
      assert_eq(path_obj.repo_pos.end_pos, 24)
      assert_eq(path_obj.path, "/repo.git/")
      assert_eq(path_obj.path_pos.start_pos, 16)
      assert_eq(path_obj.path_pos.end_pos, 25)
    end)
  end)

  -- describe("[parse http(s)]", function()
  --   it("http://host.xz/path/to/repo.git/", function()
  --     local actual = giturlparser.parse("http://host.xz/path/to/repo.git/")
  --     assert_eq(type(actual), "table")
  --     assert_eq(actual.protocol, "http")
  --     assert_eq(actual.protocol_pos.start_pos, 1)
  --     assert_eq(actual.protocol_pos.end_pos, 4)
  --     assert_eq(actual.user, nil)
  --     assert_eq(actual.user_pos, nil)
  --     assert_eq(actual.password, nil)
  --     assert_eq(actual.password_pos, nil)
  --     assert_eq(actual.host, "host.xz")
  --     assert_eq(actual.host_pos.start_pos, 8)
  --     assert_eq(actual.host_pos.end_pos, 14)
  --     assert_eq(actual.org, "path/to")
  --     assert_eq(actual.org_pos.start_pos, 16)
  --     assert_eq(actual.org_pos.end_pos, 22)
  --     assert_eq(actual.repo, "repo.git")
  --     assert_eq(actual.repo_pos.start_pos, 24)
  --     assert_eq(actual.repo_pos.end_pos, 31)
  --   end)
  --   it("http://host.xz/path/to/repo.git", function()
  --     local actual = giturlparser.parse("http://host.xz/path/to/repo.git")
  --     assert_eq(type(actual), "table")
  --     assert_eq(actual.protocol, "http")
  --     assert_eq(actual.protocol_pos.start_pos, 1)
  --     assert_eq(actual.protocol_pos.end_pos, 4)
  --     assert_eq(actual.user, nil)
  --     assert_eq(actual.user_pos, nil)
  --     assert_eq(actual.password, nil)
  --     assert_eq(actual.password_pos, nil)
  --     assert_eq(actual.host, "host.xz")
  --     assert_eq(actual.host_pos.start_pos, 8)
  --     assert_eq(actual.host_pos.end_pos, 14)
  --     assert_eq(actual.org, "path/to")
  --     assert_eq(actual.org_pos.start_pos, 16)
  --     assert_eq(actual.org_pos.end_pos, 22)
  --     assert_eq(actual.repo, "repo.git")
  --     assert_eq(actual.repo_pos.start_pos, 24)
  --     assert_eq(actual.repo_pos.end_pos, 31)
  --   end)
  --   it("https://host.xz/path/to/repo.git/", function()
  --     local actual = giturlparser.parse("https://host.xz/path/to/repo.git/")
  --     assert_eq(type(actual), "table")
  --     assert_eq(actual.protocol, "https")
  --     assert_eq(actual.protocol_pos.start_pos, 1)
  --     assert_eq(actual.protocol_pos.end_pos, 5)
  --     assert_eq(actual.user, nil)
  --     assert_eq(actual.user_pos, nil)
  --     assert_eq(actual.password, nil)
  --     assert_eq(actual.password_pos, nil)
  --     assert_eq(actual.host, "host.xz")
  --     assert_eq(actual.host_pos.start_pos, 9)
  --     assert_eq(actual.host_pos.end_pos, 15)
  --     assert_eq(actual.org, "path/to")
  --     assert_eq(actual.org_pos.start_pos, 17)
  --     assert_eq(actual.org_pos.end_pos, 23)
  --     assert_eq(actual.repo, "repo.git")
  --     assert_eq(actual.repo_pos.start_pos, 25)
  --     assert_eq(actual.repo_pos.end_pos, 32)
  --   end)
  --   it("https://host.xz/path/to/repo.git", function()
  --     local actual = giturlparser.parse("https://host.xz/path/to/repo.git")
  --     assert_eq(type(actual), "table")
  --     assert_eq(actual.protocol, "https")
  --     assert_eq(actual.protocol_pos.start_pos, 1)
  --     assert_eq(actual.protocol_pos.end_pos, 5)
  --     assert_eq(actual.user, nil)
  --     assert_eq(actual.user_pos, nil)
  --     assert_eq(actual.password, nil)
  --     assert_eq(actual.password_pos, nil)
  --     assert_eq(actual.host, "host.xz")
  --     assert_eq(actual.host_pos.start_pos, 9)
  --     assert_eq(actual.host_pos.end_pos, 15)
  --     assert_eq(actual.org, "path/to")
  --     assert_eq(actual.org_pos.start_pos, 17)
  --     assert_eq(actual.org_pos.end_pos, 23)
  --     assert_eq(actual.repo, "repo.git")
  --     assert_eq(actual.repo_pos.start_pos, 25)
  --     assert_eq(actual.repo_pos.end_pos, 32)
  --   end)
  --   it("https://git.samba.com/samba.git", function()
  --     local actual = giturlparser.parse("https://git.samba.com/samba.git")
  --     assert_eq(type(actual), "table")
  --     assert_eq(actual.protocol, "https")
  --     assert_eq(actual.protocol_pos.start_pos, 1)
  --     assert_eq(actual.protocol_pos.end_pos, 5)
  --     assert_eq(actual.user, nil)
  --     assert_eq(actual.user_pos, nil)
  --     assert_eq(actual.password, nil)
  --     assert_eq(actual.password_pos, nil)
  --     assert_eq(actual.host, "git.samba.com")
  --     assert_eq(actual.host_pos.start_pos, 9)
  --     assert_eq(actual.host_pos.end_pos, 21)
  --     assert_eq(actual.org, nil)
  --     assert_eq(actual.org_pos, nil)
  --     assert_eq(actual.repo, "samba.git")
  --     assert_eq(actual.repo_pos.start_pos, 23)
  --     assert_eq(actual.repo_pos.end_pos, 31)
  --   end)
  --   it("https://git.samba.com/samba.git/", function()
  --     local actual = giturlparser.parse("https://git.samba.com/samba.git/")
  --     assert_eq(type(actual), "table")
  --     assert_eq(actual.protocol, "https")
  --     assert_eq(actual.protocol_pos.start_pos, 1)
  --     assert_eq(actual.protocol_pos.end_pos, 5)
  --     assert_eq(actual.user, nil)
  --     assert_eq(actual.user_pos, nil)
  --     assert_eq(actual.password, nil)
  --     assert_eq(actual.password_pos, nil)
  --     assert_eq(actual.host, "git.samba.com")
  --     assert_eq(actual.host_pos.start_pos, 9)
  --     assert_eq(actual.host_pos.end_pos, 21)
  --     assert_eq(actual.org, nil)
  --     assert_eq(actual.org_pos, nil)
  --     assert_eq(actual.repo, "samba.git")
  --     assert_eq(actual.repo_pos.start_pos, 23)
  --     assert_eq(actual.repo_pos.end_pos, 31)
  --   end)
  --   it("https://git.samba.org/bbaumbach/samba.git", function()
  --     local actual =
  --       giturlparser.parse("https://git.samba.org/bbaumbach/samba.git")
  --     assert_eq(type(actual), "table")
  --     assert_eq(actual.protocol, "https")
  --     assert_eq(actual.protocol_pos.start_pos, 1)
  --     assert_eq(actual.protocol_pos.end_pos, 5)
  --     assert_eq(actual.user, nil)
  --     assert_eq(actual.user_pos, nil)
  --     assert_eq(actual.password, nil)
  --     assert_eq(actual.password_pos, nil)
  --     assert_eq(actual.host, "git.samba.org")
  --     assert_eq(actual.host_pos.start_pos, 9)
  --     assert_eq(actual.host_pos.end_pos, 21)
  --     assert_eq(actual.org, "bbaumbach")
  --     assert_eq(actual.org_pos.start_pos, 23)
  --     assert_eq(actual.org_pos.end_pos, 31)
  --     assert_eq(actual.repo, "samba.git")
  --     assert_eq(actual.repo_pos.start_pos, 33)
  --     assert_eq(actual.repo_pos.end_pos, 41)
  --   end)
  --   it("https://username:password@git.samba.com/samba.git", function()
  --     local actual =
  --       giturlparser.parse("https://username:password@git.samba.com/samba.git")
  --     assert_eq(type(actual), "table")
  --     assert_eq(actual.protocol, "https")
  --     assert_eq(actual.protocol_pos.start_pos, 1)
  --     assert_eq(actual.protocol_pos.end_pos, 5)
  --     assert_eq(actual.user, "username")
  --     assert_eq(actual.user_pos.start_pos, 9)
  --     assert_eq(actual.user_pos.end_pos, 16)
  --     assert_eq(actual.password, "password")
  --     assert_eq(actual.password_pos.start_pos, 18)
  --     assert_eq(actual.password_pos.end_pos, 25)
  --     assert_eq(actual.host, "git.samba.com")
  --     assert_eq(actual.host_pos.start_pos, 27)
  --     assert_eq(actual.host_pos.end_pos, 39)
  --     assert_eq(actual.org, nil)
  --     assert_eq(actual.org_pos, nil)
  --     assert_eq(actual.repo, "samba.git")
  --     assert_eq(actual.repo_pos.start_pos, 41)
  --     assert_eq(actual.repo_pos.end_pos, 49)
  --   end)
  -- end)
  -- describe("[parse ssh]", function()
  --   it("ssh://user@host.xz:org/repo.git", function()
  --     local actual = giturlparser.parse("ssh://user@host.xz:org/repo.git")
  --     assert_eq(type(actual), "table")
  --     assert_eq(actual.protocol, "ssh")
  --     assert_eq(actual.protocol_pos.start_pos, 1)
  --     assert_eq(actual.protocol_pos.end_pos, 3)
  --     assert_eq(actual.user, "user")
  --     assert_eq(actual.user_pos.start_pos, 9)
  --     assert_eq(actual.user_pos.end_pos, 16)
  --     assert_eq(actual.password, nil)
  --     assert_eq(actual.password_pos, nil)
  --     assert_eq(actual.host, "host.xz")
  --     assert_eq(actual.host_pos.start_pos, 27)
  --     assert_eq(actual.host_pos.end_pos, 39)
  --     assert_eq(actual.org, "org")
  --     assert_eq(actual.org_pos.start_pos, 41)
  --     assert_eq(actual.org_pos.end_pos, 53)
  --     assert_eq(actual.repo, "repo.git")
  --     assert_eq(actual.repo_pos.start_pos, 41)
  --     assert_eq(actual.repo_pos.end_pos, 49)
  --   end)
  --   it("ssh://git@github:linrongbin16/giturlparser.lua.git", function() end)
  -- end)
end)
