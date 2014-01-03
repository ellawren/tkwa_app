module DataRecordsHelper

    def year_array(all_records)
        year_array = [] 
        all_records.each do |record| 
            year_array.push(record.year) 
        end 
        
        year_list = [] 
        year_array.uniq.each do |year| 
           year_list.push(year) 
        end 
        year_list.reverse!
    end

end