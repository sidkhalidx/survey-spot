class FormsController < ApplicationController

    def new
        @form = Form.new
    end

    def create
        @form = Form.new(params.require(:form).permit(:title))
        @form.save
        redirect_to edit_form_path(@form)
    end

    def edit
        @form = Form.find(params[:id])
        @field_types = {
            TextField: { partial: 'text_fields/text_field' },
            TextArea: { partial: 'text_areas/text_area' },
            RadioField: { partial: 'radio_fields/radio_field' }
        }
        @form_fields = []
        @form.text_areas.each { |field| @form_fields << field }
        @form.text_fields.each { |field| @form_fields << field }
    end

    def update
        @form = Form.find(params[:id])
        @form.update(params.require(:form).permit(:title))
    end

    def add_new_field
        @form = Form.find(params[:id])
        @form_fields = {
            'Text Field': { partial: 'text_fields/text_field', model: @form.text_fields.build },
            'Text Area': { partial: 'text_areas/text_area', model: @form.text_areas.build },
            'Radio Field': { partial: 'radio_fields/radio_field', model: @form.radio_fields.build }
        }
        temp = @form_fields[params[:type].to_sym]
        render( partial: temp[:partial], locals: { parent: @form, obj: temp[:model] })
    end

end