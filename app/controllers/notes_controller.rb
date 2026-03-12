class NotesController < ApplicationController
  def index
    # if params[:search]
    #   notes = Note.where("title ILIKE ?", "%#{params[:search]}%")
    # else
    #   notes = Note.all
    # end
    page = params[:page] || 1
    per_page = 5

    notes = Note.page(page).per(per_page)

    render json: {
      status: "success",
      page: page,
      per_page: per_page,
      total_pages: notes.total_pages,
      total_count: notes.total_count,
      data: notes
    }
  end

  def show
    note = Note.find(params[:id])
    render json: {
      status: "success",
      data: note
    }, status: :ok
  end

  def create
    note = Note.create(note_params)

    if note.save
      render json: {
        status: "success",
        data: note
      }, status: :created
    else
      render json: {
        status: "error",
        errors: note.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    note = Note.find(params[:id])
    note.update(note_params)
    render json: note
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    render json: { message: "Note deleted successfully" }
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
