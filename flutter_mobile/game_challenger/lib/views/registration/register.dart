import 'package:flutter/material.dart';
import 'package:game_challenger/views/registration/register_view_model.dart';
import 'package:game_challenger/views/widgets/build_body.dart';
import 'package:stacked/stacked.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => RegisterViewModel(),
        onViewModelReady: (model) => model.init(),
        builder: (context, model, child) => Scaffold(
              body: BuildBody(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Register challenger"),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 56,
                          child: TextFormField(
                            controller: model.name,
                            decoration: InputDecoration(
                                hintText: "Enter you name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Do not leave this empty';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              model.submit();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                              color: const Color(0xff31cb00),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              onPressed: () {
                                model.register(model.name.value.text);
                              },
                              child: Center(
                                child: model.isBusy
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        "Proceed",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(color: Colors.white),
                                      ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
