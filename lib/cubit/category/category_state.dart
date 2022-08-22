part of 'category_cubit.dart';

abstract class CategoryState {
  String? name;
  CategoryState(this.name);
}

class CategoryInitial extends CategoryState {
  CategoryInitial() : super('Arts & Literature');
}

class CategoryCurrent extends CategoryState {
  CategoryCurrent(String? name) : super(name);
}
