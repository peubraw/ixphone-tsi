# LINPHONE/VIEW — Knowledge Base

## OVERVIEW
Camada de UI do IXPHONE. Construída em QML + Qt6. Segue o padrão MVVM: C++ cuida da lógica central (core/) e QML cuida da view. Todos os componentes visuais residem aqui.

## ESTRUTURA
- `Style/` — Tokens de design, temas e registro de ícones.
- `Control/` — Componentes reutilizáveis (Botões, Inputs, Popups).
- `Page/` — Telas completas, shells de janela e layouts complexos.
- `Test/` — Demos isolados de componentes para desenvolvimento.

## WHERE TO LOOK
| Tarefa | Arquivo |
| :--- | :--- |
| Shell principal e roteamento | `Page/Window/MainWindow.qml` |
| Janela de chamada ativa | `Page/Window/Call/CallsWindow.qml` |
| Layout principal (nav + painel) | `Page/Layout/MainLayout.qml` |
| Tokens de design e cores base | `Style/DefaultStyle.qml` |
| Registro de imagens e ícones | `Style/AppIcons.qml` |
| Lógica JS de suporte à UI | `Control/Tool/Helper/utils.js` |
| Tela de login SIP | `Page/Form/Login/SIPLoginPage.qml` |
| Lista de contatos | `Page/Main/Contact/ContactPage.qml` |
| Interface de reunião | `Page/Main/Meeting/MeetingPage.qml` |

## SISTEMA DE ESTILOS
`DefaultStyle.qml` define o tema ativo para toda a aplicação. `Themes.qml` contém a paleta `"tsi"`. `AppIcons.qml` mapeia nomes internos para caminhos de imagem (ex: `image://internal/ixphoneLogo`). `Typography.qml` controla escala e estilos de fonte.

## PADRÃO DE NAVEGAÇÃO
`MainWindow.qml` usa uma `StackView` chamada `mainWindowStackView`. O roteamento inicial escolhe entre `welcomePage`, `sipLoginPage` ou `mainPage` com base no status da conta. Transições geralmente usam `StackView.Immediate` para evitar animações.

## PADRÃO DE POPUP/NOTIFICAÇÃO
`Popup.qml` é a base de todos os overlays. Versões especializadas (`LoadingPopup`, `Dialog`) o estendem. A classe C++ `Notifier` dispara notificações nativas do sistema (ex: `NotificationReceivedCall`). Cada componente controla sua própria visibilidade.

## TSI CUSTOMIZATIONS (NUNCA REVERTER)
- Tema fixado em `"tsi"` no `DefaultStyle.qml`, ignorando `SettingsCpp`.
- `AppIcons.qml` inclui logos IXPHONE, ixphoneWordmark e Mamute.
- `LoginLayout.qml` exibe wordmark IXPHONE e rodapé Mamute.
- `WelcomePage.qml` substituiu o carrossel por um único slide com o logo IXPHONE.
- `SIPLoginPage.qml` oculta o botão de criação de conta (`visible: false`).
- Notificações usam `applicationName` em vez da string literal `"Linphone"`.

## ARQUIVOS COMPLEXOS (>400 linhas)
- `CallsWindow.qml` (~1880L): Gerencia todos os estados de chamada e vídeo.
- `MeetingPage.qml` (~958L): Layout complexo para reuniões multiparticipantes.
- `ContactPage.qml` (~948L): Tela densa para gerenciamento de contatos.
- `utils.js` (~891L): Utilitários JavaScript compartilhados pela UI.
- `MainLayout.qml` (~809L): Estrutura principal e navegação do app.
- `RecordPage.qml` (~796L): Lógica para lista de gravações de chamadas.
- `ChatMessage.qml` (~588L): Lógica e renderização de balão de chat.

## ANTI-PATTERNS
- Nunca acesse objetos C++ core/ diretamente sem passar por signals/Q_PROPERTY.
- Não crie bindings circulares em propriedades QML — causam loops infinitos.
- Não use `Qt.callLater` para esconder race conditions; corrija a causa raiz.
