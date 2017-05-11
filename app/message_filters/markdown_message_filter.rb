require 'rouge/plugins/redcarpet'

class MarkdownMessageFilter < ApplicationMessageFilter
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def emphasis(text)
      nil
    end

  end

  def self.filter(text)
    extensions = {
      no_infra_emphasis: true,
      tables: false,
      fenced_code_blocks: true,
      autolink: true,
      disable_indented_code_blocks: true,
      strikethrough: false,
      lax_spacing: true,
      space_after_headers: true,
      superscript: false,
      underline: false,
      highlight: false,
      quote: false,
      footnotes: false,
      with_toc_data: false,
      head_wrap: true,
      xhtml: false,
      pretty: false,
    }
    renderer = HTML.new(
      filter_html: false,
      escape_html: true,
      no_images: false,
      no_links: false,
      no_styles: true,
      hard_wrap: true,
      link_attributes: {
        target: '_blank'
      }
    )
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text)
  end
end
