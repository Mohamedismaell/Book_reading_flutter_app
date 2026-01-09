import 'package:bookreading/core/helper/size_provider/size_provider.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/routes/app_routes.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalView extends StatelessWidget {
  const HorizontalView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: const Size(160, 310),
      width: context.setWidth(160),
      height: context.setHeight(310),
      child: Builder(
        builder: (context) {
          Theme.of(context);
          return SizedBox(
            height: context.sizeProvider.height,
            // width: double.infinity,
            child: ListView.builder(
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: context.setMinSize(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => context.push(AppRoutes.bookDetails),
                          child: Container(
                            width: context.sizeProvider.width,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Image.asset(
                              "assets/images/back_ground_auth.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.setMinSize(16)),
                      Text("Book Title", style: context.headlineSmall()),
                      Text("Book Author", style: context.bodyMedium()),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
