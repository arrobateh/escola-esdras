# Hinários — análise e preparação

## Importação disponível

Executar **`supabase/import_inspiracoes_9.sql`** no SQL Editor do Supabase, depois da migração já aplicada. É um único arquivo transacional: cadastra as letras e os vínculos, publica a edição e somente o lote conferido. Não requer alterar o app.

Resultado esperado para o catálogo inicialmente vazio:

- **325 hinos/vínculos** identificados na digitalização, mantendo os números da fonte.
- **10 hinos publicados**, números 1 a 10, transcritos e conferidos visualmente nas páginas PDF 3–6, incluindo as continuações de 3 e 5.
- **315 rascunhos** com OCR ainda não conferido integralmente. Permanecem ocultos no app.
- **233, 234, 235 e 236 não foram criados**: a página PDF 114 termina no 232 e a 115 começa no 237. Não preencher essa lacuna com letras inventadas nem renumerar a edição.
- Nenhum crédito individual de compositor foi presumido. Os dez hinos ficam acessíveis por “Todos os hinários” e “Autoria não confirmada”. O crédito editorial do Pr. Márcio continua nos detalhes da edição.

O script termina com uma consulta de contagem por estado. Foi validado duas vezes em PostgreSQL 16 local, conferindo contagens e preservação das quebras de estrofe. Não foi executado no Supabase remoto pelo agente. Com as tabelas vazias confirmadas pelo usuário, este arquivo supre a importação que faltava; apenas executar a migração anterior não adicionava letras.

Após executar, sair da seção Hinários e abri-la novamente ou usar a atualização da lista. O app deve listar os dez publicados. Conferir no celular antes de avançar para novos lotes. Os 315 rascunhos restantes **não estão prontos para publicação em massa**: há palavras, títulos, estrofes e limites afetados pelo OCR.

Arquivos de trabalho em `docs/hinarios/inspiracoes-9/`:

| Arquivo | Uso |
| --- | --- |
| `boundaries.json` | Número, página e linhas que delimitam a extração; linhas base zero |
| `catalog.draft.json` | 325 letras extraídas, todas como rascunho, com referências dos trechos |
| `reviewed.json` | Dez transcrições conferidas, usadas para substituir o OCR e publicar o primeiro lote |
| `ocr/` | Extração original por página, preservada para auditoria |

A digitalização intercala parte do hino 139 na página 66 e sua continuação na 69. Os trechos de 134, 138 e 139 são tratados explicitamente em `segment.py` para não anexar letras de hinos distintos. A coluna `page_start/page_end` registra o intervalo abrangente; `source_segments` no JSON conserva as referências exatas.

Reprodução a partir dos arquivos versionados:

```sh
python3 scripts/hinarios/segment.py docs/hinarios/inspiracoes-9
python3 scripts/hinarios/build_release.py docs/hinarios/inspiracoes-9 supabase/import_inspiracoes_9.sql
python3 -m unittest discover -s scripts/hinarios -p 'test_*.py'
```

Os dois primeiros comandos recriam arquivos gerados. Para revisar novos lotes, acrescentar apenas transcrições realmente conferidas a `reviewed.json`, com `review_status = "reviewed"`, e regenerar o SQL. `build_release.py` publica somente essa lista; não transforma todo o OCR em conteúdo conferido. A reexecução preserva letras que já estejam revisadas/publicadas no banco; correções posteriores dessas letras precisam de um UPDATE específico. Não editar somente o SQL gerado, pois a regeneração descartaria a edição.

O número “325” descreve as entradas identificadas nesta digitalização, não certifica a completude de outras cópias/edições do hinário. A revisão editorial completa e o cadastro de autoria individual continuam pendentes.

## Fonte analisada

