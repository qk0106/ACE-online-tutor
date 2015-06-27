class Course < ActiveRecord::Base
	has_many :categories

	def self.emptyAllCourse
    	Course.all.each {|c| c.destroy}
    end

	def self.abstractCourse(body)
        reg_code = /<h1>Category List \(([\w\_]*)\)<\/h1>/
     	code = body.scan(reg_code)[0][0]

     	c = Course.new
     	c.code = code
     	c.save

        return c.id
	end

end
