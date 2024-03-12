import 'hier_product_model.dart';
import 'legendary_experience_chart_model.dart';

/// title : "Thu nhập của bạn"
/// url_post : [{"url":"https://drive.google.com/file/d/1suMEER72uZIOPRWCmIewZD0AFEQNhJGp/view?usp=sharing","title":"Mô hình thu nhập gián tiếp"}]
/// products : {"allSales":{"name":"Tổng thu nhập","salesGrowth":54,"wallet":2484136,"statusGrowth":"down","productsList":[{"name":"Tài chính","salesGrowth":58,"currentGrowth":46,"wallet":1154784,"statusGrowth":"down","background":"#005fff"},{"name":"Bảo hiểm","salesGrowth":100,"currentGrowth":0,"wallet":0,"statusGrowth":"down","background":"#dc41d7"},{"name":"Mở ví/ngân hàng","salesGrowth":84,"currentGrowth":7,"wallet":182800,"statusGrowth":"down","background":"#ff499c"},{"name":"Bán hàng trả chậm","salesGrowth":7066,"currentGrowth":46,"wallet":1146552,"statusGrowth":"up","background":"#221DB0"}]}}
/// note : [[{"text":"Bán hàng","color":"#00cc94","bold":true},{"text":": là thu nhập bạn có được từ doanh số bán hàng mà bạn trực tiếp tham gia","color":"#6b6b81"}],[{"text":"Dẫn dắt","color":"#f58b14","bold":true},{"text":": là thu nhập bạn thừa hưởng được từ doanh số bán hàng của mạng lưới bên dưới","color":"#6b6b81"}]]
/// filter : [{"id":"allSales","title":"Tất cả"},{"id":"directSales","title":"Bán hàng"},{"id":"indirectSales","title":"Dẫn dắt"}]

class LegendaryIncomeChartModel {
  LegendaryIncomeChartModel({
    this.title,
    this.urlPost,
    this.products,
    this.note,
    this.filter,
  });

  LegendaryIncomeChartModel.fromChartJson(dynamic json, {String? keyword}) {
    products = json['products'] != null ? HierProductModel.fromJson(json['products']?[keyword]) : null;
    title = json['title'];
    if (json['url_post'] != null) {
      urlPost = [];
      json['url_post'].forEach((v) {
        urlPost?.add(HierUrlPostModel.fromJson(v));
      });
    }
    if (json['note'] != null) {
      note = [];
      json['note'].forEach((v) {
        var insideList = <HierNoteModel>[];
        if (v is List) {
          for (var v in v) {
            insideList.add(HierNoteModel.fromJson(v));
          }
          note?.add(insideList);
        }
      });
    }
    if (json['filter'] != null) {
      filter = [];
      json['filter'].forEach((v) {
        filter?.add(HierFilterModel.fromJson(v));
      });
    }
  }

  String? title;
  List<HierUrlPostModel>? urlPost;
  HierProductModel? products;
  List<List<HierNoteModel>>? note;
  List<HierFilterModel>? filter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    if (urlPost != null) {
      map['url_post'] = urlPost?.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      map['products'] = products?.toJson();
    }
    if (note != null) {
      map['note'] = note?.map((v) => v.map((e) => e.toJson()).toList()).toList();
    }
    if (filter != null) {
      map['filter'] = filter?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
