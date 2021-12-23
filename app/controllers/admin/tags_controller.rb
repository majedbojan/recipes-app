# frozen_string_literal: true

module Admin
  class TagsController < Admin::BaseController
    before_action :set_tag, only: %i[show edit update destroy]

    # GET /admin/tags
    def index
      @q = Tag.ransack(params[:q])
      @pagy, @tags = pagy(@q.result(distinct: true))
    end

    # GET /admin/tags/1
    def show; end

    # GET /admin/tags/1/edit
    def edit; end

    # PATCH/PUT /admin/tags/1
    def update
      if @tag.update(tag_params)
        redirect_to @tag, notice: 'Tag was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /admin/tags/1
    def destroy
      @tag.destroy
      redirect_to tags_url, notice: 'Tag was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag)
            .permit(
              :key,
              :name,
              :phone,
              :email,
              :grand_total,
              :private_note,
              :status
            )
    end
  end
end
