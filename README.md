# OpenMUD

### Behaviour Tree notes

- Start node
- Start node points to a control flow node
- Control flow node points to a decision node
- Decision node points to a control flow node or a leaf node

But these need to be implemented as a registry, which means that others can propose new sibling behaviours but not new parents or remove any existing behaviours.