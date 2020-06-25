class MakeReviewsAJoinTableStep1 < ActiveRecord::Migration[6.0]
  def change
  	Review.all.each do |r|
  		u = User.all.sample
  		r.name = u.name
  		r.save
  	end
  	add_column :reviews, :user_id, :integer
  end
end
