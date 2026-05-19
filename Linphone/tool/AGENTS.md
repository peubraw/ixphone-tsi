# LINPHONE/TOOL — Knowledge Base

## OVERVIEW
Biblioteca interna de utilitários genéricos. Independente do SDK Linphone. Usada por Model, Core e View. Contém o "coração" utilitário do app (Utils.cpp) e a base de logging (AbstractObject).

## WHERE TO LOOK
| Tarefa | Local |
|--------|-------|
| Funções Q_INVOKABLE (Avatar, Data, Windows) | `Utils.hpp` / `Utils.cpp` |
| Macros de Classe e Logging | `AbstractObject.hpp` |
| Enums Qt (SIP/Chat/Call) | `LinphoneEnums.hpp` |
| Image Providers (QML) | `providers/` |
| Gestão de Singletons/Paths | `managers/` |

## KEY UTILITIES (Utils.hpp)
Métodos estáticos expostos ao QML via `Utils` singleton:
- `createAvatar(sipAddress)`: Gera iniciais/cores para contatos sem foto.
- `openAvatarFilePicker()`: (TSI) Abre seletor de arquivos nativo para fotos de perfil.
- `formatElapsedTime(seconds)`: Formata tempo de chamada (HH:mm:ss).
- `smartShowWindow()`: Garante que a janela principal venha para o topo no Windows.
- `getMainWindow()`: Retorna o ponteiro `QWindow` da aplicação.
- `haveAccount()`: Checa existência de contas configuradas.

## ABSTRACT OBJECT PATTERN
Base obrigatória para quase todas as classes do projeto. Provê logging padronizado.

**No Header (.hpp):**
```cpp
class MyClass : public AbstractObject {
  Q_OBJECT
  DECLARE_ABSTRACT_OBJECT // Ou DECLARE_GUI_OBJECT se exposta ao QML
public:
  MyClass(QObject *parent = nullptr);
};
```

**No Source (.cpp):**
```cpp
DEFINE_ABSTRACT_OBJECT(MyClass)
MyClass::MyClass(QObject *parent) : AbstractObject(parent) {
  lInfo() << "Objeto instanciado";
}
```

## PROVIDERS
Registrados em `App.cpp`, permitem carregar imagens/assets via URL `image://`:
- `AvatarProvider`: Resolve `image://avatar/<sip_address>`.
- `ImageProvider`: Cache e carregamento de imagens genéricas.
- `QExifImageHeader`: Usado internamente para rotacionar fotos baseadas em metadados EXIF.

## TSI ADDITIONS
- **Utils::openAvatarFilePicker()**: Criado para substituir o `FileDialog` do `QtQuick.Dialogs`, que apresentava instabilidades e bugs de foco no Windows 10/11. Centraliza a lógica de seleção de imagem em C++ para garantir comportamento nativo e estável em telas de edição de contato e configurações de conta.
