import 'package:trooper_hackout/news_resource/models/categorie_model.dart';

List<CategorieModel> getCategories() {
  List<CategorieModel> myCategories = List<CategorieModel>();
  CategorieModel categorieModel;

  //1
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "World";
  categorieModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1521295121783-8a321d551ad2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80";
  myCategories.add(categorieModel);

  //2
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Videos";
  categorieModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1586771107445-d3ca888129ff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1052&q=80";
  myCategories.add(categorieModel);

  return myCategories;
}
