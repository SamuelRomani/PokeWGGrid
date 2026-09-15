<div align="center">

<img src="tray.png" width="72" alt="PokeWGGrid">

# PokeWGGrid

**Duas contas de um jogo idle em uma janela só.**

![Plataforma](https://img.shields.io/badge/Windows%20%C2%B7%20macOS%20%C2%B7%20Linux-0078D6)
![Electron](https://img.shields.io/badge/Electron-43-47848F)
[![Licença](https://img.shields.io/badge/licen%C3%A7a-MIT-blue)](LICENSE)

[English](README.en.md)

</div>

> O jeito recomendado é rodar a partir do código: você pega, olha o que ele faz e roda você mesmo, sem precisar confiar cegamente em ninguém. Também existe um **[.exe portátil](https://github.com/SamuelRomani/PokeWGGrid/releases/tag/latest)**, gerado automaticamente pelo GitHub a cada mudança no código deste repositório (não é build minha, é pública) — útil se você não quer mexer com Node.js, mas aí a confiança fica em quem builda: o próprio GitHub Actions, com o log de cada build público.

> 🔰 **Nunca mexeu com isso?** Tem um passo a passo pra leigo aqui: **[TUTORIAL.md](TUTORIAL.md)** (ou o arquivo `COMO USAR.txt` dentro da pasta).

> ### 🔒 Seus dados de login ficam só no seu computador
> Login e senha são criptografados no seu próprio PC e nunca saem dele. Nada de servidor, nada de repositório. O código está todo aqui pra você conferir.

## O que é

Duas contas rodando ao mesmo tempo, cada uma no seu quadrante e com sessão separada. Você salva o login uma vez e o app entra sozinho nas próximas. Se a sessão cair no meio do farm, ele loga de novo sem você precisar estar por perto. Ele não joga por você — não automatiza nenhuma ação dentro do jogo, nem toca no captcha — só organiza as contas que você já tem.

Este projeto é derivado do [IdleGrid](https://github.com/SamuelRomani/IdleGrid), o mesmo organizador de contas, mas apontado pro **pokewg.com** em vez de outro jogo, com o limite de contas reduzido a 2 e sem nenhuma automação extra (o IdleGrid tem algumas, opcionais, específicas de outro jogo). O login automático funciona em qualquer formulário padrão — não depende de nada específico deste jogo.

## Como rodar

Você precisa do Node.js instalado uma vez. Depois é rápido.

**1. Instale o Node.js**
Baixe a versão LTS em [nodejs.org](https://nodejs.org) e instale (é next, next, finish).

**2. Baixe este código**
Clique no botão verde **Code** aqui em cima e depois em **Download ZIP**. Extraia a pasta onde quiser. Quem usa Git pode clonar:

```bash
git clone https://github.com/SamuelRomani/PokeWGGrid.git
```

**3. Abra o app**
No Windows, dê dois cliques no arquivo **Abrir PokeWGGrid** (`.vbs`) dentro da pasta. Na primeira vez ele instala o necessário e abre sozinho; nas próximas abre na hora, sem janela preta. Quer um atalho? Botão direito nele, **Enviar para: Área de trabalho (criar atalho)**.

Também dá pra usar o **iniciar.bat**, mas ele mantém uma janela preta aberta e, se ela for fechada, o app fecha junto.

No macOS ou Linux, abra o terminal na pasta e rode:

```bash
bash iniciar.sh
```

Pronto. Entre ou crie uma conta em cada painel e, em "Contas", salve o login. Da próxima vez ele entra sozinho.

## O que ele faz

- Rode 1 ou 2 contas, você escolhe quantos painéis abrir.
- Login automático, mesmo quando a sessão expira no meio do farm.
- Mostra a própria versão na barra de cima e avisa quando o `main` do repositório está mais novo. No Windows, o botão de atualizar (com confirmação antes) faz sozinho: código-fonte usa `git pull` (ou baixa o ZIP de novo, se não for um clone); `.exe` portátil baixa a versão nova (publicada como release a cada push no `main`) e troca o arquivo antigo pelo novo.
- Modo Eco que segura o uso de CPU sem atrapalhar o progresso.
- Avisa por notificação quando uma conta cai.
- Liga e desliga cada painel, zoom, tela cheia e atalhos de teclado.
- Rode seus próprios userscripts em cada painel (menu Scripts / Extras).
- Bandeja, iniciar junto com o Windows e idioma português, inglês ou espanhol.

## Segurança

- As senhas são criptografadas pelo `safeStorage` do Electron, que usa a API do sistema (DPAPI no Windows). Nunca saem do PC.
- Os painéis ficam presos ao domínio do jogo. Link externo abre no seu navegador, e a senha só é digitada na tela de login oficial.
- Câmera, microfone, localização e notificações do jogo ficam bloqueados.
- O captcha é sempre você que resolve. O app preenche e aperta Entrar quando os campos estão certos, mas nunca toca no "Confirme que é humano". Burlar detecção de bot não é a proposta.

## Por dentro

Cada painel é um `<webview>` do Electron com partição própria (`persist:conta1` e `conta2`), e é isso que mantém as contas isoladas e logadas entre aberturas. O Eco troca o `requestAnimationFrame` por uma versão mais lenta, e o login preenche pelo setter nativo do input (campos `autocomplete=username`/`current-password`, ou o primeiro campo de texto/senha do formulário como alternativa). Está tudo em `main.js`, `preload.js` e `index.html`, sem nada escondido.

## Licença

MIT. Projeto independente.
