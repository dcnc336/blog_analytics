require 'mechanize'
require 'json'

agent = Mechanize.new

targetsUrl = [  
    'https://www.thepalm.com/location/the-palm-orlando/'
]

save_file_path = "#{Dir.pwd}/separate.txt"
file = File.open(save_file_path, 'w')

for tar_url in targetsUrl do
    page = agent.get(tar_url)
    sections = page.search('.tabs-panel')
    targetObj = {
        "RestaurantName" => RestaurantName,
        "MenuName" => a_tag.text.strip,
        "ItemGroup" => [],
        "IsForKids" => false,
        "IsSpicy" => false,
        "IsVegetarian" => false,
        "IsVegan" => false,
    }
    for section in sections do
        
    end
    file.write("#{tar_url}\n")
    file.write(targetObj)
    file.write("\n\n")
end

file.close