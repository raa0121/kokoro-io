class MarkdownMessageFilter < ApplicationMessageFilter
  def self.filter(text)
    extensions = {
      no_infra_emphasis: true,
      autolink: true,
      disable_indented_code_blocks: true,
      strikethrough: false,
      lax_spacing: true,
      underline: true,
      highlight: true,
      quote: true,
      footnotes: false,
    }
    renderer = Redcarpet::Render::HTML.new(
      filter_html: false,
      escape_html: false,
      no_images: false,
      no_links: true,
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
