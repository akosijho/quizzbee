import 'package:dio/dio.dart';
import 'package:game_master/app/app_view_model.dart';
import 'package:game_master/widgets/conection_response.dart';

class FinishViewModel extends AppViewModel{
  int? finish;

  void init()async{

    try{
      finish = await api.getFinish();
      if(finish != null && finish == 0){
        try{
          await api.finish();
        }on DioError catch(e){
          connectionResponse(e);
          rethrow;
        }
      }
    }on DioError catch(e){
      connectionResponse(e);
      rethrow;
    }
  }
}