- Hinário Inspirações, 9ª edição, fevereiro de 2019.
- A folha de rosto credita o Pastor Márcio de Barros Fuly.
- Drive: https://drive.google.com/file/d/1_SK93Hs-6o2CEoBwDPZ8Ou-m-VEGbSsm/view?usp=drivesdk
- 160 páginas digitalizadas, aproximadamente 61 MiB, sem camada de texto.
- Numeração final observada: 329, “JESUS ESTÁ AQUI”, iniciado na página PDF 159 e continuado na 160. Isso não comprova que todos os números intermediários estejam presentes.
- Conferência visual: capa, folha de rosto, páginas 3, 4, 159 e 160. A extração integral automática não equivale à revisão integral.
- Há vários hinos por página e letras que atravessam páginas. Refrões usam destaque visual; OCR não preserva isso com confiabilidade.
- Resolução e inclinação variam entre páginas; nas primeiras páginas há erros significativos de OCR, inclusive troca de palavras, ordem e quebras de versos.
- O usuário informou possuir autorização de uso nesta conversa.

O original foi preservado em `../../../docs/hinarios/fontes/inspiracoes-9.pdf`, relativo a esta pasta (fora do repositório Git `mobile`). O SHA-256 em `inspiracoes-9/ocr/source.json` identifica a versão exata. O arquivo de 61 MiB não será incluído no bundle do aplicativo.

## Decisão de armazenamento

Letras e metadados ficarão no **Supabase/PostgreSQL**. Markdown serve como arquivo intermediário de conferência, não como fonte do aplicativo. O PDF original poderá ficar em **Storage privado**, com URL temporária gerada quando necessário. O Drive atual é uma fonte de trabalho e não deve ser usado como hospedagem pública do app.

A migração `../../supabase/migration_hymnals.sql` contém:

| Tabela | Finalidade |
| --- | --- |
| `hymn_composers` | Pessoas e seus nomes |
| `hymnals` | Publicação, edição, crédito editorial e fonte |
| `hymns` | Título, letra em texto simples e estado de revisão |
| `hymnal_hymns` | Número e páginas do hino naquela edição |
| `hymn_credits` | Autoria de letra/música, tradução e adaptação |

Um hino pode aparecer em várias edições. O número pertence à edição. O nome na capa não é automaticamente atribuído como autor de todas as letras. Hinos sem autoria conferida podem aparecer como “Autoria não confirmada”, sem atribuições inventadas.

RLS: usuários autenticados consultam somente letras publicadas de edições publicadas; administrador mantém o catálogo. Letra precisa estar preenchida e ter data de revisão antes de passar para `reviewed` ou `published`. O cadastro inicial da edição permanece oculto (`published = false`). A migração depende do `public.is_admin()` existente. Não altera planos, Bíblia, perfil ou rastreamento.

## Plano por tela

1. **Entrada “Hinários”**: card no Início, seguindo as cores e Font Awesome 6 existentes. Evitar comprimir a barra atual com uma sexta aba. Essa posição é uma proposta para a primeira implementação.
2. **Compositores**: grid/lista de pessoas com hinos publicados; grupo separado para autoria não confirmada. Pesquisa por nome. Crédito editorial também aparece nos detalhes do hinário, sem ser confundido com autoria.
3. **Hinários do compositor**: título, edição e quantidade de hinos publicados. Ao entrar por compositor, filtrar pelos créditos dessa pessoa. Compartilhar a mesma edição entre compositores sem duplicá-la.
4. **Lista de hinos**: número, título, busca por número/título (ignorando caixa e acentos), ordenação numérica, carregamento paginado. Iniciar busca da letra apenas se necessário, sem baixar todo o catálogo em cada consulta.
5. **Leitura do hino**: número, título, autoria confirmada, edição e letra com estrofes preservadas. Tamanho de fonte ajustável, tema escuro e navegação anterior/próximo dentro do filtro atual. Sem marcação de leitura bíblica ou desafio.

Todas as telas devem distinguir carregamento, catálogo ainda em preparação, busca sem resultado, indisponibilidade de conexão e falha de consulta, com opção de tentar novamente. Favoritos, áudio, cifras, reprodução e cache offline completo ficam para etapa posterior. A primeira entrega usa rede, sem acoplar o catálogo ao sincronizador de progresso bíblico.

