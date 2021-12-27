# frozen_string_literal: true

module Api
  module V1
    class BaseController < Api::V1::ApiController
      before_action :find_resource, only: %i[show update destroy]
      before_action :authenticate_user!, only: :create

      ## ------------------------------------------------------------ ##

      # GET : /v2/{resource}
      def index
        data = {
          index_key => collection.as_api_response(index_template, template_injector),
          pagination: pagy_metadata(@pagy)
        }

        yield data if block_given?
        render_success(data: data, message: index_message)
      end

      ## ------------------------------------------------------------ ##

      # GET : /v2/{resource}/:id
      def show
        return render_not_found if resource.nil?

        data = { show_key => resource.as_api_response(show_template, template_injector) }
        yield data if block_given?
        render_success(data: data)
      end

      ## ------------------------------------------------------------ ##

      # POST : /v2/{resource}/:id
      def create
        resource = resource_class.new(params_processed)
        if resource.save
          data = { show_key => resource.as_api_response(show_template, template_injector) }
          render_created(data: data, message: created_message)
        else
          render_unprocessable_entity(message: resource.errors.full_messages.to_sentence)
        end
      end

      ## ------------------------------------------------------------ ##

      # PUT : /v2/{resource}/:id
      def update
        if resource.update(params_processed)
          data = { show_key => resource.as_api_response(show_template, template_injector) }
          # yield data if block_given?
          render_success(data: data, message: updated_message)
        else
          render_unprocessable_entity(message: resource.errors.full_messages.to_sentence)
        end
      end

      ## ------------------------------------------------------------ ##

      # DELETE : /v2/{resource}/:id
      def destroy
        if resource.destroy
          render_success(message: destroyed_message)
        else
          render_unprocessable_entity(message: resource.errors.full_messages.to_sentence)
        end
      end

      ## ------------------------------------------------------------ ##

      private

      def scope
        @scope ||= send(resource_name.pluralize)
      rescue NoMethodError
        resource_class
      end

      def find_resource(resource = nil)
        resource ||= scope.find(id_parameter)
        instance_variable_set("@#{resource_name}", resource)
      rescue ActiveRecord::RecordNotFound
        render_not_found
      end

      def resource
        instance_variable_get("@#{resource_name}")
      end

      def resource_class
        @resource_class ||= resource_name.classify.constantize
      end

      def resource_name
        @resource_name ||= controller_name.singularize
      end

      def resource_params
        @resource_params ||= send("#{resource_name}_params")
      end

      def params_processed
        resource_params
      end

      def collection
        @collection ||= build_collection
      end

      def build_collection(object = nil)
        result = (object || scope)
        result = result.ransack(search_params).result(distinct: true) if search_params.present?
        @pagy, result = pagy(result) if params[:limit] != '-1'
        result = result.order(collection_order) if collection_order.present?
        result
      end

      def search_params
        params[:q]
      end

      def collection_order
        { created_at: :desc }
      end

      def id_parameter
        params[:id]
      end

      def pagination(object)
        {
          current_page:  object.try(:current_page) || 1,
          next_page:     object.try(:next_page),
          previous_page: object.try(:prev_page),
          total_pages:   object.try(:total_pages) || 1,
          per_page:      object.try(:limit_value),
          total_entries: object.try(:total_count) || object.count
        }
      end

      def template_injector
        {}
      end

      def index_key
        resource_name.to_s.pluralize.to_sym
      end

      def show_key
        resource_name.to_s.singularize.to_sym
      end

      def show_template
        :show
      end

      def index_template
        :index
      end

      def index_message
        I18n.t(collection.to_a.size.zero? ? 'no_data_found' : 'data_found')
      end

      %w[created updated].each do |name|
        define_method "#{name}_message" do
          I18n.t("x_#{name}_successfully", name: resource_class.model_name.human)
        end
      end

      def destroyed_message
        I18n.t('x_deleted_successfully', name: resource_class.model_name.human)
      end
    end
  end
end
