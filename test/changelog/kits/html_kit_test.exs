defmodule Changelog.HtmlKitTest do
  use ExUnit.Case

  alias Changelog.HtmlKit

  describe "get_title/1" do
    test "defaults to empty string" do
      assert HtmlKit.get_title(nil) == ""
      assert HtmlKit.get_title("") == ""
    end

    test "when title tag has attrs" do
      html = ~s{<title itemprop='name'>October's Best Gear</title>}
      assert HtmlKit.get_title(html) == "October's Best Gear"
    end

    test "when newlines are a thing" do
      html = """
      <head>
      <meta charset="utf-8">
      <title>
      GraphQL + Relay Modern + Rails //
      Collective Idea
      | Crafting web and mobile software based in Holland, Michigan
      </title>
      """

      assert HtmlKit.get_title(html) == "GraphQL + Relay Modern + Rails //"
    end

    test "when there are multiple title tags" do
      html =
        "<title>Are holograms the future of how we capture memories?</title><title>Part Deux</title."

      assert HtmlKit.get_title(html) == "Are holograms the future of how we capture memories?"
    end
  end

  describe "get_images/1" do
    test "defaults to empty list" do
      assert HtmlKit.get_images(nil) == []
    end

    test "returns empty list when there aren't any" do
      html = "<html><body><h1>O'DOYLE RULES</h1></body></html>"
      assert HtmlKit.get_images(html) == []
    end

    test "returns a single image source when there's just one" do
      html = """
      <html>
        <body>
          <h1>O'DOYLE RULES</h1><p><img name="ohai" src="/test/example.jpg"></p>
        </body>
      </html>
      """

      assert HtmlKit.get_images(html) == ["/test/example.jpg"]
    end

    test "returns multiple image sources when there are a bunch" do
      html = """
      <img name="ohai" src="/test/example.jpg">
      <img src="http://example.com/test.png">
      <img src="https://blech.com/test.svg">
      <img class=crazy src=/blech/test.png>
      """

      assert HtmlKit.get_images(html) == [
               "/test/example.jpg",
               "http://example.com/test.png",
               "https://blech.com/test.svg",
               "/blech/test.png"
             ]
    end
  end

  describe "put_no_follow/1" do
    test "does nothing if there are no anchors" do
      assert HtmlKit.put_no_follow("<html></html>") == "<html></html>"
    end

    test "it adds rel=nofollow to a single anchor" do
      a = ~s(<div><h1><a href="test.com">ohai</a></h1></div>)
      b = ~s(<div><h1><a rel="nofollow" href="test.com">ohai</a></h1></div>)
      assert HtmlKit.put_no_follow(a) == b
    end

    test "it adds rel=nofollow to multiple anchors" do
      a = ~s(<a href="">ohai there</a>  <a href="">obai there</a>)
      b = ~s(<a rel="nofollow" href="">ohai there</a><a rel="nofollow" href="">obai there</a>)
      assert HtmlKit.put_no_follow(a) == b
    end
  end
end
