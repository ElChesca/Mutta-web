import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mutta_web/data/models/event_content.dart';
import 'package:mutta_web/data/providers.dart';

class TicketSelectionState {
  const new({
    required this.passId,
    required this.name,
    required this.description,
    required this.unitPrice,
    required this.quantity,
    required this.explicit,
    required this.minQuantity,
    required this.maxQuantity,
  });

  final String passId;
  final String name;
  final String description;
  final int unitPrice;
  final int quantity;
  final bool explicit;
  final int minQuantity;
  final int maxQuantity;

  int get total => unitPrice * quantity;

  bool get canDecrease => quantity > minQuantity;

  bool get canIncrease => quantity < maxQuantity;
}

class TicketSelectionNotifier extends Notifier<TicketSelectionState> {
  PassesContent? _passes;

  @override
  TicketSelectionState build() {
    final content = ref.watch(eventContentProvider).asData?.value;
    if (content == null) {
      _passes = null;
      return const TicketSelectionState(
        passId: '',
        name: '',
        description: '',
        unitPrice: 0,
        quantity: 1,
        explicit: false,
        minQuantity: 1,
        maxQuantity: 10,
      );
    }
    _passes = content.passes;
    final initial = content.passById(content.passes.checkout.initialPassId);
    return TicketSelectionState(
      passId: initial.id,
      name: initial.name,
      description:
          initial.defaultSummary ?? _summary(initial, 1, explicit: true),
      unitPrice: initial.priceArs,
      quantity: content.passes.checkout.minQuantity,
      explicit: false,
      minQuantity: content.passes.checkout.minQuantity,
      maxQuantity: content.passes.checkout.maxQuantity,
    );
  }

  void select(PassTier pass) {
    state = TicketSelectionState(
      passId: pass.id,
      name: pass.name,
      description: _summary(pass, state.quantity, explicit: true),
      unitPrice: pass.priceArs,
      quantity: state.quantity,
      explicit: true,
      minQuantity: state.minQuantity,
      maxQuantity: state.maxQuantity,
    );
  }

  void setQuantity(int quantity) {
    final passes = _passes;
    final next = _clamp(quantity);
    if (passes == null) {
      return;
    }
    final pass = passes.tiers.firstWhere((tier) => tier.id == state.passId);
    state = TicketSelectionState(
      passId: state.passId,
      name: state.name,
      description: _summary(pass, next, explicit: state.explicit || next != 1),
      unitPrice: state.unitPrice,
      quantity: next,
      explicit: state.explicit || next != 1,
      minQuantity: state.minQuantity,
      maxQuantity: state.maxQuantity,
    );
  }

  int _clamp(int quantity) {
    if (quantity < state.minQuantity) {
      return state.minQuantity;
    }
    if (quantity > state.maxQuantity) {
      return state.maxQuantity;
    }
    return quantity;
  }

  String _summary(PassTier pass, int quantity, {required bool explicit}) {
    if (!explicit && quantity == 1 && pass.defaultSummary != null) {
      return pass.defaultSummary!;
    }
    final template = _passes?.checkout.summaryTemplate ?? '{qty}x {name}';
    return template
        .replaceAll('{qty}', '$quantity')
        .replaceAll('{name}', pass.name);
  }
}

final ticketSelectionProvider =
    NotifierProvider<TicketSelectionNotifier, TicketSelectionState>(
      TicketSelectionNotifier.new,
    );
