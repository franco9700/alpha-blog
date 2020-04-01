require 'test_helper'

class CreateCategoriesTest <ActionDispatch::IntegrationTest

	test "get new category form and create category" do
		get new_category_path
		assert_template 'categories/new'
		assert_difference 'Category.count', 1 do
			post categories_path, params: { category: {name: "sports"} }
			follow_redirect!
		end
		assert_template 'categories/index'
		assert_match "sports", response.body
	end

	test "invalid category submission results in failure" do
		get new_category_path
		assert_template 'categories/new'
		assert_no_difference 'Category.count' do
			post categories_path, params: { category: {name: " "} }
		end
		assert_template 'categories/new' #si hay error en el form redirige a new
		assert_select 'h4.card-title'
		assert_select 'div.card-text' #busca los tags de errores
	end
end