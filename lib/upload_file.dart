import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:upload_files/bloc/cubit.dart';
import 'package:upload_files/bloc/states.dart';
import 'package:upload_files/http/http_helper.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: BlocProvider(
          create: (BuildContext context) { return UploadFilesCubit(); },
          child: BlocConsumer<UploadFilesCubit,UploadFilesStates>(
            builder: (BuildContext context, state) {
           return   Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Upload file',
                  ),
                  ElevatedButton(
                      onPressed: ()=>UploadFilesCubit.get(context).pickFiles(),
                      child: Text("Pick File")
                  ),

                  FloatingActionButton(
                    onPressed:()=> UploadFilesCubit.get(context).uploadFiles(name: 'file1'),
                    tooltip: 'upload Files',
                    child: const Icon(Icons.upload_file),
                  )
                ],
              );
            },
            listener: (BuildContext context, state) {
              if(state is UploadFilesLoadingState) {
                EasyLoading.show(status: "Loading",
                    maskType: EasyLoadingMaskType.clear);
              } else if(state is UploadFilesSuccessState) {
                EasyLoading.showSuccess("UpLoading Successfully "
                , maskType: EasyLoadingMaskType.clear);
              }
            },

          ),
        ),
      ),
    );
  }
}