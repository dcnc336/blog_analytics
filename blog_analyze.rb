require 'csv'
require 'rubyXL'
require 'creek'

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
            'title' => row[2].delete(" \t\r\n\ "),
            'author' => row[3].delete(" \t\r\n\ "),
            'url' => row[4].delete(" \t\r\n\ "),
            'published_at' => row[5].delete(" \t\r\n\ "),
            'created_at' => row[6].delete(" \t\r\n\ "),
            'updated_at' => row[7].delete(" \t\r\n\ "),
            'featured_image_url' => row[8].delete(" \t\r\n\ ")
        })
    end
    index += 1
end

performance_file_names = [
    'Performance_by_Page_2022-07-01_2022-07-31.xlsx',
    # 'Performance_by_Page_2022-08-01_2022-08-31.xlsx',
    # 'Performance_by_Page_2022-09-01_2022-09-30.xlsx',
    # 'Performance_by_Page_2022-10-01_2022-10-31.xlsx',
    # 'Performance_by_Page_2022-11-01_2022-11-30.xlsx',
    # 'Performance_by_Page_2022-12-01_2022-12-31.xlsx',
    # 'Performance_by_Page_2023-01-01_2023-01-31.xlsx',
    # 'Performance_by_Page_2023-02-01_2023-02-28.xlsx',
    # 'Performance_by_Page_2023-03-01_2023-03-31.xlsx',
    # 'Performance_by_Page_2023-04-01_2023-04-30.xlsx',
    # 'Performance_by_Page_2023-05-01_2023-05-31.xlsx',
    # 'Performance_by_Page_2023-06-01_2023-06-30.xlsx',
    # 'Performance_by_Page_2023-07-01_2023-07-31.xlsx',
    # 'Performance_by_Page_2023-08-01_2023-08-31.xlsx',
    # 'Performance_by_Page_2023-09-01_2023-09-30.xlsx'
]

performance_datas = []

creek = Creek::Book.new './blog_analytics/input/Performance_by_Page_2022-07-01_2022-07-31.xlsx'
sheet = creek.sheets[0]

index = 0
sheet.rows.each do |row|
    next if index == 0
    index += 1
    blog_index = 0
    for blog in blog_posts do
        if row['A2'].delete(" \t\r\n") == blog['url']
            performance_datas.push({
                'id'=> blog['id'],
                'wp_post_id' => blog['wp_post_id'],
                'title' => blog['title'],
                'author' => blog['author'],
                'url' => blog['url'],
                'base_url' => blog['featured_image_url'],
                'published_at' => blog['published_at'],
                'created_at' => blog['created_at'],
                'updated_at' => blog['updated_at'],
                'age' => '',
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
            })
        end
        blog_index += 1
    end
    CSV.open("./blog_analytics/output/output.csv", "w") do |csv|
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
end

# for filename in performance_file_names do
#     print filename
#     workbook = RubyXL::Parser.parse("./blog_analytics/input/#{filename}")
#     worksheets = workbook.worksheets
#     index = 0
#     # worksheets.each do |row|
#     #     row_cells = row.cells.map{ |cell| cell.value }
#     #     if index == 0
#     #         # print row_cells
#     #     end
#     #     index += 1
#     # end
#     print index
# end