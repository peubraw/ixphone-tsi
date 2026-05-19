# LINPHONE/MODEL — Knowledge Base

## OVERVIEW
Camada de wrap do SDK. Roda exclusivamente na thread do SDK. Ponte entre liblinphone (C API) e o core/ Qt.

## WHERE TO LOOK
| Tarefa | Local |
|--------|-------|
| Ciclo de vida do SDK | `Linphone/model/core/CoreModel.cpp` |
| Gestão de contas SIP | `Linphone/model/account/AccountModel.cpp` |
| Autenticação e OIDC | `Linphone/model/account/AccountManager.cpp` |
| Estado de chamada/mídia | `Linphone/model/call/CallModel.cpp` |
| Mensagens e IMDN | `Linphone/model/chat/ChatModel.cpp` |
| Configurações expostas | `Linphone/model/setting/SettingsModel.cpp` |
| Mídia, avatar e codecs | `Linphone/model/tool/ToolModel.cpp` |

## KEY CLASSES
- **CoreModel**: Singleton principal. Gerencia init/stop do SDK e despacha eventos.
- **AccountModel**: Gerencia proxy config e status de registro.
- **CallModel**: Controla parâmetros de chamada e qualidade de serviço.
- **SettingsModel**: Interface para todas as preferências do app.
- **SafeObject**: Classe base para persistência thread-safe de objetos de valor.
- **Listener<T>**: Template para mapear callbacks da C API para signals Qt.

## THREADING RULE
**NUNCA** acesse classes de `model/` fora da thread do SDK.
Use obrigatoriamente `invokeToModel()` para chamadas vindas da UI ou do core/.
Cada classe recebe seu par do SDK no construtor e emite signals para notificar mudanças.

## CONVENTIONS
- Criação sempre via `QSharedPointer` + factory:
  `auto model = Utils::makeQObject_ptr<AccountModel>(sdkAccount);`
- Nomes de arquivos seguem o padrão `PascalCaseModel`.
- Subdiretórios organizados por domínio (call/, chat/, account/).

## ANTI-PATTERNS
- **NÃO** use `new` direto sem smart pointers.
- **NÃO** acesse o core/ diretamente de dentro do model/ (use signals).
- **NÃO** bloqueie a thread do SDK com operações síncronas pesadas.
- **NÃO** exponha tipos puros da liblinphone para fora do model/.
