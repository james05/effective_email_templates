module Admin
  class EmailTemplatesController < ApplicationController
    

    layout (EffectiveEmailTemplates.layout.kind_of?(Hash) ? EffectiveEmailTemplates.layout[:admin_email_templates] : EffectiveEmailTemplates.layout)

    def index
      EffectiveEmailTemplates.authorized?(self, :index, Effective::EmailTemplate)
      raise Effective::EmailTemplate.all.inspect
 
      @page_title = 'Manage Email Templates'
      @datatable = Effective::Datatables::EmailTemplates.new() if defined?(EffectiveDatatables)
      @page_title = 'Email Templates'
    end

    def new
      @email_template = Effective::EmailTemplate.new
      EffectiveEmailTemplates.authorized?(self, :new, @email_template)

      @page_title = 'New Email Template'
    end

    def create
      @email_template = Effective::EmailTemplate.new(email_template_params)
      EffectiveEmailTemplates.authorized?(self, :create, @email_template)

      if @email_template.save
        flash[:success] = "Email template created successfully"
        redirect_to effective_email_templates.admin_email_templates_path
      else
        flash.now[:error] = "Could not create email template"
        @page_title = 'New Email Template'
        render :new
      end
    end

    def edit
      @email_template = Effective::EmailTemplate.find(params[:id])
      EffectiveEmailTemplates.authorized?(self, :edit, @email_template)

      @page_title = 'Edit Email Template'
    end

    def update
      @email_template = Effective::EmailTemplate.find(params[:id])
      EffectiveEmailTemplates.authorized?(self, :update, @email_template)

      if @email_template.update(email_template_params)
        flash[:success] = "Email template updated successfully"
        redirect_to effective_email_templates.admin_email_templates_path
      else
        flash.now[:error] = "Could not update email template"
        @page_title = 'Edit Email Template'
        render :edit
      end
    end

    private

    def email_template_params
      params.require(:effective_email_template).permit([ :from, :cc, :bcc, :subject, :body ])
    end
  end
end
