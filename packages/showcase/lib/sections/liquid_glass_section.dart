import 'package:flutter/material.dart';

import '../components/code_block.dart';
import '../components/section_title.dart';
import '../layout/responsive.dart';
import '../layout/section_wrapper.dart';

/// Liquid Glass section — visual showcase (liquid glass requires Impeller, not web).
class LiquidGlassSection extends StatelessWidget {
  const LiquidGlassSection({super.key, this.sectionKey});

  final GlobalKey? sectionKey;

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: sectionKey,
      enableFadeIn: false,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF0A0A14)
          : const Color(0xFFF0F0FF),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Liquid Glass',
            subtitle: 'iOS 26 aesthetic for Flutter',
          ),
          Text(
            'Requires Impeller engine — available on iOS, Android, macOS',
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 40),
          ResponsiveGrid(
            desktopColumns: 3,
            tabletColumns: 3,
            mobileColumns: 1,
            children: const [
              _GlassStyleCard(
                title: 'Separate',
                description: 'Individual glass cells with spacing',
                style: _GlassStyle.separate,
              ),
              _GlassStyleCard(
                title: 'Unified',
                description: 'One glass container with dividers',
                style: _GlassStyle.unified,
              ),
              _GlassStyleCard(
                title: 'Blended',
                description: 'Cells blend together — iOS 26 style',
                style: _GlassStyle.blended,
              ),
            ],
          ),
          const SizedBox(height: 40),
          const CodeBlock(
            code: '''import 'package:pin_code_fields_liquid_glass/pin_code_fields_liquid_glass.dart';

LiquidGlassPinField(
  length: 6,
  theme: LiquidGlassPinTheme.blended(
    blur: 10,
    glassColor: Colors.white.withOpacity(0.2),
    borderRadius: 12,
  ),
  onCompleted: (pin) => print('PIN: \$pin'),
)''',
          ),
        ],
      ),
    );
  }
}

enum _GlassStyle { separate, unified, blended }

class _GlassStyleCard extends StatefulWidget {
  const _GlassStyleCard({
    required this.title,
    required this.description,
    required this.style,
  });

  final String title;
  final String description;
  final _GlassStyle style;

  @override
  State<_GlassStyleCard> createState() => _GlassStyleCardState();
}

class _GlassStyleCardState extends State<_GlassStyleCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF1A1A2E),
                    const Color(0xFF15152A),
                  ]
                : [
                    Colors.white,
                    const Color(0xFFF8F0FF),
                  ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? const Color(0xFFEC4899).withValues(alpha: 0.5)
                : (isDark
                    ? const Color(0xFF2A2A3E)
                    : const Color(0xFFE5E7EB)),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: const Color(0xFFEC4899).withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            // Visual representation of glass cells
            _GlassVisual(style: widget.style, isDark: isDark),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            Text(
              widget.description,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Visual representation of glass styles (no actual glass rendering on web).
class _GlassVisual extends StatelessWidget {
  const _GlassVisual({required this.style, required this.isDark});

  final _GlassStyle style;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final glassColor = isDark
        ? Colors.white.withValues(alpha: 0.1)
        : Colors.white.withValues(alpha: 0.6);
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.15)
        : Colors.white.withValues(alpha: 0.4);

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: switch (style) {
        _GlassStyle.separate => _buildSeparate(glassColor, borderColor),
        _GlassStyle.unified => _buildUnified(glassColor, borderColor),
        _GlassStyle.blended => _buildBlended(glassColor, borderColor),
      },
    );
  }

  Widget _buildSeparate(Color glass, Color border) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (i) => Container(
          width: 44,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: glass,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEC4899).withValues(alpha: 0.08),
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: i < 2
                ? Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildUnified(Color glass, Color border) {
    return Container(
      decoration: BoxDecoration(
        color: glass,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          4,
          (i) => Container(
            width: 44,
            height: 56,
            decoration: BoxDecoration(
              border: i < 3
                  ? Border(
                      right: BorderSide(
                        color: border,
                        width: 0.5,
                      ),
                    )
                  : null,
            ),
            child: Center(
              child: i < 2
                  ? Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color:
                            isDark ? Colors.white : const Color(0xFF1A1A2E),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlended(Color glass, Color border) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (i) => Container(
          width: 44,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: glass,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border.withValues(alpha: 0.08)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEC4899).withValues(alpha: 0.05),
                blurRadius: 12,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: i < 2
                ? Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
