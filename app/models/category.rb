class Category < ActiveRecord::Base
	has_many :subjects
	belongs_to :course

	def self.emptyAllCategory
        Category.all.each {|c| c.destroy}
    end

    def self.abstractCategory(course_id, body, http, cookies)
        reg_table = /<h2>SUBJECT CATEGORIES<\/h2>\s*<table class="table-dynamic table-small" cellspacing="0">([\s\S]*)<\/table>\s*<div class="spacer2">/
		reg_element = /<td><a title="View questions and answers" href="[\w\.\?\=]*">([\w\s\:]*)/
		reg_href = /<td><a title="View questions and answers" href="([\w\.\?\=]*)">[\w\s\:]*/

		table = body.scan(reg_table)[0][0] #puts table[0][0].class
		hrefs =  table.scan(reg_href)		
		all_elements = table.scan(reg_element)

		names 		= getCategoryElements(all_elements,0)
		posts 		= getCategoryElements(all_elements,1)
		last_updates 	= getCategoryElements(all_elements,2)
		urls 		= getCategoryElements(hrefs,0)
		#puts names.length, posts.length, last_updates.length

		names.length.times do |x|
		                c = Category.new
		                c.name = names[x]
		                c.posts = posts[x]
		                c.last_updated = last_updates[x]
		                c.course_id = course_id
		                c.save
		end

		categories = Course.find_by(id: course_id).categories
		names.length.times do |x|
			category_id = categories[x].id
			relative_url = urls[x]
			#if x == 0 || x == 1
				Subject.abstractSubject(category_id, relative_url, http, cookies)
			#end
		end
    end

    def self.getCategoryElements(elements, init)
                	index = init
                                arr = []
                                while(true)
                                                arr << elements[index][0]
                                                index+=3
                                                break if(index > (elements.length - 1))
                                end
                                return arr                                                
    end
end
