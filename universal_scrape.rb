require 'mechanize'
require 'json'

agent = Mechanize.new

targetsUrl = [
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/cafe-la-bamba/lunch-menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/flaming-moes/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/luigis-pizza/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/krusty-burger/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/the-frying-dutchman/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/florean-fortescues-ice-cream-parlour/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/kidzone-pizza-company/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/leaky-cauldron/breakfast-menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/leaky-cauldron/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/louies-italian-restaurant/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/mels-drive-in/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/richters-burger-co/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/san-francisco-pastry-company/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/schwabs-pharmacy/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/today-cafe/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/finnegans-bar-grill/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/finnegans-bar-grill/drink-menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/finnegans-bar-grill/dessert-menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/finnegans-bar-grill/kids-menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/lombards-seafood-grille/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/lombards-seafood-grille/kids-menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/lombards-seafood-grille/dessert-menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/lombards-seafood-grille/drink-menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/bumblebee-mans-taco-truck/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/the-fountain-of-fair-fortune/menu-drink.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/the-hopping-pot/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/blondies/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/the-burger-digs/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/cafe-4/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/captain-america-diner/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/cinnabon-ioa/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/circus-mcgurkus-cafe-stoo-pendous/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/comic-strip-cafe/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/croissant-moon-bakery/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/doc-sugrues-desert-kebab-house/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/fire-eaters-grill/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/green-eggs-and-ham-cafe/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/hop-on-pop-ice-cream-shop/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/moose-juice-goose-juice/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/pizza-predattoria/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/three-broomsticks/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/thunder-falls-terrace/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/the-watering-hole/Menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/wimpys/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/confisco-grille/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/confisco-grille/kids_menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/confisco-grille/dessert_menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/confisco-grille/drink_menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/confisco-grille/navigators-club-menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/mythos-restaurant/menu.html',
    'https://www.universalorlando.com/webdata/k2/en/us/things-to-do/dining/mythos-restaurant/kids-menu.html'
]

save_file_path = "#{Dir.pwd}/universal.txt"
file = File.open(save_file_path, 'w')
for tar_url in targetsUrl do
    page = agent.get(tar_url)
    Jsonbody = JSON.parse(page.body)['ComponentPresentations']
    targetObj = {
        "RestaurantName" => "",
        "MenuName" => "",
        "ItemGroup" => [],
        "IsVegetarian" => false,
        "IsVegan" => false,
    }
    for component in Jsonbody do
        fields = component['Component']['Fields']
        next if fields.empty?
        if fields['PageTitle']
            targetObj['RestaurantName'] = fields['PageTitle']['Values'][0]
        elsif fields['Heading'] && fields['SectionType']
            targetObj['MenuName'] = fields['Heading']['Values'][0]
        elsif fields['MenuDetails']
            menus = fields['MenuDetails']['EmbeddedValues']
            tempItemGroup = []
            for submenus in menus do
                tempMenus = {
                    "Items" => []
                }
                next if submenus['DishDetails'].nil?
                tempMenus['GroupName'] = submenus['Subheading']['Values'][0] if submenus['Subheading']
                for items in submenus['DishDetails']['EmbeddedValues'] do
                    tempItems = {}
                    next if items['Title'].nil?
                    tempItems['ItemName'] = items['Title']['Values'][0]
                    tempItems['ItemPrice'] = items['Price']['Values'][0] if items['Price']
                    tempItems['ItemDescription'] = items['Description']['Values'][0] if items['Description']
                    if items['Alcoholic']
                        if items['Alcoholic']['Values'][0] == 'No'
                            tempItems['ContainsAlcohol'] = false
                        elsif items['Alcoholic']['Values'][0] == 'Yes'
                            tempItems['ContainsAlcohol'] = true
                        end
                    end
                    tempItems['AllergyCodesArray'] = items['HealthAttribute']['Values'] if items['HealthAttribute']
                    tempItems['CourseCode'] = submenus['Subheading']['Values'][0] if submenus['Subheading']
                    tempMenus['Items'].push(tempItems)
                end
                tempItemGroup.push(tempMenus)
            end
            targetObj['ItemGroup'].push(tempItemGroup)
        elsif fields['Attributes']
            for attribute in fields['Attributes']['Values'] do
                if attribute.include?('V-')
                    targetObj['IsVegetarian'] = true
                elsif attribute.include?('VG-')
                    targetObj['IsVegan'] = true
                end
            end
        end
    end
    file.write("#{tar_url.sub("webdata/k2","web")}\n")
    file.write(targetObj)
    file.write("\n\n")
end
file.close