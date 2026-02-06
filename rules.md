state_management: flutter_bloc (Cubit)
architecture: MVVM (View + ViewModel(Cubit) + Model)
language: Dart 3 (Sealed Classes, Records, Pattern Matching)
MVVM Architecture (BLoC / Cubit version)
1. MVVM Core Architecture Rules
RULE 1.1: STRICTLY separate layers:

View — UI only

ViewModel — Cubit (State + Logic)

Model — Domain / Data

RULE 1.2: ViewModel (Cubit) is the single source of truth for UI state.
View is fully passive.

RULE 1.3: BIND View to ViewModel using BlocBuilder / BlocConsumer.
❌ NEVER read Cubit state imperatively inside UI.

RULE 1.4: One-directional data flow:

scss
Копировать код
View → ViewModel(Cubit) → Repository → DataSource
RULE 1.5: Return flow:

scss
Копировать код
DataSource → Repository(Result<T,E>) → Cubit (emit State) → View
RULE 1.6: ❌ NEVER access Repository or DataSource from View.

2. ViewModel (Cubit) Implementation Rules
RULE 2.1: ViewModel MUST extend Cubit<State>.

RULE 2.2: Expose only one immutable State (sealed class).
❌ NO separate isLoading, error, data.

RULE 2.3: State transitions ONLY via emit(newState).

RULE 2.4: Business logic lives ONLY inside Cubit methods
(e.g. load(), submit(), confirmAyah()).

RULE 2.5: Inject dependencies via constructor (Repositories, Services).

3. State Management with Sealed Classes
RULE 3.1: DEFINE a sealed class FeatureState.

RULE 3.2: Use explicit subclasses:

dart
Копировать код
Initial
Loading
Success(data)
Error(message)
RULE 3.3: NEVER emit the same state instance twice.

RULE 3.4: RESET state when leaving feature if needed (emit(Initial())).

4. Cubit Constraints (Critical)
RULE 4.1: ❌ NEVER import or use BuildContext inside Cubit.

RULE 4.2: ❌ NEVER use UI types in Cubit
(Widget, Color, Theme, TextStyle).

RULE 4.3: CLEAN UP resources in close().
ду
UI & Widget Architecture (Bloc-based)
1. Core UI Principles
RULE 1.1: UI = pure function of State.

RULE 1.2: ❌ NEVER create helper methods that return Widgets
(e.g. _buildHeader() is forbidden).

RULE 1.3: Always extract UI into dedicated Widgets.

RULE 1.4: Split files when widget > 100 LOC.

2. Widget Implementation
RULE 2.1: Use const constructors wherever possible.

RULE 2.2: Subscribe to state ONLY via:

BlocBuilder

BlocConsumer (when side effects needed)

RULE 2.3: Handle ALL states using Dart 3 switch expression.

RULE 2.4: Data flows down via constructor, events flow up via callbacks.

RULE 2.5: Always provide Key to widgets.

3. Lifecycle & Initialization
RULE 3.1: ❌ NEVER call Cubit methods inside build().

RULE 3.2: Create Cubit in:

BlocProvider(create: ...)

or DI layer

RULE 3.3: initState() allowed ONLY for local controllers.

RULE 3.4: didChangeDependencies() allowed ONLY for context-based reads.

4. Navigation & Side Effects (IMPORTANT)
RULE 4.1: Use BlocConsumer:

builder → UI

listener → navigation, snackbars

RULE 4.2: ❌ NEVER trigger navigation inside builder.

RULE 4.3: Side effects must be triggered by state transitions, not flags.

RULE 4.4: ❌ FORBIDDEN:

WidgetsBinding.addPostFrameCallback

manual stream controllers

Repository & Data Layer (unchanged)
Repository Rules
Abstract interfaces

Return Result<T,E>

No raw exceptions

Map DTO ↔ Domain inside Repository

Data Sources
Remote / Local separation

Handle low-level errors internally

Testing & Quality
Testing
RULE 1.1: Unit-test Cubits (mock repositories)

RULE 1.2: Test full state sequences:

javascript
Копировать код
Initial → Loading → Success / Error
RULE 1.3: Verify exact emitted states.

RULE 1.4: Widget tests verify UI ↔ state mapping.

Strictly Forbidden Anti-Patterns
❌ StatefulWidget used only to listen to Cubit
❌ didUpdateWidget for state handling
❌ storing previous state in UI
❌ nested BlocBuilder (split Cubits instead)
❌ calling Cubit from build()

Priority Enforcement
CRITICAL

MVVM 1.1 (Layer separation)

Cubit purity (no BuildContext)

Repo Result pattern

HIGH

Sealed States

switch expressions

const widgets

