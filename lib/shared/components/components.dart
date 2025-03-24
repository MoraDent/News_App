import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../cubit/states.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgroundColor = Colors.cyan,
  bool isUpperCase = true,
  double radius  = 20.0,
  required void Function()? function,
  required String text,
}) => Container(
  width: width,
  height: 50.0,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
    ),
    autofocus: true,
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required FormFieldValidator<String>? validate,
  required TextInputType type,
  required String label,
  required IconData prefix,
  IconData? suffix,
  void Function(String)? onSubmit,
  void Function()? onTap,
  void Function(String)? onChange,
  void Function()? suffixPressed,
  bool isPassword = false,
  bool noKeyboard = false,
}) => TextFormField(
  readOnly: noKeyboard,
  controller: controller,
  validator: validate,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(suffix),
    ) : null,
  ),
);

Widget buildArticleItem(article) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0,),
          image: DecorationImage(
            image: NetworkImage('${article['image']}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(width: 20.0,),
      Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[400],
);

Widget articleBuilder(list) => ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index]),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: list.length,
  ),
  fallback: (context) => Center(
    child:
     CircularProgressIndicator()
  ),
);