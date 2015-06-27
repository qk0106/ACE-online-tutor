class CrawlerController < ApplicationController

	def login_scrape
		#Course.emptyAllCourse		
		#Category.emptyAllCategory
		#Subject.emptyAllSubject
		#Qna.emptyAllQna
		
    #cr = Crawler.new
		#cr.login_and_scrape

		respond_to do |format|
      			format.html {
                        			@result = "Success: Finish Scraping Data"
                		}
     			format.js
      			format.json
  		end
	end

	def courses
		respond_to do |format|
      			format.html {
                        			@courses = Course.all
                		}
     			format.js
      			format.json
  		end
	end	

	def categories	
		respond_to do |format|
      			format.html {
                        			@categories = Category.all
                		}
     			format.js
      			format.json
  		end
	end

	def subjects
		respond_to do |format|
      			format.html {
                        			@subjects = Subject.all
                		}
     			format.js
      			format.json
  		end
	end

	def qnas		
		respond_to do |format|
      			format.html {
                        			@qnas = Qna.all
                		}
     			format.js
      			format.json
  		end
	end

  def course
    id = params[:id]
    course = Course.find_by(id: id)

    respond_to do |format|
      format.html {
        @course = course
        @categories = course.categories
      }
      format.js
      format.json
    end
  end

  def category
    id = params[:id]
    category = Category.find_by(id: id)

    respond_to do |format|
      format.html {
        @category = category
        @subjects = category.subjects
      }
      format.js
      format.json
    end
  end

  def subject
    id = params[:id]
    subject = Subject.find_by(id: id)

    respond_to do |format|
      format.html {
        @subject = subject
        @qnas = subject.qnas
      }
      format.js
      format.json
    end
  end

end
