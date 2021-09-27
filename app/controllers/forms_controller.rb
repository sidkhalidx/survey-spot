class FormsController < ApplicationController

    def new
        @form = Form.new
    end

    def create
        @form = Form.new(form_params)
        byebug
        @form.save
    end
    
    def edit
        @form = Form.find(params[:id])
    end

    def update
        @form = Form.find(params[:id])
        @form.update(form_params)
    end
    def form_params
        params.require(:form).permit(:title, fields_attributes: [:id, :field_type, :title, :is_required, field_options_attributes: [:id, :label]])
    end
end

 # def add_new_field
    #     byebug
    #     # @form_fields = {
    #     #     'Text Field': { partial: 'text_fields/text_field', model: @form.text_fields.build },
    #     #     'Text Area': { partial: 'text_areas/text_area', model: @form.text_areas.build },
    #     #     'Radio Field': { partial: 'radio_fields/radio_field', model: @form.radio_fields.build }
    #     # }
    #     # temp = @form_fields[params[:type].to_sym]
    #     # render inline: "<%= link_to_add_association 'add field', f, :fields, render_options: { locals: { options: true } }, id:'add_field', class:'btn btn-primary m-2' %>"
    #     render inline: "<%= link_to 'new', new_form_path %>"
        
    # end