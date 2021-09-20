class TextFieldsController < ApplicationController
    
    def new
        @text_field = TextField.new
        p 'here'
        render( partial: 'text_fields/text_field', locals: { text_field: @text_field })
        
    end

    def create
        @form = Form.find(params[:form_id])
        @form.text_fields.create(params.require(:text_field).permit(:title, :is_required))
    end

    def edit
    end

    def update
        @text_field = TextField.find(params[:id])
        @text_field.update(params.require(:text_field).permit(:title, :is_required))
    end

end