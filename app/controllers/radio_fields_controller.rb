class RadioFieldsController < ApplicationController

    def new
    end

    def create
        byebug
    end
    
    def add_radio_option
        @form = Form.find(params[:form_id])
        @obj = nil
        @radio = nil
        if params[:radio_id] == "-1"
            @radio = @form.radio_fields.build
            @obj = @radio.radio_button_options.build
            p "here -1"
        else
            @obj = RadioField.find(params[:radio_id])
            p "here with something"
        end
        byebug
        render( partial: 'radio_button_options/radio_button_options', locals:{ form:@form, radio: @radio, obj: @obj } )
    end

end