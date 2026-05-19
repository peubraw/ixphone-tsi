# PROJECT KNOWLEDGE BASE — IXPHONE Desktop

**Generated:** 2026-05-19
**Upstream:** https://github.com/BelledonneCommunications/linphone-desktop (commit `671db3b56`)
**Branch:** master
**Brand:** IXPHONE (TSI) — fork do linphone-desktop para Windows/macOS/Linux

## OVERVIEW
Linphone Desktop — softphone SIP de código aberto (chamadas voz/vídeo, mensagens, conferências). C++17 + Qt6 QML + Linphone native SDK (via cmake submodule). **Este repo é o fork TSI** — ver "TSI FORK CHANGES" abaixo.

## STACK
- **Linguagem:** C++17 + QML (Qt6 6.10+)
- **Build system:** CMake
- **UI pattern:** MVVM — C++ (model/core) ↔ QML (view)
- **SDK:** linphone-sdk (submodule em `external/linphone-sdk`, requer `git submodule update --init --recursive`)
- **Plataformas:** Windows (VS2022 + x64), macOS, Linux

## STRUCTURE
```
ixphone-desktop/
├── CMakeLists.txt              # Config principal: nome/executável do app
├── Linphone/
│   ├── application_info.cmake  # Vendor, descrição, URLs, ID da aplicação
│   ├── core/                   # C++ — lógica SDK (App.cpp, constantes, etc.)
│   ├── view/                   # QML — toda a UI
│   │   ├── Style/              # Themes.qml, DefaultStyle.qml, AppIcons.qml
│   │   ├── Page/               # Telas (WelcomePage, SIPLoginPage, MainWindow, etc.)
│   │   └── Control/Popup/Notification/  # NotificationReceived*.qml
│   └── data/
│       ├── config/linphonerc-factory  # Config padrão SIP/app
│       ├── image/              # SVGs: linphone.svg, splashscreen-logo.svg, etc.
│       ├── icon/               # icon.ico (Windows) + hicolor/
│       └── languages/          # Traduções Qt (.ts) — pt_BR.ts, en.ts, fr.ts, etc.
├── cmake/                      # Scripts auxiliares de build
├── external/linphone-sdk       # Submodule (SDK nativo — ~vários GB, baixar só para build)
└── docker-files/               # Ambientes CI Docker
```

## WHERE TO LOOK
| Tarefa | Local |
|--------|-------|
| Nome/executável do app | `CMakeLists.txt` linhas ~74-75 |
| Vendor, descrição, URL, ID | `Linphone/application_info.cmake` |
| Config SIP padrão | `Linphone/data/config/linphonerc-factory` |
| Tela de boas-vindas (carrossel) | `Linphone/view/Page/Main/Start/WelcomePage.qml` |
| Login SIP terceiro | `Linphone/view/Page/Form/Login/SIPLoginPage.qml` |
| Registro de conta | `Linphone/view/Page/Form/Register/RegisterPage.qml` |
| Notificação de chamada recebida | `Linphone/view/Control/Popup/Notification/NotificationReceivedCall.qml` |
| Notificação de mensagem | `Linphone/view/Control/Popup/Notification/NotificationReceivedMessage.qml` |
| Temas de cores | `Linphone/view/Style/Themes.qml` |
| Ícones/assets SVG | `Linphone/data/image/` |
| Traduções pt-BR | `Linphone/data/languages/pt_BR.ts` |

## COMMANDS (quando prereqs instalados)
```bash
# Baixar SDK (obrigatório para build):
git submodule update --init --recursive

# Build Windows (VS2022 Developer Command Prompt):
mkdir build ; cd build
cmake .. -DCMAKE_BUILD_PARALLEL_LEVEL=10 -DCMAKE_BUILD_TYPE=RelWithDebInfo -A x64
cmake --build . --target ALL_BUILD --parallel 10 --config RelWithDebInfo

# Saída em: build/OUTPUT/bin/ixphone.exe
```

## PREREQS (WINDOWS) — AINDA NÃO INSTALADOS
| Ferramenta | Versão requerida | Status |
|------------|-----------------|--------|
| Visual Studio | **2022** (VS 2019 NÃO suportado) | ❌ Faltando |
| Qt6 | **6.10.0+** com qtnetworkauth + qtshadertools | ❌ Faltando |
| MSYS2 | Qualquer recente | ❌ Faltando |
| CMake | 3.22+ | ❌ Faltando |
| Git | 2.51+ | ✅ Instalado |

