class CrawlerController < ApplicationController

	def scrape

    # xiaoxuW
    xxw1 = Crawler.new("xiaoxuw", "Wxx19950914", "/olt/Login.aspx?SCode=FNCE10001_2015_SM1")
		xxw1.login_and_scrape


    xxw2 = Crawler.new("xiaoxuw", "Wxx19950914", "/olt/Login.aspx?scode=ECON10004_2015_SM1")
    xxw2.login_and_scrape

    #--- CLOSED!!!
    #---xxw4 = Crawler.new("xiaoxuw", "Wxx19950914", "/olt/Login.aspx?scode=ECON10005_2015_SM1")
    #---xxw4.login_and_scrape

    # ye2
    ye3 = Crawler.new("ye2", "66335582leAF", "/olt/Login.aspx?scode=ECON10003_2015_SM1")
    ye3.login_and_scrape

    ye4 = Crawler.new("ye2", "66335582leAF", "/olt/Login.aspx?scode=ECON20003_2015_SM1")
    ye4.login_and_scrape

    # yuweiz1
    yu1 = Crawler.new("yuweiz1", "zhang96yu05wei02", "/olt/login.aspx?scode=FNCE20001_2015_SM1")
    yu1.login_and_scrape

    yu3 = Crawler.new("yuweiz1", "zhang96yu05wei02", "/olt/Login.aspx?scode=ECON20002_2015_SM1")
    yu3.login_and_scrape
    
    yu4 = Crawler.new("yuweiz1", "zhang96yu05wei02", "/olt/Login.aspx?scode=ECOM20001_2015_SM1")
    yu4.login_and_scrape

    #tongxij

    #luhengl
    lu4 = Crawler.new("luhengl", "Hahahaha.", "/olt/Login.aspx?scode=MGMT20001_2015_SM1")
    lu4.login_and_scrape

		respond_to do |format|
      			format.html {
                        			@result = "Success: Finish Scraping Data"
                		}
     			  format.js
      			format.json
  	end
	end

  def deleteall
    Course.emptyAllCourse    
    Category.emptyAllCategory
    Subject.emptyAllSubject
    Qna.emptyAllQna

    respond_to do |format|
            format.html {
                              @result = "Success: Delete All Data"
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
