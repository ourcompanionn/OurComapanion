import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/summery.dart';
import 'package:our_companion_app/app/shared/request/presentation/controller/request_flow_controller.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/sheet_content.dart';

class CustomerRequestDetailsPage extends ConsumerWidget {
  const CustomerRequestDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    final requestState = ref.watch(requestFormProvider);
    final requestNotifier = ref.read(requestFormProvider.notifier);
    final flowState = ref.watch(requestFlowProvider);
    final flowNotifier = ref.read(requestFlowProvider.notifier);

    return Scaffold(
      backgroundColor: appColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(255, 45, 44, 44),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.map, size: 64, color: Colors.grey[500]),
                    const SizedBox(height: 8),
                    Text(
                      'Map Background (Dummy)',
                      style: GoogleFonts.poppins(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 22,
            left: 16,
            child: InkWell(
              hoverColor: appColors.accent,
              onTap: () => context.pop(),
              borderRadius: BorderRadius.circular(24),
              child: CircleAvatar(
                backgroundColor: appColors.background,
                radius: 24,
                child: Icon(Icons.arrow_back, color: appColors.text),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
              ),
              child: const Summery(),
            ),
          ),

          // Draggable Bottom Sheet Content
          DraggableScrollableSheet(
            initialChildSize: flowState == RequestFlowState.initial ? 0.6 : 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: appColors.seconderyBackground,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SheetContent(
                  flowState: flowState,
                  flowNotifier: flowNotifier,
                  appColors: appColors,
                  requestState: requestState,
                  requestNotifier: requestNotifier,
                  scrollController: scrollController,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
