class ItemsListModel{
  final List<dynamic> itemsList;

  ItemsListModel({required this.itemsList});

  factory ItemsListModel.fromJson(List<dynamic>jsonData){
    return ItemsListModel(
      itemsList: jsonData,
    );
  }
}