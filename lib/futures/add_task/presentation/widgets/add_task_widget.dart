import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/cubits/cubit_todo/cubit.dart';
import '../../../../core/cubits/cubit_todo/states.dart';
import '../../../../core/widgets/my_text_form.dart';
import '../../../../core/widgets/line.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../board/presentation/page/board_page.dart';

class AddTaskWidget extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  TextEditingController titleController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController startTimeController=TextEditingController();
  TextEditingController endTimeController=TextEditingController();
  TextEditingController remindController=TextEditingController();
  TextEditingController repeatController=TextEditingController();
  TextEditingController colorController=TextEditingController();
   AddTaskWidget({Key? key}) : super(key: key);

   List<String>remindItems=[
     'Never',
     '10 min before',
     '30 min before',
     '1 hour before',
     '1 day before',
   ];
   List<String>repeatItems=[
     'Once',
     'Daily',
     'Sun to Thurs',
     'Custom'
   ];

  @override
  Widget build(BuildContext context) {
    remindController.text='Never';
    repeatController.text='Once';
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=TodoCubit.get(context);
        return Form(
          key: formKey,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 50.h),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.w,right: 20.w,),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      const Text('Add Task',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const Line(),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 20.w,right: 20.w,),
                      child: Column(
                        children: [

                          MyTextForm(
                            hint: 'Enter your title',
                            label: 'Title',
                            controller: titleController,
                            validator: 'title must be not empty',

                          ),
                          MyTextForm(
                            hint: DateFormat.yMMMd().format(DateTime.now()),
                            label: 'Date',
                            controller: dateController,
                            widget: IconButton(
                              onPressed: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2030-12-30'),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                              icon: const Icon(Icons.calendar_month_outlined),
                            ),
                            validator: 'Date must be not empty',

                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MyTextForm(
                                  hint: TimeOfDay.now().format(context).toString(),
                                  label: 'Start time',
                                  controller: startTimeController,
                                  widget: timePicker(context,startTimeController),
                                  validator: '',

                                ),
                              ),
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: MyTextForm(
                                  hint: TimeOfDay.now().format(context).toString(),
                                  label: 'End time',
                                  controller: endTimeController,
                                  widget: timePicker(context,endTimeController),
                                  validator: 'end time must be not empty',

                                ),
                              ),
                            ],
                          ),
                          MyTextForm(
                            hint: 'Never',
                            label: 'Remind',
                            controller: remindController,
                            widget: dropdownButton(remindItems,remindController),

                          ),
                          MyTextForm(
                            hint: 'Once',
                            label: 'Repeat',
                            controller: repeatController,
                            widget:  dropdownButton(repeatItems,repeatController),

                          ),
                          SizedBox(height: 30.h,),
                          Row(
                            children: [
                              IconButton(
                                onPressed: (){
                                  cubit.choiceTaskColor(red: 1,orange: 0,yellow: 0,blue: 0);
                                },
                                icon: Icon(cubit.iconOfChoiceColorRed,color: Colors.red,),
                              ),
                              IconButton(
                                onPressed: (){
                                  cubit.choiceTaskColor(red: 0,orange: 1,yellow: 0,blue: 0);

                                },
                                icon: Icon(cubit.iconOfChoiceColorOrange,color: Colors.orange,),
                              ),
                              IconButton(
                                onPressed: (){
                                  cubit.choiceTaskColor(red: 0,orange: 0,yellow: 1,blue: 0);

                                },
                                icon: Icon(cubit.iconOfChoiceColorYellow,color: Colors.yellow,),
                              ),
                              IconButton(
                                onPressed: (){
                                  cubit.choiceTaskColor(red: 0,orange: 0,yellow: 0,blue: 1);

                                },
                                icon: Icon(cubit.iconOfChoiceColorBlue,color: Colors.blue,),
                              ),
                              const Spacer(),
                              IconButton(onPressed: (){
                                cubit.favoriteOrNot();
                              }, icon:  Icon(cubit.favoriteIcon,color: Colors.red,)),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: MyButton(
                              text: 'Create a task',
                              callback: (){
                                if(formKey.currentState!.validate()){
                                  String isFavorite=((cubit.favorite)?"favorite":"unfavored");
                                  cubit.insertDatabase(
                                    title: titleController.text,
                                    date: dateController.text,
                                    startTime:startTimeController.text,
                                    endTime: endTimeController.text,
                                    remind: remindController.text,
                                    repeat: repeatController.text,
                                    color: cubit.colorOfTask,
                                    favorite: isFavorite,
                                  );
                                  titleController.clear();
                                  dateController.clear();
                                  startTimeController.clear();
                                  endTimeController.clear();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const BoardPage()),
                                  );
                                }
                              },
                              buttonColor: Colors.green,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }


  Widget timePicker(BuildContext context,TextEditingController controller)=>IconButton(
    onPressed: (){
      showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((value) {
        controller.text =
            value!.format(context).toString();
      });
    },
    icon: const Icon(Icons.watch_later_outlined),
  );

  DropdownButton dropdownButton(List list,TextEditingController controller)=>DropdownButton(
    icon: const Icon(Icons.keyboard_arrow_down,),
    items: list.map<DropdownMenuItem<String>>((value) {
      return DropdownMenuItem(
        value: value,
        child:Text(value),
      );
    }).toList(),
    onChanged: (item){
      controller.text=item;
    },
  );

}
