class Recipe {
  final int recipe_id;
  final String recipe_name;
  final String recipe_ingrdients;
  final String recipe_prep;
  final String recipe_cat;
  final String image_name;
  int? favorites;

  Recipe({required this.recipe_id, required this.recipe_name, required this.recipe_ingrdients, required this.recipe_prep, required this.recipe_cat, required this.image_name, this.favorites});
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipe_id: json['recipe_id'],
      recipe_name: json['recipe_name'],
      recipe_ingrdients: json['recipe_ingrdients'],
      recipe_prep: json['recipe_prep'],
      recipe_cat: json['recipe_cat'],
      image_name: json['image_name'],
      favorites: json['favorites'],
    );
  }
  Map<String, dynamic> toMap() {
    return {'recipe_id': recipe_id, 'recipe_name': recipe_name, 'recipe_ingrdients': recipe_ingrdients, 'recipe_prep': recipe_prep, 'recipe_cat': recipe_cat, 'image_name': image_name};
  }
}

class RecipeCat {
  final String recipe_cat;

  RecipeCat({required this.recipe_cat});
  factory RecipeCat.fromJson(Map<String, dynamic> json) {
    return RecipeCat(
      recipe_cat: json['recipe_cat'],
    );
  }
}
