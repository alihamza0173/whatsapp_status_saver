import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/extensions/context_extentions.dart';
import 'package:whatsapp_status_saver/shared/presentation/ui/drawer/widgets/circle_border_text.dart';

class HowToUseDialog extends StatelessWidget {
  const HowToUseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('${context.l10n.howToUse} ?'),
      children: [
        const ListTile(
          leading: CircleBorderedText(
            '1',
          ),
          title: Text('Open Whatsapp Watch the Desired Status/Story'),
        ),
        const ListTile(
          leading: CircleBorderedText('2'),
          title: Text('Open Status Saver Click on any Image or Video to View'),
        ),
        const ListTile(
          leading: CircleBorderedText('3'),
          title: Text('Click Save Button'),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(context.l10n.ok),
            ),
          ],
        )
      ],
    );
  }
}
