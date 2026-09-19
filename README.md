# Sistema da Oficina

Sistema de gestão para oficinas (clientes, veículos, ordens de serviço).

## Estrutura

- `public/` — front-end (HTML, CSS, JS). Hoje contém o wireframe.
- `functions/api/` — back-end (Cloudflare Pages Functions). Cada arquivo vira uma rota `/api/...`.
- `db/schema.sql` — estrutura do banco D1.
- `wrangler.toml` — configuração da Cloudflare (pasta publicada e banco).

## Configuração na Cloudflare Pages

- Build command: (vazio)
- Build output directory: `public`

## Teste

Depois do deploy, abra `/api/status` no seu domínio `.pages.dev`.
