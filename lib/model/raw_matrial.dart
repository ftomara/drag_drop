import 'package:drag_drop/model/machine.dart';

class RawMatrial {
  String name='';
  String code = '';
  List<Machine>? machines =[];
  RawMatrial({required this.name , required this.code , this.machines });
}