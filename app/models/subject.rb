require "uri"
require "net/http"

class Subject < ActiveRecord::Base
	has_many :qnas
	belongs_to :category

	def self.emptyAllSubject
                        	Subject.all.each {|s| s.destroy}
                end

                def self.abstractSubject(category_id, relative_url, http, cookies)
                	path = "/olt/Student/"+relative_url
                	resp_index = http.get(path, { 'Cookie' => cookies })
                                body = resp_index.body

               		reg_table = /<table class="table-dynamic table-small" cellspacing="0">([\s\S]*)<\/table>/
                                #reg_element = /<td><a title="View Details" href="[\w\.\?\=\&\%\+]*"><span class="[\w]*">([\w\s\:]*)/
                                reg_element = /<td><a title="View Details" href="[\w\.\?\=\&\%\+]*"><span class="[\w]*">([\w\s\,\.\?\"\'\!\@\#\$\%\^\&\*\(\)\[\]\{\}\|\\\:\;\/\-\_\=\+]*)/
                                reg_href = /<td><a title="View Details" href="([\w\.\?\=\&\%\+]*)"><span class="[\w]*">[\w\s\:]*/
                                                
                                table = body.scan(reg_table)[0][0]
                                hrefs =  table.scan(reg_href)
                                all_elements = table.scan(reg_element)

                                posts                         = getSubjectElements(all_elements,0)
                                names                       = getSubjectElements(all_elements,1)
                                posted_dates          = getSubjectElements(all_elements,2)
                                answered_dates     = getSubjectElements(all_elements,3)
                                answered_bys         = getSubjectElements(all_elements,4)
                                urls 		     = getSubjectElements(hrefs,0)
                                #puts posts.length, names.length, posted_dates.length, answered_dates.length, answered_bys.length

                                names.length.times do |x|
		                s = Subject.new
		                s.post = posts[x]
		                s.name = names[x]
		                s.posted_date = posted_dates[x]
		                s.answered_date = answered_dates[x]
		                s.answered_by = answered_bys[x]
		                s.category_id = category_id
		                s.save
		end

        subjects = Category.find_by(id: category_id).subjects
		names.length.times do |x|
			subject_id = subjects[x].id
			relative_url = urls[x]
			#if x == 0 || x == 1 || x == 2
				Qna.abstractQna(subject_id, relative_url, http, cookies)
			#end
		end
                end

                def self.getSubjectElements(elements, init)                                
                                index = init
                                arr = []
                                while(true)
                                                arr << elements[index][0]
                                                index+= 5
                                                break if(index > (elements.length - 1))
                                end
                                return arr                                                
                end
end
