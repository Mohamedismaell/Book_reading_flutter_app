import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/features/explore/presentation/manager/search/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, required this.isTapable, this.onTap});

  final bool isTapable;
  final VoidCallback? onTap;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          !widget.isTapable
              ? IconButton(
                  alignment: Alignment.center,
                  style: IconButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 24.sp,
                    color: AppColors.gray,
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: TextField(
              controller: searchController,
              autofocus: !widget.isTapable,
              readOnly: widget.isTapable,
              onTap: widget.isTapable ? widget.onTap : null,
              onChanged: widget.isTapable
                  ? null
                  : (value) {
                      context.read<SearchCubit>().search(value);
                    },
              decoration: const InputDecoration(hintText: 'Search'),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: Icon(Icons.mic, size: 24.sp, color: AppColors.gray),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: widget.isTapable
                ? widget.onTap
                : () {
                    context.read<SearchCubit>().search(searchController.text);
                  },
            icon: Icon(Icons.search, size: 24.sp, color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}
