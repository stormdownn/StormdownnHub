# 🌩️ StormdownnHub V1

StormdownnHub é um HUB de scripts para Roblox criado por **STORMDOWNN** com design estilizado, interface moderna e funcionalidades poderosas. Este é o repositório da versão **V1**, estruturado para receber atualizações futuras (V2, V3...) com código modular.

---

## 🚀 Funcionalidades

- 🔐 **Tela de login** com senha personalizada (`stormdownn`)
- 🖼️ **Visual tech moderno** com blur, cantos arredondados, gradientes e efeito clean
- 📦 **Painel de scripts com scroll interno** para manter tudo organizado
- 🔄 **Botão flutuante com imagem do HUB (Aizawa)** que **minimiza/expande** o painel principal (estilo GhostHub/RaelHub)
- 🌗 **Modo tema claro/escuro** que afeta toda a interface
- 🌍 **Localização automática via IP (detecção por Wi-Fi)**
- ⚙️ **Tela de configurações** com:
  - Criadores (Stormdownn e ChatGPT)
  - Nome do usuário
  - Localização
  - Troca de tema
- 📁 **Código modular**, pronto para reuso em versões futuras (ex: StormdownnHub_V2)

---

## 📂 Como usar

1. Suba o arquivo `core.lua` neste repositório.
2. Copie o seguinte comando e cole no seu executador Roblox:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stormdownn/StormdownnHub_V1/main/core.lua"))()
