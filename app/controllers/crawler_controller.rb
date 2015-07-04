class CrawlerController < ApplicationController

	def scrape
=begin
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
    
    #hongw1
    hong1 = Crawler.new("hongw1", "Wh03221994", "/olt/Login.aspx?scode=FNCE30002_2015_SM1")
    hong1.login_and_scrape
   
    #ziyunl
    zi1 = Crawler.new("ziyunl", "Ellen19950504", "/olt/Login.aspx?scode=ECOM30001_2015_SM1")
    zi1.login_and_scrape

    #--- CLOSED!!!
    #zi2 = Crawler.new("ziyunl", "Ellen19950504", "/olt/Login.aspx?scode=ECOM90001_2015_SM1")
    #zi2.login_and_scrape

    #--- CLOSED!!!
    #zi3 = Crawler.new("ziyunl", "Ellen19950504", "/olt/Login.aspx?scode=MGMT10002_2015_SUM")
    #zi3.login_and_scrape

    zi4 = Crawler.new("ziyunl", "Ellen19950504", "/olt/Login.aspx?scode=MGMT30011_2015_SM1")
    zi4.login_and_scrape

    #zhuojingx
    zhuo1 = Crawler.new("zhuojingx", "Xiaoxie521", "/olt/Login.aspx?scode=ECON20002_2015_SM1")
    zhuo1.login_and_scrape

    #peishanl
    pei1 = Crawler.new("peishanl", "leona333", "/olt/Login.aspx?scode=FNCE30007_2015_SM1")
    pei1.login_and_scrape
=end

    #add qnaadd to every qna
=begin
    Qna.all.each do |qna|
      q = Qnaadd.new
      q.question = qna.question
      q.answer = qna.answer
      q.qna_id = qna.id
      q.save
    end
=end

    #---html---
		respond_to do |format|
      			format.html {
                        			#@result = "Success: Finish Scraping Data"
                              @result = "Scrape Service Closed"
                              #@result = "Qnaadd save sucess!"
                		}
     			  format.js
      			format.json
  	end
	end

  def deleteall

    #Course.emptyAllCourse    
    #Category.emptyAllCategory
    #Subject.emptyAllSubject
    #Qna.emptyAllQna

    respond_to do |format|
            format.html {
                              #@result = "Success: Delete All Data"
                              @result = "Delete Service Closed"
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
        @qna = subject.qnas[0]
        @qnaadd = subject.qnas[0].qnaadds[0]
      }
      format.js
      format.json
    end
  end

  def translate    
    question_translate = params[:question_translate]
    answer_translate = params[:answer_translate]
    tags = params[:tags]
    qnaadd_id = params[:id]

    q = Qnaadd.find_by(id: qnaadd_id)

    if question_translate != nil       
      q.question = question_translate[:text]
      q.save
    elsif answer_translate != nil
      q.answer = answer_translate[:text]
      q.save
    elsif tags != nil
      q.tag = tags[:text]
      q.save
    else
      puts "~~~ERROR!"
    end

    respond_to do |format|
      format.html {
        redirect_to(:back)
      }
      format.js
      format.json
    end
  end

end
