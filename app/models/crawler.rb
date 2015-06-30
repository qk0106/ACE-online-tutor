require "uri"
require "net/http"

class Crawler < ActiveRecord::Base
	def initialize username, password, loginPath
		@headers = {
            "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "User-Agent" => "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6",
            "Accept-Encoding" => "gzip, deflate",
            "Connection" => "keep-alive",
            "Accept-Language" => "zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3",
       		}
        @host = "www.online.fbe.unimelb.edu.au"
       	#@loginPath = "/olt/Login.aspx?SCode=FNCE10001_2015_SM1"
        @loginPath = loginPath
		@indexPath = "/olt/Student/CategoryList.aspx"
        @postdata = URI.encode_www_form(
            "__EVENTTARGET" => "",
            "__EVENTARGUMENT" => "",
            "__VIEWSTATE" => "/wEPDwUKLTk4MDAzMTg4OGQYAQUeX19Db250cm9sc1JlcXVpcmVQb3N0QmFja0tleV9fFgEFImN0bDAwJENvbnRlbnRQbGFjZUhvbGRlcjEkYnRuTG9naW5vsUdSsr1ixiUBI8b17ZazyodJLg==",
            "__VIEWSTATEGENERATOR" => "6E31D086",
            "__EVENTVALIDATION" => "/wEWBwK6mtCPCwLJ4frZBwL90KKTCALir9vMBQLU5MXpDgKjxIGjAQKO9e+RAXAg905Ij1Jdo/DwyteK5fCrLw8Z",
            #"ctl00$ContentPlaceHolder1$txtUsername" => "xiaoxuw",
            "ctl00$ContentPlaceHolder1$txtUsername" => username,
            #"ctl00$ContentPlaceHolder1$txtPassword" => "Wxx19950914",
            "ctl00$ContentPlaceHolder1$txtPassword" => password,
            "ctl00$ContentPlaceHolder1$ddDomain" => "STUDENT.UNIMELB.EDU.AU",
            "ctl00$ContentPlaceHolder1$btnLogin.x" => "45",
            "ctl00$ContentPlaceHolder1$btnLogin.y" => "18"
            )
	end

    def login_and_scrape
        http = Net::HTTP.new(@host, 443)
        http.use_ssl = true
        resp = http.post(@loginPath, @postdata, @headers)
        #p resp.code
        if (resp.code == '302')
            all_cookies = resp.get_fields('set-cookie')
            cookies_array = Array.new
            all_cookies.each { |cookie|
                cookies_array.push(cookie.split('; ')[0])
                }
            cookies = cookies_array.join('; ')
            resp_index = http.get(@indexPath, { 'Cookie' => cookies })
            body = resp_index.body

            course_id = Course.abstractCourse(body)

            Category.abstractCategory(course_id, body, http, cookies)
        else 
            puts "--!--Error: login fail !"
        end                
    end

end
