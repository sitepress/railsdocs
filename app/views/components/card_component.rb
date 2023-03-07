# frozen_string_literal: true

class CardComponent < ApplicationComponent
  def initialize(title:, href: nil)
    @title = title
    @href = href
  end

  def template(&)
    if @href
      a(href: @href) do
        card_template(&)
      end
    else
      card_template(&)
    end
  end

  def card_template
    div(class: "shadow-lg p-8 hover:scale-110 transition hover:shadow-xl2 border rounded flex flex-col gap-5") do
      h3(class: "text-lg font-bold") { @title }
      yield
    end
  end
end
