class TextAreasController < ApplicationController
    def new
        @text_area = TextArea.new
        render( partial: 'text_areas/text_area', locals: { text_area: @text_area })
    end
    def create
        @form = Form.find(params[:form_id])
        @form.text_areas.create(params.require(:text_area).permit(:title, :is_required))
    end
    def update
        @text_area = TextArea.find(params[:id])
        @text_area.update(params.require(:text_area).permit(:title, :is_required))
    end
end