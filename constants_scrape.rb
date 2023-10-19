require 'mechanize'
require 'json'

agent = Mechanize.new

targetsUrl = [  
    "https://beachclub.constantcontactsites.com/",
    "https://the-kitchen.constantcontactsites.com/",
    "https://velvet-bar.constantcontactsites.com/",
    "https://gelateria.constantcontactsites.com/",
    "https://mama-dellas-ristorante.constantcontactsites.com/",
    "https://sals-market-deli.constantcontactsites.com/",
    "https://the-thirsty-fish.constantcontactsites.com/",
    "https://trattoria-del-porto.constantcontactsites.com/",
    "https://bula-bar-and-grille.constantcontactsites.com/",
    "https://islands-dining-room.constantcontactsites.com/",
    "https://jakes-american-bar.constantcontactsites.com/",
    "https://orchid-court-lounge.constantcontactsites.com/",
    "https://amatista-cookhouse.constantcontactsites.com/",
    "https://drhum-club-kantine.constantcontactsites.com/",
    "https://strong-water-tavern.constantcontactsites.com/",
    "https://bar-17-bistro.constantcontactsites.com/",
    "https://urban-pantry.constantcontactsites.com/",
    "https://atomic-tonic.constantcontactsites.com/",
    "https://bayliner-diner.constantcontactsites.com/",
    "https://galaxy-bowl-restaurant.constantcontactsites.com/",
    "https://the-hideaway-bar-and-grill.constantcontactsites.com/",
    "https://shakes-malt-shoppe.constantcontactsites.com/",
    "https://swizzle-lounge.constantcontactsites.com/",
    "https://beach-break-cafe.constantcontactsites.com/",
    "https://sand-bar.constantcontactsites.com/",
    "https://pier-8-market.constantcontactsites.com/"
]

save_file_path = "#{Dir.pwd}/constants.txt"
file = File.open(save_file_path, 'w')

for tar_url in targetsUrl do
    page = agent.get(tar_url)
    sections = page.search('section')[1]
    RestaurantName = sections.search('.kv-ee-section-title.kv-ee-title.kv-ee-section-title--md').text.strip
    subUrls = sections.search('.kv-ee-button-md.kv-ee-move-button.kv-ee-button-dynamic-buttons.kv-button-instant-edit.kv-ee-button-primary')
    for a_tag in subUrls do
        href = a_tag['data-href']
        if href.include?('https://')
            next
        end
        targetObj = {
            "RestaurantName" => RestaurantName,
            "MenuName" => a_tag.text.strip,
            "ItemGroup" => [],
            "IsForKids" => false,
            "IsSpicy" => false,
            "IsVegetarian" => false,
            "IsVegan" => false,
        }
        subpage = agent.get("#{tar_url}#{href}");
        menusections = subpage.search('section')
        menusections.each_with_index do |menusection, index|
            next if index < 2
            submenusection = menusection.search('.kv-ee-container.kv-ee-menu-content')
            next if submenusection.length == 0
            tempMenus = {
                "Items" => []
            }
            tempMenus['GroupName'] = submenusection.search('.kv-ee-section-title.kv-ee-section-title--md').text.strip
            items = submenusection.search('.kv-ee-pricelist-item')
            for item in items do
                tempItems = {}
                tempItems['ItemName'] = item.search('.kv-ee-title').search('b').text.strip
                tempItems['ItemPrice'] = item.search('.kv-ee-price').text.strip
                tempItems['ItemDescription'] = item.search('.kv-ee-description').text.strip
                trueoptions = item.search('font')
                if trueoptions
                    options = trueoptions.text.strip
                    tempItems['IsVegetarian'] = true if options.include?('VEGETARIAN')
                    tempItems['IsVegan'] = true if options.include?('VEGAN')
                end
                tempMenus['Items'].push(tempItems)
            end
            targetObj['ItemGroup'].push(tempMenus)
        end
        file.write("#{tar_url}#{href}\n")
        file.write(targetObj)
        file.write("\n\n")
    end
end

file.close