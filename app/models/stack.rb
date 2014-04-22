class Stack < ActiveRecord::Base
  has_many :users, through: :user_stacks
  has_many :user_stacks

  has_many :cards
  belongs_to :owner, class_name: "User"

  validates :name, :presence => true

  def emptycards
    self.cards.each do |card|
      Recall.where("card_id = #{card.id}").each do |recall|
        recall.destroy
      end
      card.destroy
    end
  end

  #get all recalls that pertain to a user
  def get_recalls(user)
    #join the Recall table with the stack table through card_id
    # Recall.where("user_id = #{@user.id} and ")
  end

  def self.parseGist(url)
    combinationid = url.match(%r[(?<=(https:\/\/gist.github.com\/)).*]).to_s
    user = combinationid.split("/").first
    id = combinationid.split("/").last
    request = %Q[https://gist.githubusercontent.com/#{user}/#{id}/raw]
  
    raw = Net::HTTP.get_response(URI.parse(request))
    text = raw.body.split("~~")
    title = ""
    while (title.length <= 0)
      title =text.shift
    end
    title = title.strip
    s = Stack.create(name: title)
    text.map!{|t| t.split(%r[~Answer:])}

    text.each do |val|
      s.cards.build(question: val[0].gsub("Question:","").strip , answer: val[1].strip)
    end
    s.save
    s
  end
end
