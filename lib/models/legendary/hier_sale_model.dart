import 'hier_chart_info_model.dart';

/// salesList : [{"prevSalesPoint":5116,"name":"Tài chính","salesPoint":968,"currentGrowth":4.9,"salesGrowth":81.1,"statusGrowth":"down","background":"#005fff","url":""},{"prevSalesPoint":28099,"name":"Bảo hiểm","salesPoint":18466,"currentGrowth":93.6,"salesGrowth":34.3,"statusGrowth":"down","background":"#dc41d7","url":""},{"prevSalesPoint":110,"name":"Mở ví/ngân hàng","salesPoint":212,"currentGrowth":1.1,"salesGrowth":92.7,"statusGrowth":"up","background":"#ff499c","url":""},{"name":"Cộng tác viên","salesPoint":10,"prevSalesPoint":10,"currentGrowth":0.1,"salesGrowth":0,"statusGrowth":"","background":"#ff8469","url":""},{"name":"Định danh","salesPoint":5,"prevSalesPoint":5,"currentGrowth":0,"salesGrowth":0,"statusGrowth":"","background":"#ffc252","url":""},{"prevSalesPoint":20,"name":"CTV phát sinh tài chính","salesPoint":10,"currentGrowth":0.1,"salesGrowth":50,"statusGrowth":"down","background":"#ffc277","url":""},{"prevSalesPoint":25,"name":"CTV phát sinh bảo hiểm","salesPoint":25,"currentGrowth":0.1,"salesGrowth":0,"statusGrowth":"","background":"#ffb552","url":""},{"prevSalesPoint":88,"name":"Bán hàng trả chậm","salesPoint":29,"currentGrowth":0.1,"salesGrowth":67,"statusGrowth":"down","background":"#221DB0","url":""},{"name":"Vinh danh","salesPoint":0,"prevSalesPoint":0,"currentGrowth":0,"salesGrowth":0,"statusGrowth":"","background":"#6e418b","url":""}]
/// directSales : 164
/// indirectSales : 19561

class HierSaleModel {
  HierSaleModel({
    this.salesList,
    this.directSales,
    this.indirectSales,
  });

  HierSaleModel.fromJson(dynamic json) {
    if (json['salesList'] != null) {
      salesList = [];
      json['salesList'].forEach((v) {
        salesList?.add(HierChartInfoModel.fromJson(v));
      });
    }
    directSales = json['directSales'];
    indirectSales = json['indirectSales'];
  }

  List<HierChartInfoModel>? salesList;
  int? directSales;
  int? indirectSales;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (salesList != null) {
      map['salesList'] = salesList?.map((v) => v.toJson()).toList();
    }
    map['directSales'] = directSales;
    map['indirectSales'] = indirectSales;
    return map;
  }
}