As telas foram adicionadas em `src/app/hinarios`, com acesso pelo card “Louvores da nossa igreja” no Início. O fluxo permite navegar por compositor ou todos os hinários, escolher uma edição, pesquisar por número/título e ler a letra com fonte ajustável (preferência salva no dispositivo). Anterior/próximo respeitam a edição e o filtro de compositor. O catálogo compartilha metadados entre as telas; as letras são consultadas apenas ao abrir o hino.

As consultas filtram explicitamente edição e hinos publicados, mesmo quando o usuário é administrador. Com apenas o seed inicial do SQL, a tela exibe “Hinários em preparação”. Não foram publicados textos do OCR automaticamente. O usuário informou ter executado a migração no Supabase; a aplicação remota não foi verificada por esta implementação.

## Extração e revisão

`inspiracoes-9/ocr/review.md` reúne o OCR por página. Os `.txt` individuais permitem retomar uma extração interrompida. Todos são rascunhos. Não importar esse Markdown diretamente como letras.

Para reproduzir, instalar localmente Poppler, Tesseract com idioma `por`, Pillow e numpy. O script aceita `--tesseract /caminho/do/binario`, usa até três trabalhadores por padrão e não envia os documentos a serviços externos:

```sh
python3 scripts/hinarios/extract.py /caminho/inspiracoes.pdf docs/hinarios/inspiracoes-9/ocr
```

Usar uma pasta nova ao mudar PDF ou parâmetros/versão do OCR. A retomada reutiliza páginas existentes; não refaz a extração automaticamente após mudanças no algoritmo.

Conferir no PDF, hino por hino: número, título, começo e fim da letra, continuidade, estrofes, refrões, repetições, pontuação e eventuais créditos. Não modernizar grafia ou corrigir o texto original por suposição. A amostra `inspiracoes-9/catalog.sample.json` tem três títulos iniciais conferidos e letras nulas, apenas para documentar o formato.

Após separar as letras, criar um `catalog.json` nesse formato e gerar o SQL:

```sh
python3 scripts/hinarios/prepare_import.py docs/hinarios/inspiracoes-9/catalog.json /tmp/import_hinarios.sql
python3 -m unittest discover -s scripts/hinarios -p 'test_*.py'
```

O gerador valida números únicos e intervalos de páginas, escapa o texto para SQL, usa UUIDs determinísticos e importa **apenas rascunhos**. Uma reexecução não atualiza registros existentes; correções posteriores devem ser feitas explicitamente pelo administrador. Não preenche autoria automaticamente. Conferir o SQL antes de executá-lo.

## Sequência para a implementação

1. Revisar um lote pequeno de letras para validar a experiência antes das 329 numerações.
2. Aplicar `migration_hymnals.sql` no Supabase; testar RLS com usuário comum e administrador (não apenas no SQL Editor como proprietário).
3. Importar o lote em rascunho, cadastrar créditos conferidos e testar consultas com `hymnal_hymns` e `hymns!inner`. Associações de uma edição publicada podem existir antes da publicação da letra; sempre filtrar/juntar as letras publicadas.
4. Conferir as telas implementadas em celular, com letras longas e fonte ampliada.
5. Preencher `reviewed_at`, mudar os hinos conferidos para `published` e publicar a edição. O restante continua oculto.
6. Validar que usuário comum não lê rascunhos nem altera letras ou créditos. Testar também hino publicado em edição não publicada (deve ficar invisível).
7. Continuar revisão/importação por lotes. Configurar Storage privado e download do original somente se essa função entrar no escopo.

O Storage, seu upload e políticas ainda não foram criados. A migração foi executada duas vezes com sucesso em PostgreSQL 16 local isolado, incluindo a importação de exemplo, para verificar sintaxe e reexecução. Esse ambiente usou o modo standalone e um substituto local para `is_admin()`, portanto não comprova a aplicação de RLS ou integração com Auth. A validação com papéis reais no Supabase continua pendente. Os três testes locais do importador passaram, assim como lint e TypeScript do app.

Para verificar filtros por compositor, busca sem acentos, paginação e consultas de publicação sem acessar o banco remoto:

```sh
node --test scripts/hinarios/test-catalog.cjs
```
