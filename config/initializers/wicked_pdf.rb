WickedPdf.config do |config|  
  	if Rails.env == 'production' then
    	config.exe_path = Rails.root.to_s + "/bin/wkhtmltopdf-amd64"
  	else 
    	config.exe_path = '/usr/local/bin/wkhtmltopdf'
  	end
end