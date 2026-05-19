# LINPHONE/VIEW: Knowledge Base

## OVERVIEW
UI layer for IXPHONE. Built with QML and Qt6. Follows MVVM pattern where C++ handles core logic and QML handles the view. All visual components reside here.

## STRUCTURE
- Style/: Design system tokens, themes, and icon registry.
- Control/: Reusable components like Buttons, Inputs, and Popups.
- Page/: Full screens, window shells, and complex layouts.
- Test/: Isolated component demos used for development only.

## WHERE TO LOOK
| Tarefa | Arquivo | Linhas |
| :--- | :--- | :--- |
| Shell principal e Roteamento | Page/Window/MainWindow.qml | 346 |
| Janela de Chamada ativa | Page/Window/Call/CallsWindow.qml | 1880 |
| Layout Principal (Nav e Painel) | Page/Layout/MainLayout.qml | 809 |
| Design Tokens e Cores base | Style/DefaultStyle.qml | - |
| Registro de Imagens e Ícones | Style/AppIcons.qml | - |
| Lógica JS de suporte UI | Control/Tool/Helper/utils.js | 891 |
| Tela de Login SIP | Page/Form/Login/SIPLoginPage.qml | 480 |
| Lista de Contatos | Page/Main/Contact/ContactPage.qml | 948 |
| Interface de Reunião | Page/Main/Meeting/MeetingPage.qml | 958 |

## STYLE SYSTEM
DefaultStyle.qml sets the active theme for the whole application. Themes.qml contains the "tsi" palette. AppIcons.qml maps internal names to image paths like image://internal/ixphoneLogo. Typography.qml handles font scaling and styles.

## NAVIGATION PATTERN
MainWindow.qml uses a StackView named mainWindowStackView. Initial routing chooses between welcomePage, sipLoginPage, or mainPage based on account status. Transitions usually use StackView.Immediate to skip animations.

## POPUP/NOTIFICATION PATTERN
Popup.qml serves as the base for all overlays. Specialized versions like LoadingPopup and Dialog extend it. Notifier C++ class triggers system notifications like NotificationReceivedCall. These components handle their own visibility logic.

## TSI CUSTOMIZATIONS (NUNCA REVERTER)
- Theme fixed to "tsi" in DefaultStyle.qml, ignoring SettingsCpp.
- AppIcons.qml includes IXPHONE, ixphoneWordmark, and Mamute logos.
- LoginLayout.qml shows IXPHONE wordmark and Mamute footer.
- WelcomePage.qml replaced carousel with a single IXPHONE logo slide.
- SIPLoginPage.qml hides the account creation button (visible: false).
- Notifications use applicationName variable instead of "Linphone" string.

## COMPLEX FILES (>400 linhas)
- CallsWindow.qml (1880L): Handles all call UI states and video windows.
- MainLayout.qml (809L): Manages the main application structure and navigation.
- ContactPage.qml (948L): Feature heavy screen for contact management.
- MeetingPage.qml (958L): Complex layout for multi party meetings.
- RecordPage.qml (796L): Logic for call recordings list.
- utils.js (891L): Shared Javascript utility functions for UI logic.
- ChatMessage.qml (588L): Individual chat bubble logic and rendering.

## KNOWN TODOS
- MainWindow.qml: Needs better security mode handling and C++ integration.
- MeetingPage.qml: Layout requires spacing adjustments.
- utils.js: Contains pending async implementation tasks.
- Sticker.qml: Needs size and decoration updates.
- ChatDroppableTextArea.qml: Refactor large text handling.
