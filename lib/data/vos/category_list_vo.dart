class CategoryListVO{
  String? categoryName;
  bool? isSelected;

  CategoryListVO(this.categoryName, this.isSelected);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryListVO &&
          runtimeType == other.runtimeType &&
          categoryName == other.categoryName &&
          isSelected == other.isSelected;

  @override
  int get hashCode => categoryName.hashCode ^ isSelected.hashCode;
}