 @doc.xpath('//pages').children.each do |page|
   page.xpath('tables').children.each do |table|
     table_name = table.xpath('name').text
      puts table_name
      end
      end