> Para instalar: ver README.md seção "Specific instructions for the Windows platform"

## TSI FORK CHANGES
TSI/IXPHONE-specific deltas vs upstream. **Anchor commit:** `671db3b56` (upstream) + customizações IXPHONE aplicadas em 2026-05-19.

### Branding (cmake/config)
| Arquivo | Mudança |
|---------|---------|
| `CMakeLists.txt` | `LINPHONEAPP_APPLICATION_NAME` = **"IXPHONE"**; `LINPHONEAPP_EXECUTABLE_NAME` = **"ixphone"** |
| `Linphone/application_info.cmake` | `APPLICATION_VENDOR` = "TSI"; `APPLICATION_DESCRIPTION` = "IXPHONE - Softphone TSI"; `APPLICATION_URL` = "https://www.tsi.com.br"; `APPLICATION_ID` = "br.com.tsi.ixphone"; `APPLICATION_START_LICENCE` = "2024" |
| `Linphone/data/image/` | **TODO:** Substituir `linphone.svg`, `splashscreen-logo.svg`, `login_image.svg`, `belledonne.svg` por assets IXPHONE |
| `Linphone/data/icon.ico` | **TODO:** Substituir pelo ícone IXPHONE (Windows) |

### Config SIP (linphonerc-factory)
- `[account_creator]` URL removida (não usa contas linphone.org)
- `[sip] rls_uri` → `sips:rls@10.168.11.1`
- `[ui] assistant_third_party_sip_account_domain_fallback` = `10.168.11.1` (fallback TSI, mesmo que Android)
- Comentário `ec_calibrator_cool_tones` limpo (era específico de Linphone público)

### Behavioral / QML changes
| Arquivo | Mudança |
|---------|---------|
| `NotificationReceivedCall.qml` | `text: "Linphone"` → `text: applicationName` |
| `NotificationReceivedMessage.qml` | `text: "Linphone"` → `text: applicationName` |
| `WelcomePage.qml` | Carrossel reduzido de **3 para 2 slides** (removido slide "Open Source depuis 2001") |
| `SIPLoginPage.qml` | Texto botão `"linphone.org/contact"` → `"tsi.com.br/contato"` |
| `RegisterPage.qml` | Domínio padrão `"@sip.linphone.org"` → `"@10.168.11.1"` |

### Traduções (pt_BR.ts)
- `welcome_page_1_message`: "Un aplicativo francês..." → "Softphone corporativo **seguro** e **confiável** para a sua empresa."

## ASSETS PENDENTES (TODO)
Os seguintes SVG/ICO precisam ser criados/substituídos com assets IXPHONE:
- `Linphone/data/image/linphone.svg` — logo principal (carrossel boas-vindas)
- `Linphone/data/image/splashscreen-logo.svg` — splash screen
- `Linphone/data/image/login_image.svg` — imagem da tela de login
- `Linphone/data/image/belledonne.svg` — logo "sobre" (substituir por logo TSI)
- `Linphone/data/icon.ico` — ícone Windows (taskbar/arquivo)
- `Linphone/data/icon/hicolor/` — ícones Linux (PNG 16x16 a 512x512)

## TSI ANTI-PATTERNS
- **Nunca** restaurar `LINPHONEAPP_APPLICATION_NAME "Linphone"` ou `EXECUTABLE_NAME "linphone"`.
- **Nunca** restaurar URL `https://subscribe.linphone.org/api/` no `[account_creator]`.
- **Nunca** restaurar `rls_uri=sips:rls@sip.linphone.org`.
- **Nunca** restaurar o 3º slide do carrossel ("Open Source depuis 2001").
- **Não** restaurar `"linphone.org/contact"` no SIPLoginPage.
- Ao sincronizar com upstream, esperar conflitos em: `CMakeLists.txt`, `application_info.cmake`, `linphonerc-factory`, `WelcomePage.qml`, `Notification*.qml`, `pt_BR.ts`.

## SINCRONIZAÇÃO COM UPSTREAM
```bash
git remote add upstream https://github.com/BelledonneCommunications/linphone-desktop.git
git fetch upstream
git rebase upstream/master
# Resolver conflitos nos arquivos listados em TSI ANTI-PATTERNS acima
```
