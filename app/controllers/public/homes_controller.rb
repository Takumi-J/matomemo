class Public::HomesController < ApplicationController
  def top
    @work_sumples = Work.order('created_at DESC').limit(4)
    @work_review_sumples = Work.order('updated_at DESC').limit(4)
  end

  def about
  end
end
