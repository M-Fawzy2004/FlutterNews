import '../model/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel();

  categoryModel.name = 'bussiness';
  categoryModel.image = 'assets/bussiness .jpg';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.name = 'entertainment';
  categoryModel.image = 'assets/entertaiment.jpg';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.name = 'general';
  categoryModel.image = 'assets/general.jpg';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.name = 'health';
  categoryModel.image = 'assets/health.jpg';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.name = 'sports';
  categoryModel.image = 'assets/sport.jpg';
  category.add(categoryModel);
  categoryModel = CategoryModel();

  return category;
}
