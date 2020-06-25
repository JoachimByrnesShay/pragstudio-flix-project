class MakeReviewsAJoinTableStep2 < ActiveRecord::Migration[6.0]
  def change
  	Review.all.each do |r|
  		u = User.find_by(name: r.name)
  		r.user_id = u.id 
  		r.save
  	end
  	remove_column :reviews, :name, :string
  end
end
