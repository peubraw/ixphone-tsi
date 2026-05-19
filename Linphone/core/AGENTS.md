# LINPHONE/CORE — Knowledge Base

## OVERVIEW
Camada de ligação MVVM: bridge entre model/ (thread SDK) e view/ (thread UI). Cada entidade possui um correspondente *Core que expõe propriedades (Q_PROPERTY) e slots para consumo direto no QML.

## ARCHITECTURE
```text
[ VIEW (UI Thread) ] <--> [ CORE (Bridge/Logic) ] <--> [ MODEL (SDK Thread) ]
        |                         |                          |
   QML / Signals          SafeConnection / invoke      Linphone SDK C API
```

## WHERE TO LOOK
| Tarefa / Domínio | Subdiretório em `Linphone/core/` |
|:--- |:--- |
| Contas / Identidade | `account/`, `login/`, `register/`, `proxy/` |
| Chamadas / Mídia | `call/`, `camera/`, `videoSource/`, `sound-player/` |
| Histórico / Stats | `call-history/`, `fps-counter/`, `event-count-notifier/` |
| Mensagens / Chat | `chat/`, `emoji/`, `event-filter/` |
| Contatos / Busca | `friend/`, `phone-number/`, `search/` |
| Conferências | `conference/`, `participant/` |
| Configurações | `setting/`, `variant/`, `path/` |
| Notificações | `notifier/` |
| Sistema / Internals | `logger/`, `timezone/`, `translator/`, `singleapplication/`, `screen/` |
| Gravação | `recorder/` |

## KEY CLASSES
- **App** (App.cpp) — Singleton principal, gerencia ciclo de vida, janelas e engine QML.
- **CoreModel** (model/core/) — Interface direta com o SDK, executa na thread exclusiva do SDK.
- **SafeConnection** — Template para comunicação thread-safe entre Core e Model.
- **AbstractObject** — Classe base para logging unificado com suporte a getClassName().
- **SafeObject** — QObject especializado com getters/setters protegidos para acesso cross-thread.
- **SettingsCore** — Fachada que expõe configurações persistentes do linphonerc para a UI.
- **Notifier** — Despachante de notificações nativas do sistema operacional.

## THREADING PATTERN
Utilize `SafeConnection` para evitar race conditions entre as threads de UI e SDK.

```cpp
// De UI para Model (executa na thread do SDK)
mCoreModelConnection->invokeToModel([=] {
    mModel->doAction();
});

// De Model para UI (executa na thread principal do Qt)
mCoreModelConnection->invokeToCore([=] {
    mCore->updateProperty(value);
});
```

## CONVENTIONS
- **Prefixos**: `m` para membros de classe (mCore), `g` para globais/estáticos.
- **Macros**: `DECLARE_GUI_OBJECT(Class)` para exportar para QML; `DEFINE_ABSTRACT_OBJECT` para logging.
- **Naming**: Classes Core terminam em `Core` (ex: `CallCore.cpp`).
- **Acesso**: Use `setValue`/`getValue` em objetos derivados de `SafeObject`.

## ANTI-PATTERNS
- **Acesso Direto**: Nunca chame métodos do SDK (linphone-sdk) diretamente da thread de UI.
- **Bloqueios**: Não realize operações de IO ou rede síncronas na thread principal (App.cpp).
- **QObject Parent**: Cuidado ao passar parents entre threads. Objetos criados em `invokeToModel` pertencem à thread do SDK.
- **Signals**: Evite emitir sinais de UI de dentro da thread do SDK sem usar `invokeToCore`.
