class Rails::ItemGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  
  argument :model, :type => :string, :default => "model"
  argument :attrs, :type => :array, :default => []
  class_option :label, :aliases => '-l', :type => :array, :default => []
  #class_option :stylesheet, :type => :boolean, :default => "true", :description => "test class_options"
  #class_option :stylesheet, :type => :boolean, :default => "true", :description => "test class_options"
  #model_singularize = model.singularize.underscore
  #class_option :model_singularize, :type => :string, :default => model_singularize
  #class_option :model_pluralize, :type => :string, :default => model_pluralize
  def generate_model
    attributes = attrs.join(" ")
    generate "model", "#{model} #{attributes}"
  end

  def generate_setting
    model_name = model.pluralize.underscore
    hash = Hash.new
    attrs.each_with_index do |attr, index|
      key = attr.slice(/([^:]+)/)
      hash[key] = options[:label][index]
    end
    Setting.save(model_name, hash)
  end

  def generate_controller
    #generate "controller", "#{controller_name}"
    template 'controller.template', "app/controllers/#{controller_name}_controller.rb"
    template 'index.template', "app/views/#{controller_name}/index.html.haml"
  end

  private
  def file_name
    model.underscore
  end

  def controller_name
    model.downcase.pluralize
  end
end
