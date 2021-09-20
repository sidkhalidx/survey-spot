class RadioButtonOptionsController < ApplicationController

    def new
        render(partial: 'radio_button_options/radio_button_options', locals: { obj: RadioButtonOption.new })
    end

    def create
    end

end