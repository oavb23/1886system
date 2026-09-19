-- Estrutura inicial do banco (MVP)
-- Toda tabela tem oficina_id: é isso que separa os dados de cada conta.

CREATE TABLE IF NOT EXISTS oficinas (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  cnpj TEXT,
  telefone TEXT,
  email TEXT,
  endereco TEXT,
  valor_hora REAL DEFAULT 0,
  plano_ativo_ate TEXT,
  criado_em TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS usuarios (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  oficina_id INTEGER NOT NULL REFERENCES oficinas(id),
  nome TEXT,
  email TEXT NOT NULL UNIQUE,
  senha_hash TEXT NOT NULL,
  criado_em TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS sessoes (
  token TEXT PRIMARY KEY,
  usuario_id INTEGER NOT NULL REFERENCES usuarios(id),
  expira_em TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS clientes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  oficina_id INTEGER NOT NULL REFERENCES oficinas(id),
  nome TEXT NOT NULL,
  telefone TEXT,
  email TEXT,
  documento TEXT,
  observacoes TEXT,
  criado_em TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS veiculos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  oficina_id INTEGER NOT NULL REFERENCES oficinas(id),
  cliente_id INTEGER NOT NULL REFERENCES clientes(id),
  placa TEXT NOT NULL,
  marca TEXT,
  modelo TEXT,
  ano INTEGER,
  km INTEGER,
  criado_em TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS servicos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  oficina_id INTEGER NOT NULL REFERENCES oficinas(id),
  nome TEXT NOT NULL,
  categoria TEXT,
  tempo_estimado REAL,
  preco_padrao REAL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS ordens_servico (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  oficina_id INTEGER NOT NULL REFERENCES oficinas(id),
  numero INTEGER NOT NULL,
  cliente_id INTEGER NOT NULL REFERENCES clientes(id),
  veiculo_id INTEGER NOT NULL REFERENCES veiculos(id),
  status TEXT NOT NULL DEFAULT 'orcamento',
  km_entrada INTEGER,
  previsao_entrega TEXT,
  relato TEXT,
  desconto REAL DEFAULT 0,
  total REAL DEFAULT 0,
  forma_pagamento TEXT,
  pago INTEGER DEFAULT 0,
  criado_em TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS os_itens (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  os_id INTEGER NOT NULL REFERENCES ordens_servico(id),
  tipo TEXT NOT NULL CHECK (tipo IN ('servico','peca')),
  descricao TEXT NOT NULL,
  quantidade REAL DEFAULT 1,
  valor_unitario REAL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_clientes_oficina ON clientes(oficina_id);
CREATE INDEX IF NOT EXISTS idx_veiculos_placa ON veiculos(oficina_id, placa);
CREATE INDEX IF NOT EXISTS idx_os_oficina ON ordens_servico(oficina_id, status);
