import 'package:catering/bloc/category/category_bloc.dart';
import 'package:catering/repositories/category_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizationTags extends StatelessWidget {
  final int categoryID;

  const OrganizationTags({
    Key? key,
    required this.categoryID,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(categoryRepository: context.read<CategoryRepository>())..add(LoadCategories()),
      child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return SizedBox(
                width: 21,
                height: 21,
                child: Center(
                  child: CupertinoActivityIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    radius: 10,
                  ),
                )
              );
            } else if (state is CategoryLoaded) {
              return Row(
                children: state.categories
                  .where((category) => categoryID == category.id)
                  .map((tag) =>
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text(tag.name),
                    )
                  ).toList()
              );
            } else {
              return Container();
            }
            
                // restaurant.tags.indexOf(tag) == restaurant.tags.length - 1
                //     ? Text(tag, style: Theme.of(context).textTheme.bodyText1)
                //     : Text("$tag, ", style: Theme.of(context).textTheme.bodyText1)),
        
          },
      )
    );
  }
}