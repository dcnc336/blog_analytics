require 'csv'
require 'rubyXL'
require 'creek'
require 'date'

index = 0
blog_posts = []
blog_posts_keys = ["id", "wp_post_id", "title", "author", "url", "published_at", "created_at", "updated_at", "featured_image_url"]
performance_keys = ["page_url", "earnings", "pageviews","impressions_per_pageview","page_rpm", "cpm", "viewability","time_on_page"]
result_keys = [
    "id",
    "wp_post_id",
    "title",
    "author",
    "url", 
    "base_url", 
    "published_at", 
    "created_at", 
    "updated_at", 
    "age", 
    "total", 
    "month_1", 
    "month_2", 
    "month_3", 
    "month_4", 
    "month_5", 
    "month_6", 
    "month_7", 
    "month_8", 
    "month_9", 
    "month_10", 
    "month_11", 
    "month_12", 
    "month_13", 
]

CSV.foreach('blog_analytics/input/blog_posts.csv') do |row|
    if index > 0
        blog_posts.push({
            'id' => row[0].delete(" \t\r\n\ "),
            'wp_post_id' => row[1].delete(" \t\r\n\ "),
            'title' => row[2].strip,
            'author' => row[3].strip,
            'url' => row[4].delete(" \t\r\n\ "),
            'published_at' => row[5].strip,
            'created_at' => row[6].strip,
            'updated_at' => row[7].strip,
            'featured_image_url' => row[8].strip
        })
    end
    index += 1
end

performance_file_names = [
    'Performance_by_Page_2022-07-01_2022-07-31.xlsx',
    'Performance_by_Page_2022-08-01_2022-08-31.xlsx',
    'Performance_by_Page_2022-09-01_2022-09-30.xlsx',
    'Performance_by_Page_2022-10-01_2022-10-31.xlsx',
    'Performance_by_Page_2022-11-01_2022-11-30.xlsx',
    'Performance_by_Page_2022-12-01_2022-12-31.xlsx',
    'Performance_by_Page_2023-01-01_2023-01-31.xlsx',
    'Performance_by_Page_2023-02-01_2023-02-28.xlsx',
    'Performance_by_Page_2023-03-01_2023-03-31.xlsx',
    'Performance_by_Page_2023-04-01_2023-04-30.xlsx',
    'Performance_by_Page_2023-05-01_2023-05-31.xlsx',
    'Performance_by_Page_2023-06-01_2023-06-30.xlsx',
    'Performance_by_Page_2023-07-01_2023-07-31.xlsx',
    'Performance_by_Page_2023-08-01_2023-08-31.xlsx',
    'Performance_by_Page_2023-09-01_2023-09-30.xlsx'
]

performance_dates = [
    '2022-07-31',
    '2022-08-31',
    '2022-09-30',
    '2022-10-31',
    '2022-11-30',
    '2022-12-31',
    '2023-01-31',
    '2023-02-28',
    '2023-03-31',
    '2023-04-30',
    '2023-05-31',
    '2023-06-30',
    '2023-07-31',
    '2023-08-31',
    '2023-09-30'
]

performance_datas = []

date_format = '%Y-%m-%d %H:%M:%S'
dates = Date.today

performance_xlsx_datas = []
performance_xlsx_dates = []

performance_file_names.each_with_index do |filename, idx|
    print "#{filename}\n"
    temp_earn_month = Date.strptime(performance_dates[idx]).year * 12 + Date.strptime(performance_dates[idx]).month
    index = 0
    creek = Creek::Book.new "./blog_analytics/input/#{filename}"
    sheet = creek.sheets[0]
    temp = []
    sheet.simple_rows.each do |row|
        index += 1
        next if index == 1
        temp.push({
            "url" => row["A"].delete(" \t\r\n"),
            "income" => row["B"]
        })
    end
    performance_xlsx_datas.push(temp)
    performance_xlsx_dates.push(temp_earn_month)
end

for blog in blog_posts do
    temp_date = DateTime.strptime(blog['published_at'], date_format)
    temp_temp_month = temp_date.year * 12 + temp_date.month
    base_name = blog['url'].match(/\/([^\/]+)\/?$/)[1]
    temp_datas = {
        'id'=> blog['id'],
        'wp_post_id' => blog['wp_post_id'],
        'title' => blog['title'],
        'author' => blog['author'],
        'url' => blog['url'],
        'base_url' => base_name,
        'published_at' => blog['published_at'],
        'created_at' => blog['created_at'],
        'updated_at' => blog['updated_at'],
        'age' => (dates-temp_date).to_i,
        'total' => 0,
        'month_1' => 0, 
        'month_2' => 0,
        'month_3' => 0, 
        'month_4' => 0, 
        'month_5' => 0, 
        'month_6' => 0, 
        'month_7' => 0, 
        'month_8' => 0, 
        'month_9' => 0, 
        'month_10' => 0, 
        'month_11' => 0, 
        'month_12' => 0, 
        'month_13' => 0
    }
    performance_xlsx_datas.each_with_index do |xlsx_data, idx|
        for xlsx_one in xlsx_data do
            if (base_name.casecmp  xlsx_one['url'].match(/\/([^\/]+)\/?$/)[1]) == 0
                print "#{base_name}\n"
                income = xlsx_one["income"]
                temp_datas['total'] += income
                temp_month = performance_xlsx_dates[idx] - temp_temp_month + 1
                if temp_month == 1
                    temp_datas['month_1'] += income
                elsif temp_month == 2
                    temp_datas['month_2'] += income
                elsif temp_month == 3
                    temp_datas['month_3'] += income
                elsif temp_month == 4
                    temp_datas['month_4'] += income
                elsif temp_month == 5
                    temp_datas['month_5'] += income
                elsif temp_month == 6
                    temp_datas['month_6'] += income
                elsif temp_month == 7
                    temp_datas['month_7'] += income
                elsif temp_month == 8
                    temp_datas['month_8'] += income
                elsif temp_month == 9
                    temp_datas['month_9'] += income
                elsif temp_month == 10
                    temp_datas['month_10'] += income
                elsif temp_month == 11
                    temp_datas['month_11'] += income
                elsif temp_month == 12
                    temp_datas['month_12'] += income
                elsif temp_month > 12
                    temp_datas['month_13'] += income
                end
            end
        end
    end
    performance_datas.push(temp_datas)
end

CSV.open("./blog_analytics/output/output.csv", "w") do |csv|
    csv << [
        "ID",
        "WP_POST_ID",
        "Title",
        "Author",
        "Url", 
        "URL Basename", 
        "published_at", 
        "created_at", 
        "updated_at", 
        "Age (days)", 
        "Total Revenue Earned", 
        "Month 1 Revenue", 
        "Month 2", 
        "Month 3", 
        "Month 4", 
        "Month 5", 
        "Month 6", 
        "Month 7", 
        "Month 8", 
        "Month 9", 
        "Month 10", 
        "Month 11", 
        "Month 12", 
        "Month 13", 
    ]
    for data in performance_datas do
        csv << [
            data['id'], 
            data['wp_post_id'], 
            data['title'], 
            data['author'], 
            data['url'],
            data['base_url'], 
            data['published_at'],
            data['created_at'],
            data['updated_at'],
            data['age'],
            data['total'],
            data['month_1'],
            data['month_2'],
            data['month_3'],
            data['month_4'],
            data['month_5'],
            data['month_6'],
            data['month_7'],
            data['month_8'],
            data['month_9'],
            data['month_10'],
            data['month_11'],
            data['month_12'],
            data['month_13']
        ]
    end
end