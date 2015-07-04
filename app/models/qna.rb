class Qna < ActiveRecord::Base
    has_many :qnaadds
	belongs_to :subject

	def self.emptyAllQna
                        	Qna.all.each {|q| q.destroy}
                end

	def self.abstractQna(subject_id, relative_url, http, cookies)
		                        path = "/olt/Student/"+relative_url
                	            resp_index = http.get(path, { 'Cookie' => cookies })
                                body = resp_index.body

                                reg_answered_by = /<td><label><b>Answered By:<\/b>\s*<\/label> ([\w\s\,\.\?\"\'\!\@\#\$\%\^\&\*\(\)\[\]\{\}\|\\\:\;\/\-\_\=\+]*)<\/td>/ 
                                reg_date_answered = /<td><label><b>Date Answered:<\/b>\s*<\/label> ([\w\s\:]*)<\/td>/
                                reg_date_post = /<td><label><b>Date Posted:<\/b>\s*<\/label> ([\w\s\:]*)<\/td>/
                                reg_question = /<th>Question<\/th>\s*<\/tr>\s*<tr>\s*<td>([\w\W]*)<\/td>\s*<\/tr>\s*<\/table>\s*<table class="table-dynamic table-small" cellspacing="0">/
                                reg_answer = /<th>Answer<\/th>\s*<\/tr>\s*<tr>\s*<td>([\s\S]*)<\/td>/

                                answered_by = body.scan(reg_answered_by)
                                date_answered = body.scan(reg_date_answered)
                                date_post =  body.scan(reg_date_post)
                                question = body.scan(reg_question)
                                answer = body.scan(reg_answer)

                               #puts "~~~~~~~~~~~~", answered_by[0][0], date_answered[0][0], date_post[0][0], question[0][0], answer[0][0]

                                q = Qna.new
                                q.question = question[0][0].encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '_')
                                q.answer = answer[0][0].encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '_')
                                q.answered_by = answered_by[0][0]
                                q.date_answered = date_answered[0][0]
                                q.date_post = date_post[0][0]
                                q.subject_id = subject_id
                                q.save
	end
end
