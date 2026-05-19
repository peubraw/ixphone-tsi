# LINPHONE/DATA — Knowledge Base

## OVERVIEW
Assets estáticos e configuração de fábrica. Nenhum código compilado nesta estrutura.

## WHERE TO LOOK
| Tarefa | Local |
|--------|-------|
| Configuração SIP de fábrica | `config/linphonerc-factory` |
| Logos e ilustrações da UI | `image/` |
| Ícones funcionais da UI | `image/icons/` |
| Traduções da interface | `languages/` |
| Ícone do executável (Windows/Linux) | `icon/` |
| Fontes e emojis | `font/`, `emoji/` |
| Shaders GLSL | `shaders/` |

## LINPHONERC-FACTORY (seções relevantes)
- `[sip]`: rls_uri=sips:rls@10.168.11.1 (TSI)
- `[account_creator]`: Sem URL. Proibido usar contas linphone.org.
- `[ui]`: assistant_third_party_sip_account_domain_fallback=10.168.11.1
- `[video]`, `[audio]`, `[net]`: Configurações de mídia padrão da TSI.

## ASSETS QML (image/)
- `linphone.svg`: Logo principal do carrossel/welcome.
- `splashscreen-logo.svg`: Exibido no splash screen.
- `login_image.svg`: Imagem lateral na tela de login.
- `belledonne.svg`: Logo "Sobre" (Placeholder TSI).
- `logo.svg` / `logo_margins.svg`: Base para ícones com margens.
- `secured.svg`, `lock.svg`: Indicadores de segurança TLS/ZRTP.
- `icons/`: ~20 ícones funcionais (call, chat, contacts, settings, etc).

## BRAND ASSETS TSI
Assets específicos da marca IXPHONE injetados no fork:
- `ixphone_logo.png`: Logo quadrado principal.
- `ixphone_logo_square.png`: Variante quadrada otimizada.
- `ixphone_wordmark.png`: Wordmark horizontal.
- `mamute_logo.png` / `mamute_logo_branco.png`: Logos do parceiro Mamute.

## ÍCONES DO EXECUTÁVEL (icon/)
- `icon.ico`: Ícone para Windows (Taskbar e Windows Explorer).
- `hicolor/`: Diretório de ícones Linux (16x16 até 1024x1024 PNG).

## TRADUÇÕES (languages/)
Arquivos Qt `.ts`. Foco em `pt_BR.ts` e `en.ts`.
**Workflow:**
1. Editar `.ts` manualmente ou via Qt Linguist.
2. Build target `update_translations`: Sincroniza QML/C++ com os `.ts`.
3. Build target `release_translations`: Gera os arquivos binários `.qm`.

## ADICIONAR NOVO ASSET QML
1. Salvar em `image/` ou `image/icons/`.
2. Registrar em `Linphone/view/Style/AppIcons.qml` como `property string`.
3. Referenciar no QML via `AppIcons.nomeDoAsset`.

## TSI ANTI-PATTERNS
- **NUNCA** alterar `rls_uri` para `sips:rls@sip.linphone.org`.
- **NUNCA** adicionar URL em `[account_creator]`.
- **NUNCA** remover ou renomear `ixphone_logo.png`, `ixphone_wordmark.png` ou `mamute_logo.png`.
