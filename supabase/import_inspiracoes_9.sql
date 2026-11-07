-- Importa catálogo em rascunho e publica SOMENTE o lote conferido. Requer migration_hymnals.sql.
begin;
insert into public.hymns (id, title, lyrics) values (E'e2de0d3d-bafc-5d45-84be-942ad521c5a6', E'OI —ICORINTIOS 13', E'jos também
falasse a língua dos homens dos anjos ami ;
Ainda que eu rofetizasse e conhecesse a ciência e os mistérios também
er que eu pda tal fé de maneira que os montes pudessem transportar
Ainda que eu

inda que eu desse meu corpo para ser queimado 2 se acabar
Ain a de inútil, sem nenhum valor, se acima de tudo não tivesse amor.
Seria tu ,

Amor na vida do crente é a pura semente recebida dos céus

Amor é o dom soberano que o Espírito Santo concede ao fiel

O amor está acima de tudo, ele muda o mundo e o homem tão Pecador,
homem tão rude, mas que tem amor

O amor é a grande virtude em um ho

Quem ama espera bastante, espera confiante e sofre sem reclamar
Que ama não se ensoberbece e nem com indecência é O seu caminhar
Que ama não usa de inveja, nem leviandade, nem pode se irritar

Que ama só diz a verdade e o seu interesse não está em primeiro lugar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e2de0d3d-bafc-5d45-84be-942ad521c5a6', 1, 3, 3) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'5f05ef69-2f80-5303-a5be-aa30c7d3f846', E'AO SALVADOR AMADO', E'Ao Salvador Amado louvores entoarei

A sua majestade eu sempre honrarei

Não tenho outro motivo que me inspira cantar
O seu amor infindo pra mim é singular

Eu quero na minha vida honrar servir a Jesus

No meu falar, no meu andar, levar aos outros luz

No meu comportamento por onde eu passar

Que eu possa a todo momento o seu santo nome honrar

Eu te agradeço, ó Cristo, a minha trans

formação
À nova vida S

que vivo, a paz no Coração
mundo perdido do seu amor falar
8arantido a Cristo quem aceitar') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'5f05ef69-2f80-5303-a5be-aa30c7d3f846', 2, 3, 3) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b600850f-a101-5e80-a22c-2eca0c2db83e', E'ÃO SENHOR O DOMÍNIO', E'Ao Senhor o domínio
Ão Senhor seja a plór;
'' BlOria par:
Seja a Ele meu louvor Pita sempre
Minha vida tudo ue ''
Só dependo de tj Preciso

Quero dar-te, ó Deus

Sempre meu Jouvor |

E viver a minha vida te servindo

E aos homens vou do seu amor falar
E sempre quero mais de ti. (3 vezes)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b600850f-a101-5e80-a22c-2eca0c2db83e', 3, 3, 4) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'16674fcf-1f77-5529-8582-234de6036e00', E'ADEUS TODA GLÓRIA', E'A Deus toda glória

A Ele seja o louvor

Criou a mais linda história

Que eleva a alma

Que enche de amor

Sou feliz, alegre e vivo contente
Minha vida Jesus transformou
Tenho paz sei que sou diferente
Habita agora em mim o Senhor
Gente, escuta a voz de Cristo
Não sofra mais porque não há razão
Olhe, escute e acredite nisso

Só Jesus é a solução.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'16674fcf-1f77-5529-8582-234de6036e00', 4, 4, 4) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'87040753-badf-5a14-aa4f-1e5ef93ae5dc', E'A VISÃO DO PROFETA EZEQUIEL', E'Como um furacão que do norte surgiu

Via glória de Deus e no solo caí

Entre nuvens de fogo eis que surge em fulgor
Quatro seres viventes cheios de esplendor

Filho do homem, põe-te em pé

Esta era a ordem da voz que ouvi

Entre sarças e espinhos e entre escorpiões
Falarás porque eu te envio

E guer ouçam ou deixem de ouvir

Eis que entra em ti o meu espírito
Profetiza o que há de vir.

Quatro rodas surgiram nesta minha visão
Como brilha o berilo tal a sua feição
Cheias eram de olhos, era o seu parecer

em virar quando olhavam tudo podiam ver

a um homem como fogo eu vi
saia m trono de uma glória sem fim
Deus, poderoso Senhor
>

ea voz me falou.

Seme
Assentado nu
Era a glória de
E caído ouvi o qu') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'87040753-badf-5a14-aa4f-1e5ef93ae5dc', 5, 4, 5) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'40ce07e7-83a7-5559-9a99-e3dbb9091f6a', E'COM CRISTO VOU', E'ro na marcha pra Sião

do vou vencendo a tentação

dando com temor
do ao Senhor

Com Cristo vou segu
Na luta contra o mun

Orando e vigiando, an
Em tudo obedecendo, servin

Com Cristo vou (alcançar)

Vitória (sei que virá)
E quero me consagrar para O Servir
E nada vai (sepatar)

Se nele confiar .
Servindo a Cristo, chorando ou sorrindo

Pra Ele vou trabalhar

A minha juventude está nas mãos de Deus

A Ele eu dedico a força que me deu
Honrando-o em minha vida, a mim Ele escolheu

Sou jovem para Cristo, pra glória de Deus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'40ce07e7-83a7-5559-9a99-e3dbb9091f6a', 6, 5, 5) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'1ccb2cd5-b27d-5c90-b5da-b4a8ad832615', E'MEU AMADO DEUS', E'Cantarei ao meu amado Deus
Louvarei teu nome, ó Senhor

Não demorarei em ti buscar

Sei que tens prazer em me abençoar
Já te entreguei o meu coração

Quero ter contigo mais comunhão
Te ofereço, ó Deus, este meu louvor
Como gratidão pelo teu amor

Ve
ii Senhor, meu coração aberto está
Eai mais de U, quero te buscar
e obedecer é o meu prazer
a ;
Servir melhor enquanto viver

Dá-me mai
mais poder e receba meu louvor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'1ccb2cd5-b27d-5c90-b5da-b4a8ad832615', 7, 5, 5) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4a0e149f-c359-5edd-bda5-a03df437fd30', E'COM CRISTO COMIGO', E'Com Cristo comigo nada temerei
Meu forte abrigo, não recearei

E Cristo comigo eu forte serei
Me sinto seguro, vencedor serei

E quando o perigo me sobrevier
Então Jesus Cristo sustém minha fé
Sinto-me seguro não tenho temor

Pois ele comigo eu sou vencedor

E quando Jesus nas nuvens voltar
Então para sempre irei descansar

E nenhum perigo e tribulação

É o fim da tristeza, nossa redenção.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4a0e149f-c359-5edd-bda5-a03df437fd30', 8, 6, 6) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b2a8493a-da85-570a-9af4-833473b21fc1', E'CRISTO É REAL', E'Cristo é real, Ele vive em mim
Oh! Eu canto sempre assim
O seu amor inundou meu ser
Não há razão para tristeza
Não há razão para ser infeliz

Aleluia cantarei (aleluia eu cantarei)
Grande foi o seu amor

Cristo Jesus, eu te amo

Pois por mim sofreste tanto

Ão teu nome sempre, sempre honrarei.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b2a8493a-da85-570a-9af4-833473b21fc1', 9, 6, 6) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'7207d1f7-a2c8-54bf-a852-1beb91002fb6', E'CRISTO ME FAZ DESCANSAR', E'Com Cristo comigo não hei de temer
À sua presença me faz descansar

Me inspira, me ajuda, me faz reviver
Com Cristo comigo eu vou caminhar
E tão gloriosa e sem comparação

À tua presença no meu coração

Me torna alegre, me enche de luz

À tua presença, querido Jesus') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'7207d1f7-a2c8-54bf-a852-1beb91002fb6', 10, 6, 6) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'beb38b31-8fd6-53d1-964c-a261da3b03f5', E'MATEUS 23', E'do a multidão e aos seus discípulos
cristo falan lismo dos escribas e fariseus

Sobre O forma ordi Moisés lhes havia escrito
Que conh a saga O que eu mando e não 0 que faço en”
ita que querem honra e vivem de elogios

E er ser vistos ante à ae o

Mestre, rabi, são títulos roAIS presetidos

São vaidosos e não veem Isso

São guias cegos, homens sem visão

Povo de Deus que nesta terra de pecado peregrina
Ter vaidade, aparência externa é ser fariseu
Mas disse o Mestre: quem se exaltar será humilhado

Porem aquele se humilhar pelo Senhor será exaltado.

1

Cristo ainda hoje fala aos seus discípulos

Sobre o formalismo dentro da casa de Deus

Examinai as vossas vidas e o que está escrito

Se vives o que está na Bíblia ou és fariseu

A Bíblia tem os mandamentos para a igreja amada
Ensinamentos para a nossa santificação

Que nos farão cristãos por dentro e também por fora
Sem formalismo numa vida nova

Nova aparência, novo coração.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'beb38b31-8fd6-53d1-964c-a261da3b03f5', 11, 7, 7) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'99088e9c-53ef-57da-9940-3c09f6da251f', E'O MEU POVO', E'Deus criou o homem, mas ele pecou
Rejeitando a Deus como seu Senhor
Sendo Deus autor da criação

meçou formar pra si uma nação

Deus cham
Oh! Em ti
E será um
Esse Povo

ou Abraão e lhe prometeu:
eu farei uma grande nação
Povo eleito para meu louvor
Será meu, serei dele Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'99088e9c-53ef-57da-9940-3c09f6da251f', 12, 7, 7) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'8ede7962-255d-5573-a3ed-bbdf32a44e77', E'VEM AMIGO A JESUS', E'De Cristo o nome vou dizer que é santo, é singular
De todos só O que tem poder, só Ele pode salvar

Vem ó amigo, & Jesus, vem, Ele te salvará
E das densas trevas raiará a luz se vieres a Cristo Jesus

Jesus morreu pra nos salvar, pra dar a libertação
A todos que nele confiar Jesus estende a mão

Não te demores em decidir ao lado do Salvador
Se queres hoje tu podes vir aos braços de Cristo, o Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'8ede7962-255d-5573-a3ed-bbdf32a44e77', 13, 8, 8) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b023f2bb-4451-5a20-852e-062ed6c461ae', E'ESPÍRITO DE DEUS', E'Deus está presente em meu ser

Ele habita no meu coração

Seu Espírito me quer envolver

Quero sempre sentir sua mão

Quero ter mais poder

Do Senhor mais unção

No seu amor me envolver

Quero mais comunhão

Espírito de Deus, vem me usar

Espírito de Deus, quero anunciar teu amor.

Deus deseja reinar em você

Jesus Cristo te dá salvação

Dos problemas liberta teu ser

Não hesite em lhe dar teu coração

Seu amor provarás, nova vida terás

O Espírito de Deus tu receberás
Espírito de Deus, quero receber

Espírito de Deus, quero no meu ser teu amor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b023f2bb-4451-5a20-852e-062ed6c461ae', 14, 8, 8) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'a4f9bf0d-a51f-57b8-8c16-9d14c9990366', E'DESCE SOBRE ni', E'Desce sobre mim à chama, Senhor

do teu poder
re voz, Senhor, que clama poder

Vem, vem nos responder
A tua graça desce sobre mim
Seja feito em mim o teu querer

Eu quero ver (cair)

Fogo do céu (aqui)

Chama do altar

Com o teu poder (em mim)
As almas vou (ganhar)

E o teu reino promover.

Sinto sobre mim a chama, Senhor
Chama do teu poder

Sinto sobre mim a força, Senhor
Força pra eu vencer

Eu quero ir as almas socorrer
Com a mensagem que faz reviver.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'a4f9bf0d-a51f-57b8-8c16-9d14c9990366', 15, 9, 9) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'c7d4c381-2f5f-53bd-8eb3-e76ebb6a5c3a', E'DESTE MUNDO IREI AFINAL', E'Deste mundo um dia irei afinal

Junto a Cristo e livre do mal

Deixarei este mundo de angústia e dor
Para ir à morada de amor

Meu Jesus, meu amigo, meu mestre e Senhor
Meu tesouro que tenho no céu

Minha felicidade é saber que um dia irei
Para junto de ti.

Se aqui já sentimos os prazeres do céu

its que Jesus nos dá.

O randad teremos, eu sei
FIStO nas nuvens voltar') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'c7d4c381-2f5f-53bd-8eb3-e76ebb6a5c3a', 16, 9, 9) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'c1829108-ed7b-5b66-9946-05120cfb2d33', E'SANTACIDADE, CIDADE DE LUZ', E'Estou avistando a terra que Jesus me prometeu

Terra Santa, aleluia. Lá ninguém diz: alguém morreu.
Nada tenho neste mundo, neste mundo nada sou

Mas herdeiro sou da terra que Jesus pra mim comprou

Santa cidade, cidade de luz
Ninguém sofre ou chora

Lá mora Jesus

Há paz permanente

Feliz vou viver

Louvando a Cristo, eu e você.

Estou aguardando o dia, sei que não vai demorar
Vamos ver a Jesus Cristo e com Ele encontrar
Um adeus a este mundo e pra quem aqui ficou
Pra Sião voando em glória, pra cidade santa vou') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'c1829108-ed7b-5b66-9946-05120cfb2d33', 17, 10, 10) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'834cc8a4-a6f5-51d1-9bc6-3329aa0e1f51', E'JESUS MUDOU MINHA VIDA', E'Eu quero cantar este hino e dizer nesta hora
Jesus me mudou tudo é diferente agora

Eu quero cantar esta minha felicidade

Jesus é a razão, quero cantar então esta saudade

Jesus mudou minha vida, meus pensamentos
E não sigo ao léu neste mundo, sigo a sua cruz
Serei feliz e fíel nos teus mandamentos

Nunca mais te deixarei um momento

Nunca mais te deixarei, Jesus

Me lembro do nosso encontro naquele dia
Vivia sozinho, no mundo não tinha alegria
Chegaste falando de amor, carinho e ternura

Eu te amei e a ti me entreguei, minha vida é tua,

Eu quero cantar esta minha felicidade

Nós dois somos um, o amor nos uniu de verdade
Ati entreguei minha vida, também meu coração
E agora cantando estou celebrando nossa união.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'834cc8a4-a6f5-51d1-9bc6-3329aa0e1f51', 18, 10, 10) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'03988faf-5b54-567e-b139-082b577b0752', E'A ESPERANÇA É JESUS', E'-4 procurei, já me esforcei, nunca consegui
Eu as forço inútil, tudo em vão, no mundo não achei
EE À paz, eu queria Deus, um mundo melhor

u

Mas só encontrei quando fui buscar em Jesus

19

Eu queria ver O Sol brilhar num amanhecer
Para o que buscar da escuridão sair

Mas só pode havet novo amanhecer

Se à luz de Cristo Jesus achar

Só Cristo Jesus pode conceder

O que busca o amanhecer

Hoje eu encontrei o que procurei, eu já consegui
Encontrei Jesus, tudo em mim mudou e hoje sou feliz
Eu queria paz, eu queria Deus, eu queria luz

E só encontrei quando fui buscar em Jesus

Podem procurar em qualquer lugar, só Cristo Jesus poderá servir
É melhor parar, se estiver assim o teu coração não vai suportar
É Jesus quem diz: hoje vinde a mim, eu te darei paz

Sou Emanuel, Deus presente está, sou filho de Deus

Posso te ajudar, se teu coração hoje entregar, tu serás feliz.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'03988faf-5b54-567e-b139-082b577b0752', 19, 11, 11) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'ddd24a34-0835-57e8-aa4e-796eb609deb1', E'AMOR IMCOMPARAVÉL', E'É impossível descrever aqui

O grande amor que de Jesus fluiu

Os homens devedores desse imensurável amor
Se rendem exaltados pela morte do Senhor.

Incomparável amor de Deus

Dos céus contemplou-nos e o amor cedeu

Se hoje vivo, agradeço a Deus
Jesus que Por mim morreu

O sol que brilha em todo seu fulgor
lua que a noite faz brilhar

Os astros sã
Qu ii São seguros pela sua forte mão
o ; ''
Mos nós os homens pra não darmos atenção?') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'ddd24a34-0835-57e8-aa4e-796eb609deb1', 20, 11, 11) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'649f0282-4a52-5716-9155-d561d25020f8', E'EM JESUS EU ENCONTREI', E'Eu procurei amigos e foi em vão
No mundo o que achei foi ilusão
Senti que onde procurava

Era em vão, não encontrava

E sem saber parei de procurar
Foi quando Cristo apareceu

E em seus braços me tomou
Senti o poder das suas mãos

E o seu toque de amor

Jesus é tudo pra mim

Parei, parei de procurar

Em Jesus eu encontrei

O que eu precisava achar (bis)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'649f0282-4a52-5716-9155-d561d25020f8', 21, 12, 12) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd54e9438-858f-589a-bec9-ce938a81548e', E'A JUVENTUDE VEM E VAI', E'Eu sei, Senhor, eu sei que um dia tudo vai passar
Porém enquanto vivo eu desejo te servir

À vida passa, Os anos correm, a juventude vai

Eu quero sempre ter a força pra jamais eu desistir

Vem (sim vem)

Vai (sim vai)

Todas as coisas passam
Tudo é vaidade

Poucos, nossos dias são.

Senhor, embora sendo fraco, escolheste a mim
Eu quero que na minha vida brilhe o teu fulgor
Eu te agradeço pelos anos que tu deste a mim
Que eu possa sempre, sempre ser fiel até o fim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd54e9438-858f-589a-bec9-ce938a81548e', 22, 12, 12) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'dd11ac65-fcaa-566f-842a-b3ed5de6ed43', E'VITÓRIA CERTA', E'Esta é hora a mais preciosa do nosso viver

Quando reunidos e irmãos unidos louvamos a Deus

E Ele se mostra presente na igreja com o seu poder
Alegrando a alma daqueles que buscam à Deus conhecer

=

re aqui na igreja querendo operar
resen as tão santas n
Deus a passeiam e as presenç am
Seus 81 É
Zo nã

Rnqie a vitória Jesus dá
busca, que ora, que luta pra agradar a Deus
do na igreja, em casa, onde seja não muda é fiel

a que todas as ovelhas que Ele escolhey

ta na alma o gozo do céu

agora a cada irmão.

O cre o,
Estando na igreja,

É Deus quem dese)
Receba alegria e sin

Irmão é agora, é chegada a hora de pedir a Deus

Que fique conosco € visite seu povo, alegrando Os seus

Se com humildade, com sinceridade pedirmos poder

Deus tem prometido dar do seu Espírito a todo o que crer,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'dd11ac65-fcaa-566f-842a-b3ed5de6ed43', 23, 12, 13) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'474df180-89b1-5934-b2ac-007a8df7304e', E'SÓJESUS, SÓ JESUS', E'Eu sofro, mas não reclamo,

Me sinto alegre porque eu amo

Aquele por quem eu sofro assim

Se choro, são lágrimas que rolam de felicidade dentro de mim
Não me importo com esse sofrimento

Para dar-me vida, também Ele sofreu

Me sinto honrado por sofrer um pouco

Por esse amor que me trouxe de novo

À felicidade e o sorriso enfim,

Só Jesus pode me valer
Pode me entender
Pode me ajudar.

Eu canto, não me

Dino alegre quando estou louvando
o aleluia ão meu Salvador

envergonho,

FCO, mais same
, QUE milionário, com o sangue comprado sou do Se

Não mê intão “e aqui neste mundo eu for desprezado por $
Orque Jesus é pe nem me enfraqueço
eéo caminho" TÍEO que não deixo
9 à verdade e a luz,

Me,
sborda e acalma nossos Corações Hora,

nhot.

esvis Jos') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'474df180-89b1-5934-b2ac-007a8df7304e', 24, 13, 13) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'1a532908-6578-5371-ae77-8f6a0e51efed', E'EMBREVE CRISTO VOLTARÁ', E'Em breve Cristo voltará, o céu no infinito enrolará

E as trombetas soarão, a todos os homens chamará

Será o grande dia do Senhor, ninguém dele se esconderá

virá como Rei, como juiz, diante dele todos hão de se prostrar

Pois Ele é Rei, Ele é Senhor
Ele é Deus, Ele é Salvador

A todos Ele quer salvar

Pois breve voltará

Ea todos os homens julgará.

Espero o grande dia do Senhor, desejo vê-lo em glória retornar

E rodeado de esplendor, com justiça seu reino implantará

Será em toda terra um dia de pavor, mas, pata os salvos dia de louvor
Que entoando hinos de louvor dirão: bem-vindo, ora vem, Jesus Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'1a532908-6578-5371-ae77-8f6a0e51efed', 25, 14, 14) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'cc85f87f-61f8-5735-93a1-2bb494a4a7f8', E'SÓJESUS SALVA', E'Eu vou viver a minha juventude, vou viver na tua casa

Só tem sentido a vida que se vive com a tua graça

Mas quero nesta vida que me deste levar tua palavra

Sou jovem e vou dizer pra todo mundo que só Jesus quem salva

Salva, só Jesus quem salva

Não há outro nome que se pode invocar
Nenhum outro nome pode o homem libertar
Salva, só Jesus quem salva.

Se você é jovem e não sabe que só Jesus te salva

Que a tua juventude neste mundo sem Jesus é nada

Mas anunciamos neste hino que só Jesus quem salva

Só Ele tem poder pra dar ao homem a salvação da alma.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'cc85f87f-61f8-5735-93a1-2bb494a4a7f8', 26, 14, 14) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'cc41fdce-92b0-526d-89c0-46a6442fe0c6', E'ÍNTIMO DE DEUS', E'Feliz é o homem que é íntimo de Deus
S Seus segredos revela aos fiéis
iz sad oa quem nele firme está
para sempre quem no Mestre confiar

o.

comigo (ele está)

ei, a
(bem & ), não me deixará

deixarei,
Nunca O
Eu sei que me conduzirá

ou
Com ele (vou), seguro (est )
Não temerei e vencerer ,
Porque Jesus comigo está.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'cc41fdce-92b0-526d-89c0-46a6442fe0c6', 27, 14, 15) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'71afd20d-15ea-5cbf-ae5f-91afe19b0804', E'O TESTEMUNHO DO LADRÃO NA CRUZ', E'Eu sef

28

Foi humilhante e triste, isto não sei explicar

Sua vida ensinava como realmente amar
Porque pregou justiça é humildemente aqui viveu
Gritaram crucifica-o e assim Ele morreu

Oh! Como tu não temes, por teus crimes estás na cruz
Porém esse inocente, reconheço, não fez jus

Senhor, tem piedade, hoje creio em ti, Senhor

Jesus na cruz morrendo, salvou o pecador

Foi triste para os homens que Jesus abençoou
Ao ver ali sofrendo quem das dores os livrou
Às lágrimas nos olhos eram formas de expressão
A dor que eles sentiam se tornou em gratidão

Oh! Como gostaria de poder retribuir

À minha alegria que tu me fazes sentir

Agora compreendo porque estás aqui na cruz
Morrendo deu-me vida, dando a vida o bom Jesus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'71afd20d-15ea-5cbf-ae5f-91afe19b0804', 28, 15, 15) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'aad79275-ee40-5ce5-a7a3-09c274790ff4', E'FOIASSIMEM JERUSALÉM', E'Teu Poder renov. dPero viver Para ser um instrumento teu
a € renovará meu desejo de ser fiel

E agora sei no presente, com a igreja será também

Sim batizados serão os crentes como a igreja em Jerusalém
E nova língua será derramada, uma alegria sem compara ão
No Santo Espírito então batizada, igreja viva em Fitiuração') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'aad79275-ee40-5ce5-a7a3-09c274790ff4', 29, 15, 16) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'36b4216d-35c8-53e8-b22a-e47ed2e313f2', E'GRANDE É O SENHOR', E'(15º Congresso da UMIMOBRART)

Graças te dou ó, Senhor

Porque por amor tu me confortaste
Confiarei no Senhor

Tu és minha força a minha salvação
Grande é o teu nome

Todos dirão naquele dia

Graças a Deus, o Senhor é grande
Fazei notório entre os povos
Anunciai O seu nome

Cantaí ao Senhor

Porque Ele fez coisas grandiosas
Saiba-se em toda terra

Cantem, exultem ao santo de Israel
Grande no meio de ti.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'36b4216d-35c8-53e8-b22a-e47ed2e313f2', 30, 16, 16) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f21e20e5-1067-59d4-8228-527d18c2eb23', E'GLÓRIA A CRISTO', E'Glória a Cristo, a Jesus nosso Rei
Glória aquele que por nós morreu

A Jesus supremo Rei, o nosso Senhor
Aquele que reina é Deus de amor

Ao Senhor toda glória, só a Ele O louvor

Eu te amo, eu te adoro, eu te quero, Senhor. - bis
Quero senti-lo em todo o meu ser

Quero servi-lo, com Ele viver

Ele é meu rei, eu sei, meu Senhor

Não importa este mundo, sou sim, dele sou.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f21e20e5-1067-59d4-8228-527d18c2eb23', 31, 16, 16) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e0ae2d26-8798-50b0-9495-bdd1496f0f45', E'BRILHA A LUZ', E'] m mim
luz de Deus que cia
Há uma poa que faz resplan a
Há am dele nele brilha as
Toda gló e brilha mais que o so

Temos luz qui Glgçe

ida O ; |

da da sua glória sobre nós
€

/ xa à luz brilhar
rilha), deixa a
E farol da luz de Jeová

ilha, faz resplandecer | .
bao glória de Deus brilhar em você

Tens a luz de Deus que brilha em ti?
Tens a luz que faz resplandecer? |
Toda glória dele e ele brilham em ti?
Tens a luz que brilha mais que o sol?
Tens em tua vida o fulgor?

Do esplendor da sua glória sobre nós?') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e0ae2d26-8798-50b0-9495-bdd1496f0f45', 32, 17, 17) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'0b6f03e8-2c2e-5962-ba2f-65c9d5d8905a', E'TU ÉS TUDO PRA MIM', E'Hoje eu vivo contente
Hoje eu tenho razão
Hoje eu vivo alegre
inha alegria é ser um cristão
Fui resgatado do mundo
Para uma vida teal
Sou diferente, eu sinto

Pois Encontrei liberdade afinal') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'0b6f03e8-2c2e-5962-ba2f-65c9d5d8905a', 33, 17, 17) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'beebd5ff-a429-59cf-8bd2-226247dfab53', E'OS MISSIONÁRIOS', E'Irmãos, esse é o momento tão importante
Cantando, sorrindo ou chorando iremos partir
Iremos sair em missão para terra distante
Porque Deus ordenou seguiremos avante
Iremos cumprir a missão que nos deu
Queremos que orem por nós a todo instante
Foi Deus quem marcou este dia e nos escolheu
Nós não podemos ficar, temos que viajar
Confiando em Deus e não esqueçam de orar
Para Deus nos usar como nos prometeu,

Fiquem na paz do Senhor
Fiquem na paz de Jesus
Faremos o que ele ordenar
E se Ele quiser iremos voltar
E pela fé a vitória é nossa
Conosco ele estará.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'beebd5ff-a429-59cf-8bd2-226247dfab53', 34, 18, 18) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'bcd1fb39-7f7d-52fd-95b0-3ffd5241d650', E'JESUS MINHA VITÓRIA', E'Cristo é a vida que me satisfaz
Minha alegria, meu maior prazer
Meu conselheiro, é a minha paz
Minha razão de viver

Rocha em quem firmado estou
Inabalável é meu Senhor

Minha vitória só vem do Senhor
Dedicarei meu louvor

Tudo no mundo é nada pra mim
Minha alegria é servir a Jesus
Dando sua vida salvou-me assim
Vivo feliz e na luz,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'bcd1fb39-7f7d-52fd-95b0-3ffd5241d650', 35, 18, 18) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'130a7500-1f9c-59d6-b626-a52385ec7159', E'JESUS É MEU AMIGO', E'perus é meu amigo, nele confiarei
o Dre está comigo, eu o amarei
“é minha esperança, futuro ideal

“a minha nau
esus é meu amigo» gua
Nele está minha alegr!
eu viver
m todo o meu ser

Nele está O alegria, CO
x - e Z
Servirei com go migo está

esus é meu amigo», “2
E a vitória Ele me da.

Eid amigona vacilarei

nho,

Nunca estou soz a

Ele meu escudo forte, libertador do mal

Jesus é meu 2 igo, não DR igu a der
3 £ he £L bd e é
Nele sempre há vitória, Ne es pe É P
O caminho para à glória, meu m prazer
Jesus é meu amigo, comigo estã
E a vitória Ele me da.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'130a7500-1f9c-59d6-b626-a52385ec7159', 36, 18, 19) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4589662c-5220-58d3-bade-8c875e54f40d', E'JESUS CHEGOU', E'porta
ração

a temerei

37

Jesus chegou e eu abri à
E entreguei a vida e O CO
Por isso é que vivo assim agora

Ele me deu a salvação

O mundo não conhece esse amor
E não entende porque vivo assim
A minha vida transformou

Jesus agora vive em mim

Jesus está batendo em tua porta
Está querendo o teu coração

Se tu quiseres hoje é a hora

De receber a salvação') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4589662c-5220-58d3-bade-8c875e54f40d', 37, 19, 19) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e70cc6e0-74de-517a-8aa1-1277fd35df74', E'IDE E PREGAI', E'Des Re Ee ato ade ca pe

EE O eme autoridade contra o pecado

Riga vaso? Ganhar almas pra Jesus?
ser coroado quem ganhar almas pra Jesus.

Ouça o id
Da cruz ço esus, Ele está te convidando
ua vitóri
vitória, ouça nesta hora Ele está falando.

Deus ainda está chamando para ser um Mensageiro

Velhos, jovens e crianças, há esperança para o mundo inteiro
Todos que quiserem venham, Deus é quem vai te usar
Ele tem a recompensa, vamos evangelizar,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e70cc6e0-74de-517a-8aa1-1277fd35df74', 38, 19, 20) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'0ec7ca1c-8d7c-54b8-80d2-32a3d3e6eafe', E'EUQUERO TE LOUVAR JESUS', E'Jesus, meu coração aberto está pra te louvar
Eu quero a minha voz no teu serviço dedicar
Embora reconheça: imperfeito é meu louvor
Mas, venho adorar-te pelo teu imenso amor

Eu quero te louvar, Jesus

Eu quero dar-te meu louvor

Quero viver olhando a cruz

Inspiração de amor

Eu quero que o meu viver

Seja para o mundo luz

Quero cantar que eu te amo, meu Jesus

Jesus, meu coração aberto está pra te adorar

Eu quero a minha voz no teu serviço dedicar
Embora reconheça: não mereço teu amor
Morrendo, deste a vida e vivo pra te dar louvor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'0ec7ca1c-8d7c-54b8-80d2-32a3d3e6eafe', 39, 20, 20) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd1bef9cb-f6c7-5cab-9e81-3a072ae9bbae', E'EMANUEL DEU CONOSCO', E'Jesus é o nome mais belo e em tudo é singular
Logo concede o que peço, tenho prazer em falar
Jesus é o nome precioso de inefável valor

Jesus é o nome mais doce, fonte de puro amor.

Clama esse nome para vencer
Emanuel Deus conosco
Só neste nome há poder.

Quando estamos aflitos, sem esperança até

Temos socorro bendito quando pedimos com fé
Não há no mundo inteiro nome com todo poder
Quando se invoca esse nome tudo podemos vencer.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd1bef9cb-f6c7-5cab-9e81-3a072ae9bbae', 40, 20, 20) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'53f033cd-d44a-555b-8561-a250eec0d0bd', E'JESUS O DOCE NOME', E'esus o doce nome
Nome que dá prazer

Jesus eterna fonte
Razão do meu viver

Quero viver cantando
Quero cantar Jouvor
Louvando, anunciando
Jesus o Salvador

Cantem os pequeninos
Seres que vida tem
Cantem os altos montes
E todo o céu também.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'53f033cd-d44a-555b-8561-a250eec0d0bd', 41, 21, 21) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'24c6349c-6621-54d5-b7a8-11e8e91c1055', E'EU SEI SENHOR...', E'Jesus Senhor, meu coração aberto está
Para ouvir e entender e aceitar

Quero ser tão somente teu querer

Só pra ti, seja meu viver

Eu sei Senhor,

Que queres de amor encher meu coração

Unir a minha vida à do meu irmão

E sermos vencedores pela tua cruz

Quero ter amor para ajudar a quem precisa de
Perdão pra levantar e juntos prosseguir

Até chegarmos mais perto de ti.

Querido Deus, olha para os filhos teus
Com amor, com carinho visitar

Pai fiel, dá-nos o que vem do céu

Teu poder, o consolador.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'24c6349c-6621-54d5-b7a8-11e8e91c1055', 42, 21, 21) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'de12969e-7daa-59da-951a-46cb6fe1a5aa', E'ALELUIA', E'Jesus Cristo está aqui neste lugar

Sua presença faz mover a minha fé

E não há porque me desanimar

Com Jesus tudo é possível ao que crer

Aleluia, aleluia

Seja dada ao Senhor

Aleluia, aleluia

Glória a Deus que deste mundo me salvou

Minha fé está firmada no Senhor
Neste mundo nada pode me abalar
Sua graça em mim, seu amor por mim
Me renova e me faz um vencedor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'de12969e-7daa-59da-951a-46cb6fe1a5aa', 43, 22, 22) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'92e5dbd9-8ddc-5c8b-8e58-03023843e96a', E'JESUSÉ O MEU REI', E'Jesus é o meu rei

Meu pai e meu Senhor
Minha alegria é

Jesus é meu pastor

A minha salvação

O meu refúgio enfim
Paz no meu coração
Tudo Ele é pra mim

Jesus é minha luz
Razão do meu viver
Ele me satisfaz

Em todo o meu ser.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'92e5dbd9-8ddc-5c8b-8e58-03023843e96a', 44, 22, 22) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'1ba3c187-a56d-599d-9469-59752e9edd7b', E'CRISTO ETERNAMENTE ÉS', E'Cristo, eternamente és Senhor da minha vida
Tu és o meu amparo, também minha alegria

Tu és onipotente, razão do meu viver

Eu sinto a tua presença enchendo-me de prazer

vor, também a minha vida
melhor, no céu com alegria
s queremos te louvar
com hinos te exaltar

Dar-te-ei o meu lou
No céu louvar-te-€
Enquanto aqui vivermo
Queremos com alegria,

Sei que breve tu virás com teu coral de anjos
de al farás, um grande coro santo

De todos um coral tar
Então com mais alegria, Jouvar-te-ei, Senhor

Enquanto não vem O dia receba o meu louvor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'1ba3c187-a56d-599d-9469-59752e9edd7b', 45, 22, 23) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'393dfc58-b280-5a85-9f61-b29ceabdec95', E'O CÉU É O MEU DESTINO', E'Feliz sigo caminhando, contente caminho vou
Andando com passos firmes, seguindo ao meu Senhor
Cansado, com sede andando, faminto do pão do céu
Caminho com passos firmes à terra de leite e mel.

O céu é o meu destino, aqui não é meu lugar

Sei que não estou sozinho, Jesus vem me acompanhar
Caminho pra terra santa, ali eu vou descansar

Por ísso eu não desisto, com fé sei que chego lá.

Irmãos o caminho é longo, estreito pra caminhar
Andando com passos firmes nós não vamos vacilar
Segura nas mãos de Cristo que nada vai te deter
Vencerás o impossível, Jesus está com você.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'393dfc58-b280-5a85-9f61-b29ceabdec95', 46, 23, 23) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'c96fcdb9-6213-5562-9966-2722a381060a', E'SÓ OLHAR PRA JESUS', E'Já não olharei para o mundo

Do mundo nada quero aceitar

Me envolverei na graça de Cristo

Só nele tenho tudo o que vou precisar

Vou clamar o seu nome, vou erguer minha voz
Sei que perto ou longe, Deus, Ele vê todos nós.

Só vou olhar
Olhando o
Olhando o
Pois Ele m

para Deus de onde o socorro me vem
fosto de Cristo eu sinto o conforto também
semblante do mestre seguro eu caminhare!
€ ensina o caminho, só vou olhar para Deus.

Jesus já me livrou deste mundo
Do mundo eu liberto estou
Me envolverei na graça de Cristo
vero dar a ele tudo o que sou
vou louvar O seu nome
Vou erguer minha voz
sei que perto ou longe, Deus, Ele vê todos nós.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'c96fcdb9-6213-5562-9966-2722a381060a', 47, 23, 24) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'0bf7e67d-7526-592a-a9b6-78e4768be013', E'VEM VISITAR O MEU CORAÇÃO', E'Meu viver, minha vida entreguei-te de coração
Sem temor, sem receios estendi-te a minha mão
Sou feliz e cantando me sinto melhor

Eu me sinto seguro, nunca me sinto só.

Vem visitar o meu coração

Vem renovar a tua unção

Quero a ti fielmente servir

Me sustenta Senhor, sempre assim.

Quero dar ao Senhor tudo que seja de melhor
Com amor, meu louvor e com graça muito maior
Quero ser mais fiel e a Ele me consagrar

E sentir sua presença no meu doce cantar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'0bf7e67d-7526-592a-a9b6-78e4768be013', 48, 24, 24) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd27114f5-f32a-5636-b10e-6cdd43855442', E'VEM A MIM', E'Meu Senhor, quero ouvir tua voz

À chamar: vem a mim, filho meu

Te comprei com meu sangue na cruz
Tu és meu, eu te darei o céu.

Vem a mim, sou Jesus

E desejo alegria te dar

Dar a paz e o amor, vida eterna terás
vieres a mim como estás.

Hoje podes mudar teu viver
à aflição não lembrares jamais
“Us pecados eu perdoarei
“ sou Deus, quero te abençoar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd27114f5-f32a-5636-b10e-6cdd43855442', 49, 24, 24) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'22eb3b7f-b291-5643-89ae-3e39de6b24f8', E'MELHOR OU IGUAL NÃO HÁ', E'ão há
jhor ou igual não
Ei quem possa comparar
De infinita bondade
E amor divinal a ,
Melhor ou igual não há

50

Que ele tudo sofreu
Pra livrar-me da pena de morte, morreu

Hoje herdeiro da vida eterna sou eu
Melhor ou igual não há.

Melhor ou igual não há

À quem possa comparar

Tanta glória no céu

E por mim se fez réu

Melhor ou igual não há.

Quando será não sei

Face a face o verei

A quem tanto me amou como nunca ninguém
Sou feliz, como sou ele me recebeu

Melhor ou igual não há.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'22eb3b7f-b291-5643-89ae-3e39de6b24f8', 50, 25, 25) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'15602c87-5878-5c51-b459-ceefacb8ccc5', E'MANSA E SUAVE É', E'Mansa e suave é a voz de Jesus

Fala bem mansinha no meu coração

E então dentro de mim algo vindo do além
à unção da sua voz que me detém.

Ó aleluia, Cristo me satisfaz
'' ha alma se eleva
entro de mim há paz

Ó Espírito de Deus,

vem, repousa sobre mim
Enche-me da Elano 3 p ob

ra ção, vem me encher
pie Mais amor e que somente possa ser
arma bem veloz do teu poder.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'15602c87-5878-5c51-b459-ceefacb8ccc5', 51, 25, 25) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f79f557e-6f20-512a-b223-188bfcb13c33', E'CRISTO É MEU AMIGO', E'inha grande alegria que minha alma inspira
Quando louvo a Jeová

É que sinto na alma a presença que acalma
Minhas forças vêm renovar

Sou feliz e por isso que a Deus glorifico
E jamais quero me afastar

De Jesus sou querido, Ele é meu amigo
E nele posso confiar

Canto, me regozijo, glotífico a Deus

Cristo é meu amigo, Ele é justo, Ele é fiel

Minha vida Ele resgatou, nele sempre eu sou vencedor
É por isso que eu vivo na presença de Cristo

Meu amigo é o Senhor.

Todo crente é alegre, é feliz, nada impede

De a Cristo glorificar

Mesmo estando na igreja, ou em casa, onde seja
Nunca deixa de se alegrar

Se é noite ou dia, nos problemas da vida

Nada o pode desanimar

Pois em qualquer perigo Cristo, o fiel amigo
Logo vem para lhe ajudar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f79f557e-6f20-512a-b223-188bfcb13c33', 52, 26, 26) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'1d4c0922-4f38-50e1-b38b-5e825e81fcfb', E'NÃO FOI EM VÃO', E'Não foi em vão que Cristo padeceu
O sacrifício de morrer na cruz

A minha vida restaurou

Meu coração transformou

Hoje canto salvo por Jesus

Santo, santo é o Senhor Jeová
Todos cantem hinos em seu louvor
Maravilhoso, Ele é Deus forte
Conselheiro e príncipe da paz.

Eu canto hoje uma nova canção
Não me envergonho de servir Jesus
Os meus pecados apagou

Primeiro do que eu me amou
Louvo e canto glórias a Jesus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'1d4c0922-4f38-50e1-b38b-5e825e81fcfb', 53, 26, 26) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'8569c77e-f27e-5965-9c53-0900afc4229a', E'NO CALVÁRIO', E'io de agonia que Jesus por mim s alem

a O me daria à entrada no céu

Sua prórie sou remido, minha vida resgatou

Hoje E sangue no calvário, salvo fui por amor.

Com se

A Jesus me en treguei e pra Ele é o meu louvor

Sou feliz com Jesus Cristo, seu poder me transformou
É por isso que desejo minha vida consagrar

E aos homens no pecado quero dele falar

Mesmo estando neste mundo, deste mundo eu não sou
Foi com precioso sangue que Jesus me comprou

Minha vida, meus desejos eu darei pra seu louvor

Pelo sangue no calvário que liberto estou.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'8569c77e-f27e-5965-9c53-0900afc4229a', 54, 27, 27) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'05d6b292-3cb2-5f94-ae07-bca445dc0908', E'MAS AMANHÃ VAI CHEGAR', E'Mas amanhã vaí chegar

O solo dia vai trazer

Meu coração vai se alegrar
Nova esperança ter

Eu sei que após o temporal
O céu azul regressará

E o arco-íris pra dizer

Deus nunca nos esquecerá

Cada dor ou aflição
Que tivermos que passar

de Deus formos Provados
nosco ele estará') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'05d6b292-3cb2-5f94-ae07-bca445dc0908', 55, 27, 27) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'abb1f8aa-a547-567a-aa8f-52701909fdb7', E'JESUS EU CONFIO', E'Muitas Vezes Os problemas da vida
Se empenham em roubar minha fé
E me vejo em lutas difíceis

Me esforçando eu fico em pé

Oh! Me esqueço o triste passado
O presente me inspira poder

Pois eu vejo o futuro chegando

E a certeza que posso vencer

Jesus, eu contio

Que os problemas e anseios que tenho
São vitórias que vou alcançar

Jesus, não receio em meu sofrimento
Pois eu tenho a certeza comigo

Isso é momento.

Muitas vezes me sinto inseguro
Nas promessas que Cristo me fez
E a mim no silêncio pergunto

Se eu quero o passado outra vez
Não desejo atrasar as promessas
Quero vê-las cumpridas em mim
Pois eu vejo o futuro chegando
E a certeza de ser mais feliz.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'abb1f8aa-a547-567a-aa8f-52701909fdb7', 56, 28, 28) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'3fc37ced-7b2c-500b-8987-e51f5aa28248', E'SÓ POR TI', E'Oh! Que hora preciosa na presença de Jesus
Oh! Como é maravilhosa a vitória que velo lá da cruz
Senhor, só tu é quem sabes, eu sei que posso vencer

rter
Contudo, Senhor, eu te peço poder para as almas conve

Só por ti, só por ti

uítas almas eu posso ganhar
Só por ti, só por ti
Minha vida eu quero consagrar

i er
Jesus, enche-me da tua graça, quero mais do teu pod
à : ver
à-me mais entendimento para dedicar-te meu e
Falar eu quero a verdade, de amor enche o meu S

nverter.
Reveste tua igreja Senhor de poder para à$ almas CO') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'3fc37ced-7b2c-500b-8987-e51f5aa28248', 57, 28, 28) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'1d8fcae2-9403-5ed0-a72f-7dfdd4ecf745', E'JU CANTAREI, EU LOUVAREI', E'58

H! Cantarei

aleluias à Deus
aleluias 20 Salvador

oh! Cantarei mil louvores 20 Cordeiro de Deus
Eu cantarei e louvarei O Seu amor

Eu sei que brevemente entendo

Que Jesus Cristo vai voltar

E com ele subiremos à morada, nosso novo lar
E na glória todos juntos

Em um coral, em um só louvor

Daremos todos ao cordeiro

As honras de Rei e Senhor

E de mãos unidas num só louvor

Junto ao trono do Leão de Judá
Para sempre como servos de Deus
Viveremos para Ele a cantar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'1d8fcae2-9403-5ed0-a72f-7dfdd4ecf745', 58, 29, 29) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'5ff7493f-3837-5b58-95c7-deb79ebc9ed2', E'COM TUA GRAÇA', E'Ó Senhor, aceito em mim o teu querer

A tua vontade seja sobre mim

Minha vida te pertence, meu viver

Que seja feito em mim, Senhor, o teu querer

Com tua graça sei que tudo vencerei

Do teu Espírito a minha vida encherei

E será feito em minha vida teu querer

Porque a tí pertenço e quero obedecer

Serei fiel áquele que me salvou

pe sua vída deu por mim só por amor

ce sd is dia amá-lo muito, muito mais
e desfrutar a sua paz

Com ita é
A mer po aceita ó Deus o meu louvor
à alegria é cantar, Senhor
Quero ver q Sassi
tua glória sobre mim

U quero
dHero ver O teu poder descendo aqui.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'5ff7493f-3837-5b58-95c7-deb79ebc9ed2', 59, 29, 29) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4f2eb9a6-feca-56fb-afbd-afa95c097dc6', E'MINHA ORAÇÃO', E'Quve, 6 Deus, minha oração
Vem iluminar o caminho meu

A minha vida te entreguei
Vem ajudar-me nos dissabores meus.

Vem Senhor, vem meu Deus
Em ti eu confio, em ti esperarei

Quantos momentos aqui passei

Choro e tristeza, não desanimei

Pois sirvo a um Deus vivo e de poder
Quando vou cair, sua mão me vem erguer

Quero, ó Senhor, ter mais amor

Ser mais humilde, mais fiel também

Se eu me enfraquecer, minha fé falhar

Não me deixe mais viver, não quero mais pecar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4f2eb9a6-feca-56fb-afbd-afa95c097dc6', 60, 30, 30) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'095f18c4-afc0-55d4-bc73-b877529c78ee', E'JÁ RESSUSCITOU', E'Na verdade, é difícil explicar
Quanta gente não quer aceitar
Não procuram e não querem entender
Suas vidas não querem melhorar
Não admitem a mensagem da cruz
Não desejam estar com Jesus
Conhecer não desejam ao Senhor
Não aceitam o convite de amor
Mas a história sempre foi assim
Por amor foi que o Pai enviou
Jesus Cristo esteve aqui

E o mundo o desprezou

Em resposta ao plano de Deus
Rejeitaram a mensagem da cruz
Resolveram prender e matar

O grande Rei Jesus

Mas já ressuscitou.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'095f18c4-afc0-55d4-bc73-b877529c78ee', 61, 30, 30) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'a1b856d4-ae5a-54d1-9044-450fc23b4227', E'LÁGRIMAS DE AMOR', E'aminhos da vida
também
bonitas

s contém

Nos €
Que eu passo
Tem as rosas

ue espinho
di momentos alegres |
Sufocados por males daqui

Há sorrisos fechados
De quem luta pra resistir

Mas eu vencerei, vencerei

Eu não desanimarei

Mas eu seguirei, seguirei

O caminho traçado por Deus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'a1b856d4-ae5a-54d1-9044-450fc23b4227', 62, 31, 31) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'eddfb2cb-05d4-568c-bca1-9f2dee5cbc5d', E'PRECIOSO SANGUE', E'Na cruz por mim morreu Jesus, para dar-me vida eterna
Das trevas fez raiar a luz, dando a vida plena

O seu sangue precioso, deu por todo pecador

Na cruz por mim morreu Jesus, precioso sangue.

Não haverá condenação, quem no sangue for lavado
Nele nós temos salvação, perdão dos pecados

Nele temos a certeza da herança divinal

O sangue que correu na cruz, precioso sangue.

Quando Jesus por mim morreu para a glória abriu a porta
Plena certeza concedeu da nossa vitória

Ele voltará em breve para a hora triunfal

Ele na cruz por mim verteu precioso sangue.

Jamais se viu am

À sua vida ele d
M

Or igual para resgatar o homem

agende o derramou seu sangue

ci nocente, fez-se réu só por amor
ção nos concedeu, precioso sangue.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'eddfb2cb-05d4-568c-bca1-9f2dee5cbc5d', 63, 31, 31) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'2df1d607-7c0f-5b19-825d-0a8189ef858f', E'AVIDA DO CRENTE', E'Na vida do crente existem dilemas
Existem problemas difíceis também
Momentos de lutas que o crente passa
Buscando resposta naquele que tem
Então para os salvos, amigos de Cristo
Que vivem uma vida de fé e temor

E Deus que é fiel e contempla seus filhos
Envia a resposta, o Consolador.

Olha, pode ser agora

Deus vai dar a resposta à tua oração
Canta: a vitória é minha!

Pois quem em Deus confia

Tem a benção nas mãos.

É Deus quem promete ao que lhe suplica
Vitória nas lutas e tribulações

Ão crente sincero que sofre, mas fica

Da igreja e de Cristo ele não abre mão

E se Deus nos prova, com toda certeza,
Espera que a ele sejamos fiéis

Quem segue a Cristo a cruz não rejeita
Caminha confiante o seu alvo é o céu.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'2df1d607-7c0f-5b19-825d-0a8189ef858f', 64, 32, 32) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'0c66f789-c056-57c5-88ba-0deb425b50f9', E'ESPÍRITO SANTO', E'O vem Espírito de Deus, a minha vida renovar

O vem Espírito de Deus, a minha fé fortalecer

Espírito Santo, canto, oro, a ti clamo, quero receber
Espírito Santo que envolve o crente, ó vem me envolver.

No Espírito Santo línguas dos anjos posso falar
O Espírito Santo inspira o nosso cantar

O Espírito Santo Deus me quer batizar
Espírito de Deus, vem nossas vidas abençoar.

OR') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'0c66f789-c056-57c5-88ba-0deb425b50f9', 65, 32, 33) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'ca76db77-4ea4-506f-bdba-f9f1d73af8ac', E'AMOR, AMOR, AM', E'66
| Deus, quanta gente que não conhece e nem sente q ve
Ó peu em que amam e falam constantemente neste puro dom “a
. FA E]
di adade vazia, essa gente não mostra conhecer 0 real Valor
a ve , |

dessa gente ele é tão diferente, é sem emoção
ade é sentir igualdade, é sentir comunhão,

Não é apontar os erros, net anogtear Id se destruição

É saber na ver dade, onde há ódio e maldade não existe amor

Pois quem ama perdoa, não irrita ou magoa, mas dá amor.

Pois o amor

Amar na verd |

Amot, amot, Amor, AMOL, como é fácil falar de amor
Amor, amot, amor, dizem só por dizer

Oh como eu queria ver o amor nos homens renascer
Vivendo a vida que Cristo ensinou, vida de amor.

Ó meu Deus, quanta gente que na verdade só mente

Quando diz ter amor

Pois no peito carrega a inveja e espera o momento de ser vingador
Traz falsa aparência e se sente feliz se um irmão fracassou

Mas não vê seus erros, se acha perfeito e do mundo se acha seu senhor.
Mas ainda há esperança, pois quem ama alcança, não, não deixe de amar
Pois o desiludido de um mundo unido um dia se alegrará

Quando ver o perverso transformado num gesto puro de amor

E o homem sofrido, que amou sem ser visto, ser mais que vencedor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'ca76db77-4ea4-506f-bdba-f9f1d73af8ac', 66, 33, 33) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'ba6c8ab9-0ca2-583a-83c6-594a683cbe2a', E'TU ÉS TUDO PRA MIM', E'Oh! Que amor tenho sempre em ti
Desde quando eu te conheci
Sinto dentro do meu coração
Quem me dera te ver e pegar tuas mãos
Abraçar a quem tanto sinto amor

8 tudo pra mim, Senhor, Senhor.

Eu quisera poder sentir
U és meu

u
Que Vontade tenho de te ver

quem tanto sinto amor
>

E, .
8 tudo pra mim, Senhor, Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'ba6c8ab9-0ca2-583a-83c6-594a683cbe2a', 67, 33, 33) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'64934a31-1707-5c6a-bb61-72c733766ac3', E'O SEGREDO DA VITÓRIA', E'O segredo pra vitória alcançar

Nos teus problemas que você quer resolver
Agradando, obedecendo a Jeová

O teu problema você poderá vencer

Pode sim, Jesus pode resolver

O teu problema Jesus pode resolver
Se orares confiando e obedecer

O teu problema Jesus vai, vai resolver.

Não há barreira que impeça o teu poder
Não há problema que tu não conheces bem
O impossível Jesus faz e é só crer

O teu problema Jesus pode resolver

O teu problema que desejas resolver
Jesus conhece e pode ajudar você

É confiando e obedecendo que se vê
Nossos problemas Jesus Cristo resolver.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'64934a31-1707-5c6a-bb61-72c733766ac3', 68, 34, 34) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'435e1b77-a3d8-5706-b5f3-366f65160c01', E'O SENHOR É MARAVILHOSO', E'Ó Senhor, teu nome seja sempre
Entre todos homens dado glória
Pois de todos o teu nome é
Poderoso e excelso

Pois maravilhoso és, Senhor

Tu dominas sobre a terra

E de geração em geração

Tu és pra sempre e

Tu serás Senhor

E pra sempre,

Para sempre Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'435e1b77-a3d8-5706-b5f3-366f65160c01', 69, 34, 34) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'db0c50df-c125-5d44-90dd-a41f234f9139', E'A BELEZA DE UMA FLOR', E'Olhei a beleza de uma flor
O que sou pra ti, Senhor?
Muito mais eu sei que sou
Olhei o infinito azul do céu
À neblina como véu

antou
udo Isso im
eo entro re ou
inha alma se 8 68º
À min ti Senhor

ara tl,
orque P : or
Sá e tenho mais val

Mais valor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'db0c50df-c125-5d44-90dd-a41f234f9139', 70, 34, 35) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'c08a1172-02d4-5fe8-81bd-9249755665c2', E'EU QUERIA SABER', E'oh! Eu queria saber pra pe te e
Porque Deus mé amou. oh: Eu qu a

Eu queria entender, mas SO posso te

Sua vida deu por mim e por você

Eu só posso lhe dizer que aceitei Jesus
Aceitei o seu convite e entao

Minha vida entreguet

E lhe dei meu coração

E por isso canto hoje, sou feliz.

Oh! Eu queria saber, eu queria te explicar
Deus te ama e Ele quer te receber

Não importa como estás, Ele quer te ajudar
Sua vida deu por mim e por você

Faça o que um dia eu fiz, aceitei o seu perdão
E senti a minha vida renascer

Abra o teu coração, deixa Cristo te envolver
E serás feliz pra sempre em teu viver.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'c08a1172-02d4-5fe8-81bd-9249755665c2', 71, 35, 35) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'744dd532-d4a6-52d4-88b8-f05f38248e02', E'ÓVEMESPÍRITO', E'Ó vem Es

pírito, eu Ico:
Vem E » U suplico;

ns vem sobre mim
o pio, vem sobre mim
M Espírito
atend
Vem ench , er o desejo meu

ár É Elia 5
me, ó Espírito de Deus,

E, .
em me )
vem FE Me preparar
Vem E HO, saciar ,
spíri O desejo
Píirito d, Deixo Á meu
» Sobre mim.

6 Santo Espírito, grande, eterno Consolador
A minha alma vem transbordar

6 vem Espírito, és promessa do Salvador
Vem Espírito, encher-me de amor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'744dd532-d4a6-52d4-88b8-f05f38248e02', 72, 35, 36) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e4a131d5-192f-5180-8935-a9f17acb5eda', E'PARA CASA', E'Para casa um dia irei

Onde já me espera o Rei

Lá no céu onde vou me unirei aos meus
Pois eu sou da família de Deus

Ao chegar no céu quero ver meu Deus

E abraçar Jesus

Dos que a Bíblia fala e que foram fiéis eu sei
Um a um, oh, aleluia abraçarei.

Meu desejo é ver o meu Deus
Ver a casa que Ele me deu
Na cidade santa ver meu Jesus
E a mansão de glória e luz.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e4a131d5-192f-5180-8935-a9f17acb5eda', 73, 36, 36) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4d16517d-f8a4-5aba-929e-bb592f80b668', E'VIDA SÓ COM JESUS', E'Quero ter a minha vida com Cristo
Meu desejo, quero tudo lhe dar
Minha juventude e mais do que isso
Do poder do evangelho falar

Uma vida jovem cheia de vida

Onde Jesus Cristo é a razão de ser
Pois quem vive uma vida sem Cristo
Não conhece a razão de viver.

Viver a vida distante de Deus
E semelhante ao vento que passa
“8 uma vida ligada em Jesus
uma vida abençoada
uero uma vida mais perto de Deus
quero mais, muito mais da sua graça
Uero viver para sempre com Ele
Com Ele a vida não passa.
“US só com Ele a vida não passa.

m uma vida sem vida
o ondas que não ficam e nem vão
Tudidos com as falsas conquistas
u

Se acabam como espuma no chão

Ninguém pode ser feliz neste mundo
; .

Se provendo dos prazeres daqui

Se à consciência fala profundo |

Que os prazeres não o tornam feliz.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4d16517d-f8a4-5aba-929e-bb592f80b668', 74, 36, 37) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'db8570e9-897e-5435-92d3-5dc88abf4e1b', E'EM ADORAÇÃO', E'Muitos vive

Queremos louvar-te por nossas vidas

Por tudo que temos por todas as bênçãos

A nossa vitória vem sempre das tuas mãos
O tempo que temos a ti pertence

Louvar o teu nome é o que nós queremos
Vivermos na tua presença em adoração.

Obrigado Senhor, por todas as maravilhas

O perdão e o amor que tens dispensado sobre nós
E por essa razão que aqui nós estamos

Louvando e adorando o teu santo nome

Graças por tudo que vem de ti, Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'db8570e9-897e-5435-92d3-5dc88abf4e1b', 75, 37, 37) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'6f2d8d68-d04c-5969-be3c-afb9ce4b031e', E'ROCHA ETERNAL', E'Problemas querem minha alma tragar
Lutas querem me desanimar

Doenças querem roubar minha fé
Mas creio em ti, seja o que vier.

Deus, ó meu Deus

Não há outro nome igual
Protege os fracos filhos teus
Escudo seguro, rocha eternal

Om l
e barquinho na fúria do mar
mu
O e calmo sempre a navegar

Esto ã

o q ici não temo o furacão
U ancorar no Porto em Sião.

Nas horas triste

poa Cristo é à solução

é

O alvo do Cristão fiel
“aminho q

u€ conduz o céu,

S da tribulação') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'6f2d8d68-d04c-5969-be3c-afb9ce4b031e', 76, 37, 37) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9a1dcd0a-99a2-50f6-beb2-a1b2cfa54c12', E'MINHA VIDA PARA JESUS', E'uando à minha vida te entreguei
Quando o mundo e seus prazeres desprezei
Quando decidi seguir a cruz
Quando me envolvi, Senhor, em tua luz
Logo percebi que tudo encontrei
Tudo que no mundo em vão procurei
Quero minha vida inteira dedicar
Quero teu amor somente anunciar

E agora quando eu canto

Eu te louvo, meu Jesus
Glória Deus, glória a Cristo
Aleluia, aleluia, amém Jesus.

Quando a minha vida te entreguei

Logo percebi que tudo em mim mudou
Já não vivo eu, mas Cristo em mim

Seu poder a minha vida transformou

E ao mundo inteiro agora vou falar
Santo é o Senhor que veio nos salvar

E não há no mundo igual a esse amor
Dando sua vida Ele nos salvou.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9a1dcd0a-99a2-50f6-beb2-a1b2cfa54c12', 77, 38, 38) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'a85c4a2b-659a-5f74-8569-d030e093b3e0', E'VASO DO SENHOR', E'Quero te pedir, Senhor
Mais poder pra te louvar
Quero de ti mais amor
Minha vida consagrar
Meu desejo é ser fiel

Ser um vaso de valor
Cheio do poder de Deus
Vaso cheio de amor.

Quero te sentir, Senhor
Quero te glorificar
mo vaso aqui estou
nhor, vem me usar
Peço-te perdão, Senhor
Posso merecer
te louvo por amor
em, visita o meu ser.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'a85c4a2b-659a-5f74-8569-d030e093b3e0', 78, 38, 38) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'01aec354-0917-542b-b885-1edff1d9a328', E'SÓ TU SENHOR', E'uando vê
uando venho in”

Tua presença supheã”
ó tu tens poder

Porque $ ne
Quando sinto tua a

Me tocando com amor
Me quebranta O coração

Tua presença, Ó Senhor
Reconheço minhas culpas

Os meus erros tantos SãO

Mais não tenho outra saída

A não ser pedir perdão

És a única esperança

O conforto eficaz

Pois quem busca em ti alcança
A tão desejada paz

nho te adorar
interceder

Só tu quem podes me ajudar
Só tu quem podes me entender
Só tu quem podes me fazer feliz
Renovar o meu viver

Renovar a fé em mim

Por isso que eu venho a ti

Por isso eu quero me entregar
Para ser um vaso novo
Transbordar do teu poder

E ligado na videira

Muitos frutos conceder,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'01aec354-0917-542b-b885-1edff1d9a328', 79, 39, 39) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e7e7721b-6763-5419-a46b-7ab13692ec92', E'POR TI EU MORRI', E'E tieu vim, morri, dei a vida

suportei a humilhação
Sofri Por ti maiores angústias
sr] dor e grande afliçã

+. 4 o

E Por ti também eu fui desprezad
pa sendo o Filho de Deus .
a na cruz deixei ser Crucificado

ão há amor maior que o meu

Quem dá aves do céu o sustento?
Quem faz brotar a semente no chão?
Quem faz fluir da rocha as águas?
Quem faz bater O teu coração?

E também por ti que nada fizeste
Que eu morri e morte de cruz

E sem perguntar se o homem merece
Eu vim te dar a vida e luz,

Porém será mais duro e triste

Quando chegar pra ti o final

Se rejeitares não haverá quem evite

Que não recebas a vida eternal

Foi por ti enfim que dei o meu sangue
Pra te salvar sofri dor cruel

Para escrever no livro o teu nome

Eu sou Jesus, a porta do céu.

Eu sou Jesus a entrada do céu (final)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e7e7721b-6763-5419-a46b-7ab13692ec92', 80, 39, 40) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'101275a3-844f-5daa-80b9-931ec5a5827f', E'SANTO PARA TI SENHOR', E'Quero, ó Senhor, te dar o meu cotação

E juntos com meus irmãos vivermos em união
Ser melhor e ter prazer em te dar louvor

Santo para ti, Senhor, eu quero ser

No meu caminhar que vejam a tua luz
Que eu somente possa ir onde estás, Jesus
No meu viver quero o prazer
De falar de ti onde estiver

8 Senhor, meu Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'101275a3-844f-5daa-80b9-931ec5a5827f', 81, 40, 40) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b9057c57-2a2f-5c8d-a485-0fc8d19f734e', E'QUANDO VOU BUSCAR A TI', E'Quando a aflição me vem lutas querem insistir

m roubar a minha fé e fazer-me desistir
Num momento de oração sinto algo me envolver
Sinto sobre mim a tua mão que me ergue pra vencer

Quando vou buscar a tí, Jesus .
quando dobro os meus joelhos em ração or
“Ja em qualquer lugar, logo me sinto me.
“ando vou orar

tão me sinto bem e me sinto tão feliz
n -
EA aflição sinto tua graça em mim
E nha oração volto para agradecer

na min

Pela paz no coração pela graça pra vencer.
€') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b9057c57-2a2f-5c8d-a485-0fc8d19f734e', 82, 40, 41) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd62d6077-b05a-5705-9b2e-bb32785dc55c', E'QUERO MORAR NA CIDADE', E'Quero morar nã cid

uando

ade de outro e puro cristal

Cidade pura e santa, não entra tristeza nem mal

Lá não existe pecado, santo eu lá hei de ser |
Louvando ao Cordeiro sagrado, pra sempre eu hei de viver.

Deste mundo de dor eu desejo subir

Ao meu lar sem pecado minha alma quer ir
Oh! Quando, Senhor, que tu vens me buscar?
Deste mundo de dor, ó me leva, Senhor

Se meu viver for prudente, se como luz eu brilhar

E mais ser obediente eu sei que tu vais me usar
Quantos estão fraquejando por falta de força e poder
Reveste-me com o fogo santo, me usa pra os aquecer.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd62d6077-b05a-5705-9b2e-bb32785dc55c', 83, 41, 41) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'da0cd7eb-87a7-5edb-8dd7-3f9f21cc712f', E'QUERO CONHECER O MEU SENHOR', E'Quero conhecer primeiro meu Senhor
Conhecê-lo muito mais e bem melhor

Sua voz me faz sentir paz que me faz descansar
Conhecê-lo é saber como agir

Conhecê-lo para mim é ideal

Seu querer será meu referencial

Com prazer irei ouvir

Seu querer o
x » O que farei
Conhecê-lo bem melhor será eu sei

Quero conhecê-lo
Conhecê-lo bem n
E sentir no meu a
Conhecê-lo é saber pr
Conhece-lo para mim
e uma forma que em iii

virtude de amar P Tesente está

» perdo
Conhecê-lo bem melhor pr ''
“Mim será,

bem no meu viver
às minhas expressões

que meus né :
pés ã
a onde ir guiados são

é ideal

Muitas vidas que precisam vir a Deus

É procuram ver aonde ele está

Quero conhecê-lo bem, transmiti-lo sempre em mim
ve os outros o reconheçam em mim também

Conhecê-lo para mim é bem melhor

E que eu seja uma forte indicação

Onde Deus presente está, onde outros vejam sim

Conhecendo a Deus olhando para mim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'da0cd7eb-87a7-5edb-8dd7-3f9f21cc712f', 84, 41, 42) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4021c121-0393-56b9-ba31-135094c81342', E'QUERO Ó DEUS', E'Quero, ó Deus, dar-te a minha vida
Enquanto viver servi-lo, ó Senhor!
Viver cantando aleluia

Glória a Deus, Senhor

Bom é cantar a Jesus

Bom é louvar ao nosso Deus
Criador da terra e dos homens
Deus presente está dentro de nós.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4021c121-0393-56b9-ba31-135094c81342', 85, 42, 42) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'532c6ffd-8996-578e-8744-a213d6644f1f', E'QUEM É ESTE HOMEM', E'Quem é este homem?

De onde vem? E quem são os seus parentes?

O que Ele fala são palavras diferentes

Por que lhe segue essa grande multidão?

Quem é este homem?

O seu olhar é diferente

O seu semblante é uma pureza

Que jamais foi vista antes

Os que lhe seguem dão louvores e glória a Deus

Ele é Jesus, o próprio Filho de Deus
Que veio ao mundo trazer a luz
Curar os homens dos pecados seus
E dar liberdade e paz interior

20 enfermo repreender a sua dor
Ele é Jesus o único Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'532c6ffd-8996-578e-8744-a213d6644f1f', 86, 42, 42) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'14f79cc6-ffad-5f63-8231-501f050ce7d6', E'SENTIR A PRESENÇ A DE', E'| D
Quero sentir a Presença de De Ds
No coração senti-lo em mim ''s
Sentir na vida O seu amor

Sentir a Presença do meu Senhor

Nada, nada melhor

Nada pode nos Separar

Só Cristo Pode alegria nos dar
Só Cristo pode nos alegrar

Quero estar na casa de Deus
De coração servi-lo, enfim
Dar-lhe o meu constante louvor
Nunca, jamais deixar o Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'14f79cc6-ffad-5f63-8231-501f050ce7d6', 87, 43, 43) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'21ef7e7f-4589-5348-90ac-4e443349b19e', E'NOSSA MISSÃO', E'Quando findar da missão na igreja na terra

Quando reunidos enfim para entrarmos na glória eterna
E cada crente afinal receber sua parte

À recompensa de quem trabalhou

E seu talento com fé granjeou

Oh! Que glória, aleluia.

Vamos irmãos nos unir

Fazer a vontade de Deus

Quem prometeu é fiel, Ele cuida dos seus

No dia do juízo tinal Ele vaí recompensar

Todo esforço e trabalho de quem para Deus semear

Tudo nos mostra enfim que o final se aproxima n
É a vitória da igreja e sobre o mundo a justiça divin
E para quem com amor dedicou sua vida

O galardão vem nas mãos de Jesus

Uma coroa em troca da cruz

Oh! Que glória, aleluia.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'21ef7e7f-4589-5348-90ac-4e443349b19e', 88, 43, 43) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'58bdab5e-50e3-5f10-9582-c2352eb0f391', E'JESUS É MEU', E'Somos jovens, somos felizes
E por isso louvamos a Deus
Com Jesus nunca sou triste

E assim amigo sou eu

Vivo cantando (a cantar),

Vivo orando (a orar)
sou de Jesus, sou todo dele

E quero dar (muitas glórias)
Aos meus amigos (contar sua história)
Jesus é meu.

E ser jovem é ter na vida
Alegria e satisfação

E Jesus é a coisa mais linda
Que eu tenho no meu coração.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'58bdab5e-50e3-5f10-9582-c2352eb0f391', 89, 44, 44) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'bcab0863-fc1f-5d38-89cb-a5c7de9e26da', E'IGREJA DA ROÇA', E'Tenho saudade da igreja lá da roça

Sempre tinha coisa nova, era igreja de oração
Não tinha ônibus, nem trem, não tinha carro
Era a pé ou a cavalo, uma grande animação

E na igreja não se via vaidade

Era só simplicidade, reverência e adoração

E quando a igreja com o pastor se reunia

O poder de Deus descia confortando os irmãos.

E na cidade, muitas vezes não entendo

Muitos vivem sem ter tempo para o culto de oração
Muitos enfermos e tantas dificuldades

Falta mais sinceridade, mais amor no coração.

São muitos poucos que tem assiduidade
esmo com facilidade vivem na murmuração
alta técurso, nunca sobra o mantimento,
únca há contentamento, nunca há satisfação.

À Solução é ser simples, é ser sincero
ndar no caminho reto, é viver em oração
Com j Igreja sempre que for necessário .
anjo ao nosso lado, com Jesus no coração.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'bcab0863-fc1f-5d38-89cb-a5c7de9e26da', 90, 44, 44) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'2cd44b74-1c4f-5171-91b5-3029367557f6', E'TEMOS LUTAS NESTA VIDA', E'lutas nesta vida, meu Senhor, e
ta
Ele a alii abatida e sem fé eu e
E em io à aflição, me sentindo a ao
e . . E
Pula ocê o coração, pois te vejo ao m

os nada
Meu Senhor, eu reconheço que sem tí não som
,

oreja armada
''o desta tua Igreja
bes o anseio de
pdoe o momento de nas nuvens te encontrar

U f A
A fim do sofrimento, ninguém vai nos separar.

Me perdoa as fraquezas, eu me sinto a
Quando me falta firmeza e me vês desanimado

Mas prometo te amar, ser fiel a ti, Senhor
Nunca vou te abandonar, pois tu és meu Salvador.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'2cd44b74-1c4f-5171-91b5-3029367557f6', 91, 45, 45) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'50e4f426-202d-5ad4-aa37-d58364e9e645', E'PERDOA-ME OUTRA VEZ', E'Quando sozinho me ponho a pensar
Reconhecendo, Senhor

Tua presença me faz repensar

Qual o caminho que estou

E no desejo de te agradar

Então retorno, Senhor
Humildemente a ti, suplicar

À tua graça e favor.

Tira de mim tudo que não é teu
Limpa meu ser Por inteiro

mM merecer me Perdoe outra vez
Pois tu és o Deus Verdadeiro,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'50e4f426-202d-5ad4-aa37-d58364e9e645', 92, 45, 45) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'43e8edb6-854c-5ce2-9a9a-d86ab8696546', E'SER FELIZ', E'ia feliz, Pois tenho Cristo em Meu viver
ou feliz, à paz de Cristo habita em mim

feliz e não receio em lhe contar
ou cível à felicidade obter
É poss do à razão, Jesus Cristo é a solução
pc omente se creres vai receber
Tão 4 esprezes O convite, venha hoje a Jesus
a espera e te receberá
e té tão tu cantarás

en
E a qe pode acreditar
Sou feliz. Oh! Como sou feliz
dE ROSDO então tu cantarás
sou feliz é pode acreditar
Sou feliz, sou feliz, sou feliz.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'43e8edb6-854c-5ce2-9a9a-d86ab8696546', 93, 45, 46) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'717e7d69-8172-563b-b133-78442abbd59c', E'COM AMOR, COM LOUVOR', E'Quero ter meu viver em mais comunhão
Minha vida, o meu ser, o meu coração

Quero dar a Jesus o que tenho de melhor
Meu louvor, com amor, tudo para ti, Senhor.

Meus irmãos se pensarmos no que virá

Na alegria e no gozo que teremos lá.

As mansões celestiais, rua e muro de cristais
Como anjo serei e com Cristo reinarei.

Do seu trono, o Senhor com justiça regerá

Com amor, com louvor, para sempre assim será
Glorioso Senhor, Ele apascentará

Como anjo serei e com Cristo Reinarei

Para sempre, para sempre. Amém!') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'717e7d69-8172-563b-b133-78442abbd59c', 94, 46, 46) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'29655dae-22f3-5471-9a07-f9927a7c7782', E'CARAVANA ESPECIAL', E'Sou passageiro em terra estranha
Meu destino é o céu
Pelos vales e montanhas
Er desejo é ser fiel

M direção à terra santa
*rra que mana leite mel

esa ei (eu chegarei)
sã destino é o céu
a celestial
e Que mana leite e mel
Sarei (eu chegarei)

No céu já tenho o meu lugar

Nesta caravana viajar.

Não há igual Er na terra
aravana especi
Todoé que ri se alegram
Esta viagem é real
Quando chegar ao seu
Já nos espera O Salvador |
Que nos dará o seu bem-vindo
Vinde, benditos do Senhor!') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'29655dae-22f3-5471-9a07-f9927a7c7782', 95, 46, 47) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'2dd12588-e4f7-5e5b-a5c3-906b454b7201', E'OS DOIS DISCIPULOS NO CAMINHO DE EMAÚS', E'destino

Sozinhos andavam de volta pra casa dois servos de Deus
Iam conversando, de Cristo falando o que sucedeu

E não perceberam que um companheiro se aproximou
Era o Messias que tudo ouvia e lhes perguntou:

Por que estais tristes? E no que consiste o que vós dizeis?

E eles lhe responderam: vieste de onde? E como não sabes o que aconteceu?
Mataram Jesus, pregaram na cruz o nosso Senhor

Três dias já há, sepultado está e tudo acabou.

E dele falando a escritura explicando, lhes repreendeu.
Convinha que Cristo passasse por isso, era plano de Deus
Chegando ao destino, o tal peregrino seguindo passou
Mas o convidaram que ali repousassem e Ele ficou.

Naquele instante o mais importante ia acontecer

Fez uma oração e partindo o pão que iam comer

Seus olhos abriram e viram o brilho, era o próprio Senhor
Naquele momento de contentamento Jesus se ausentou.

Oh! Irmãos, Jesus Cristo
Nós falamos com Ele,
Sentimos arder nossos corações

Oh! Irmãos, que alegria! Ele entrou no meu 1.
E tomando o pão começou a orar A
E voltamos correndo Pra vos avisar.

está vivo entre nós
ouvimos sua voz') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'2dd12588-e4f7-5e5b-a5c3-906b454b7201', 96, 47, 47) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'ff732f84-8e3a-504d-8ac2-27ea7ac63ba3', E'SE ESTÁS SOZINHO', E'se estás sozinho, se tu sentes solidão
Se est 4 ferido o teu coração, oh,
a qual for à tua dor, seja qual for o teu sofr
jesus Cristo hoje te ajudará a vencer “

oh! (por que temer)?

Vem (hoje à Jesus)

Ele te ajudará a vencer

E se a Cristo te entregares
Tu terás a liberdade

E paz para viver.

Olhe, meu amigo

Hoje estendo a minha mão
Quero ser amigo

Quero ser irmão

Ooh! Erga a cabeça

Olhe em nossa direção

Tu terás vitória

E paz no coração.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'ff732f84-8e3a-504d-8ac2-27ea7ac63ba3', 97, 48, 48) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'63b94483-853c-5571-9bd9-40fb46a89349', E'SOU UM SERVO TEU', E'Senhor, eu sou tão fraco

Tão infiel e cheio de mal

Senhor, dá-me amparo

Quero findar com a coroa real

Sou jovem, mas sou teu servo

Estou lutando para servir-te melhor
Perdoa os pecados meus

Eu creio em tí, sou um servo teu (bis)

Senhor, na minha tristeza

És o consolo, a força maior

Senhor, nos meus problemas

Eistás comigo, nunca fico só

Sou jovem, mas sou teu servo,
amaste-me à tua obra, Senhor.

Sou jovem, mas sou sincero

Eu desejo servir-te melhor (bis)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'63b94483-853c-5571-9bd9-40fb46a89349', 98, 48, 48) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd716cca9-bf3c-5dd0-83f1-1efb85d78b3d', E'FOISÓ pOR AMOR', E'Não escolhi a j Di
Primeiro fui amado, e ue cado isso
E pra levar-meé ao paraíso, à vaç

u sangue E
cruz morreu, Sé ;
= ue Ele estendeu sua mão

Foi por amor q Eh is

s meus pecados ofereceu perdão |
upa não tinha nada, à minha dívida foi paga
O sangue de Jesus me resgatou

arado, quero produzir
em jesus
alavras abençoadas

Não vou ficar p
Os frutos desta nova vida
Ter a vida consagrada, ter P
Como ouro fino que reluz
A todos indecisos dar a decisão

O mundo é vaidade, pura ilusão

Só Jesus é na verdade a real felicidade
Vida, paz, Amor e salvação.

Vida, paz amor e salvação.

Jesus Cristo é a salvação.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd716cca9-bf3c-5dd0-83f1-1efb85d78b3d', 99, 49, 49) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'89e02b80-70e4-5c91-ad05-2b48807a9904', E'SENHOR, QUANTA TRISTEZA', E'Senhor, quanta tristeza no semblante de tantos irmãos
Senhor, é fácil encontrarmos muitos crentes e poucos cristãos
Conserva, Senhor, na minha vida o brilho do reino do céu
Conserva, Senhor, na luz bendita os santos e o Cristão fiel

Lemãos, não se apressem em sair deste santo e bendito lugar
A benção tu podes impedir, mas se queres Deus pode te dar
O mundo não tem mais valor, de Deus ele se esqueceu

Aumenta, Senhor, em mim o amor e zelo na obra de Deus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'89e02b80-70e4-5c91-ad05-2b48807a9904', 100, 49, 49) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'58d099a7-e923-56a2-af4f-ddc80e1ba1a9', E'SENHOR QUE SONDA O CORAÇÃO', E'Senh ã
Tr Or, que sonda o coração e pode abençoar
us servos que em iã
santa união aqui
rd qui te vem louvar
a? m conheces cada um, o nosso coração
enhor recebe o louvor e a nossa adoração

sei não poderia enfim por mim te

m o meu maior prazer está em te Pc
undo do pecado vil liberto estou s var
minha gratidão, recebe o meu K enhor

gem
poté
po m

Aceita uvor,

pot Senhor, eu quero dar se até preciso for
vida, os bens são todos seus, fiel até morrer

edico meu viver e tenho toda fé
inspira ver, Senhor, meu Salvador tu é
és.

pos di d
A cruz me') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'58d099a7-e923-56a2-af4f-ddc80e1ba1a9', 101, 49, 50) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'6adfd717-dacf-5b29-b86f-d6a9d8c5502f', E'JESUS, O MEU AMADO', E'Se meu coração está alegre, se eu sou feliz assim

Se em mim ha diferença eu digo: a razão é Cristo em mim
Não receio em contar-lhe o que Cristo fez por mim
Eu vivia triste, só no mundo, mas Ele me fez feliz

A Jesus, o meu amado
Amigo que me entendeu
E na hora que eu buscava
Esse amigo apareceu

E mostrou-me o caminho
E me estendeu a mão

Eu o louvo neste hino
Canto esta canção.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'6adfd717-dacf-5b29-b86f-d6a9d8c5502f', 102, 50, 50) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'87d7fe45-0635-51b5-9595-701e97145912', E'SÓ JESUS', E'Senhor meu Deus, quanta ilusão
Quantos no mundo lutando em vão
Por que, meu Deus, se tu és tão bom?
Se por nós tu venceste o mundo então?
O que se vê são homens tão maus

entando não crer no juízo final
Querendo viver uma vida normal, ausente d
Buscando alegria e satisfação

elicidade pra si e para os seus

egando a verdade que só é feliz

Uem vive com Deus

e Deus

Ninguém jamais será feliz A
Fugindo da vida que a Bíblia a

Trilhando o caminho que não e € es pa

Que por si mesmo julga ser caminho bom

Mas só em Jesus se pode encontrar

A satisfação que o mundo não dá

E lígado à igreja, o povo de Deus

Caminhar feliz para o céu

Olha você, que vive a chorar, vendo os problemas ne

E a Deus querendo culpar. Seja humilde em uma reflexão:

Tens confiado em Deus ou na força das tuas mãos? .
Sinceramente não posso crer que uma vida entregue nas mãos de Jesus,
Que do nada faz tudo acontecer, não tenha alegria ou razão pra viver,
De nada adianta o homem ajuntar, sozinho sem Deus tudo vai se acabar

Porém quem trabalha para o reino de Deus Ele faz prosperar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'87d7fe45-0635-51b5-9595-701e97145912', 103, 50, 51) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'01e1df5f-cbb4-5dab-af41-58c89920de5b', E'JESUS MEU SALVADOR', E'Só Jesus, meu Salvador, minha alma entoará

Hinos para em seu louvor seu nome celebrar

Seu amor me garantiu dos meus pecados o perdão
No livro dos somente seus meu nome Ele escreveu
Sua mão me segurou, meu coração Ele invadiu

O meu ser Ele tomou, tomou-me para si

Como agradecer a Deus o que na minha vida fez?
Dar-lhe-ei o meu louvor e tudo que me deu

Sinto que em gratidão eu devo de Jesus falar

Seu amor me atingiu e aos outros vou anunciar
Se aqui o meu louvor for pouco para expressar
Sei que vou pra Canaã Pra sempre te adorar

Vamos ao Senhor Jesus cantar, sim, em gratidão
Finos de sincero amor que falam ao coração

Sei que é dificil, enfim, agradecer ao meu Jesus

Por tudo que Ele fez por mim é Ele que me conduz
O Senhor, vem me usar e receber minha adoração
Para que o meu louvor alegre teu coração

————') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'01e1df5f-cbb4-5dab-af41-58c89920de5b', 104, 51, 52) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'8a39b1f9-8186-59ce-998d-203f125360f9', E'SEGURO ESTOU', E'seguro estou andando nos braços de Deus
Q meu caminho como luz será

: 1, Seguro v
Não temerei, segur ou nos braços de Deus
sem Ele eu não posso, não vou caminhar,

A vida com Jesus será muito melhor

Pois Ele faz acontecer o bem, o amor, também
Eu sou feliz, a minha vida peça

Está nos braços de Deus
Sem Ele eu não posso, não vou caminhar

Se lutas vem seguro nos braços de Deus

Sou vencedor jamais eu temerei

E sempre estou confiando e vou nos braços de Deus
Sem Ele eu não posso, não vou caminhar,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'8a39b1f9-8186-59ce-998d-203f125360f9', 105, 52, 52) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'46453a31-1f70-54de-829e-022522473eae', E'SINTO A PAZ DE CRISTO JESUS', E'Sinto a paz de Cristo Jesus, sinto a paz no meu coração

Sou feliz mesmo que venham lutas, com Jesus eu não temo a aflição
Sinto o amor de Cristo Jesus, sinto o amor no meu coração

Vou amá-lo, Ele me amou primeiro, vou amá-lo com dedicação.

Cristo, te amo, sou vencedor, nada no mundo me é melhor
Quero contigo pra sempre viver, nada no mundo me faz te esquecer.

E de ti quero ser mais amigo, quero ser mais sincero também

Sou feliz deixarei este mundo, sou feliz Jesus Cristo já vem

Foi por mim que Cristo Jesus,

Foi por mim que morreu lá na cruz

Do amor vou falar, a vitória cantar, sua morte me trouxe pra luz.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'46453a31-1f70-54de-829e-022522473eae', 106, 52, 52) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'421b5647-e1fc-526b-afb4-edf858345eca', E'SE', E'Se os Problemas na vida surgirem (surgirem)
Se as provas parecem aumentarem (aumentarem)
€a luta se mostra difícil
caté parece que Deus não existe
Se falta fé pra lutar e vencer

É em
E há Momentos que não se entendem (entend )

Se há dores que fazem sofrer ( fazem sofrer)
re blemas

5 exi a todos OS pro
E Deus E que de todos se lembra
oi púde e Ele vem socorrer ( socorrer)
Só Ele
Não há ninguém, Só existe Deus
Ele conhece os problemas teus
E se com fé buscar 40 Senhor peito
Ele atende, pois é Deus de amor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'421b5647-e1fc-526b-afb4-edf858345eca', 107, 52, 53) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9b129cfb-70ab-57b9-a0fd-edccfb55da56', E'AS TUAS IMPRESSÕES', E'Fonte de todo bem, amor e da vida
Vem de ti todo dom e sabedoria
Ainda que eu soubesse tudo aqui

Ainda que eu tivesse todos os bens. |
Sem as tuas impressões nenhum valor pra mim teria.

Quero brilhar
Quero ter Luz
Quero mostrar
O meu Jesus

Sem o amor de Deus eu nada seria

Sem a graça do céu eu não venceria

Com Ele tudo eu tenho e posso vencer

Com Ele nada poderá me deter

Faz resplandecer a tua luz em mim a cada dia.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9b129cfb-70ab-57b9-a0fd-edccfb55da56', 108, 53, 53) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'0cfda2cf-7bd7-5270-af85-00f0712dc631', E'LEVANTA E ANDA', E'Será num futuro glorioso

Para os salvos a Jerusalém

O lugar de descanso e repouso
O bem-vindo de Cristo também
Ali nossa luta termina

Iremos também descansar
Porém a palavra ensina

Aqui temos que trabalhar

ora final se aproxima
p tudo aqui terminar
anta e olha pra cima
em de Deus é marchar
o tempo está se esgotando
Ninguém poderá reclamar
Não fique parado olhando
Levante € comece a andar.

pe Cristo a promessa nós temos
No céu preparado um lugar

pe todo trabalho iremos

Pra sempre então descansar
Teremos nossa recompensa
Tesouro e riquezas sem fim
Levanta e entra na benção

Não fique parado assim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'0cfda2cf-7bd7-5270-af85-00f0712dc631', 109, 53, 54) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b6ba9a80-b7d7-5776-80e2-2923973882bb', E'QUANDO ATRAVESSAR O RIO', E'Quando atravessar O rio, que alegria sentirei!

E às margens desse rio me esperam os heróis de Deus

Que saudação eu ouvirei: vinde entrai na casa de Deus

Com Enoque, Isaque e Abraão. Que banquete às margens do Jordão!

Lev
ord

Uma grande recompensa para quem atravessar
Há alegria tão intensa quando do outro lado eu chegar

E aos amados que conheci eu vou dizer-lhes que eu venci
E um a um eu quero abraçar, aleluia, consegui atravessar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b6ba9a80-b7d7-5776-80e2-2923973882bb', 110, 54, 54) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'df9bb556-ad26-55d9-917a-c595b66c7b1e', E'SÓ O AMOR DE DEUS', E'Só o amor de Deus me faz sorrir
Só o amor de Deus concede paz
Seu olhar transmite para mim
Segurança e me faz feliz

Só o amor de Deus dentro de mim

Quero amar e de graça repartir
Perdoar como Ele perdoou
eus pecados, minhas culpas transpassou
Uero amar como Ele me ensinou
àssim já eu não viverei
28 em mim Ele aparecerá
Vero ser um mensageiro do Senhor.

RA') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'df9bb556-ad26-55d9-917a-c595b66c7b1e', 111, 54, 55) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e4ccaf1d-97dd-52b2-bc95-d5f99c684f4d', E'SOU JESUS E FALO AGO', E'írito do Pai
o ID PS a en tu serás
olhi pra uma Obra, um Epa

Ni Sd vides, crê somente, abra O te rã

ida ; e em k
Se firme, seja crente, viva sempr

,
amor em ti

ia humilde e corajoso, nunca falte E
Seja humilde e aDdã EETeocE
Seja forte e fervoroso, m

Seja santa tua vida e resista as tentações .

Sou o pão, a água viva, Eu sou Deus de gerações
,

Deves tu morrer agora para O sda ê pe aqui

Viva uma vida nova, viva em mim e Eu em ti.

Não duvides, nem perguntes porque Eu te escolhi
Eu sou Deus de hoje e ontem, faço o que resolvi

Não se esqueça que sou tudo, quero em ti lugar pra mim

Na verdade, seja mudo e Eu falarei por ti.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e4ccaf1d-97dd-52b2-bc95-d5f99c684f4d', 112, 55, 55) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'fbf62a60-02e2-59fc-b99d-387a18262285', E'DEUS CRIADOR', E'Sempre pensando nas coisas da vida

Tudo no mundo do nada nasceu

Mas uma coisa que mais me intriga

É a indiferença dos homens com Deus

Tanta beleza que alegra a alma

Da natureza se tira o amor

Das grandes montanhas aos mares profundos
Vejo a grandeza do Deus criador

Grande é Deus, forte e Mui poderoso

Deus de bondade e imenso amor

À alegria que invade à todos

E a alegria que vem do Senhor

Porém mais belo que o mund
ma mansão de infinito valor

Onde já tenho um lugar Feservado

onde reina o Deus Criador') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'fbf62a60-02e2-59fc-b99d-387a18262285', 113, 55, 55) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'6f2c5d71-01e1-5567-a4a6-794e7f7b4fa8', E'SENHOR...', E'senho r, nO mundo nós não temos alegria
juta É grande em nosso dia a dia

ne há prazer em nossos corações
nhor, EU só queria que chegasse a hora
« dar adeus ao mundo e ir embora

Embora para a terra de Sião

Chorei pot ver à humanidade no pecado
Os homens pelos vícios carregados

A injustiça e o desamor

Orei: Senhor, nos guarde em tua santidade
Proteja essa tua mocidade

O Guto do canteiro do Senhor.

Senhor, eu sei que estás olhando pro teu povo
Tu sabes que tu és O nosso gozo

Queremos ter contigo comunhão

Senhor, nos livra da maldade deste mundo
Pedimos lá do âmago profundo

Conceda-nos a santificação

Senhor, a nossa oração aqui se finda
Enquanto aguardamos tua vinda

Nos livra deste mundo tão cruel
Senhor, batiza-me com Espírito e fogo
Para vencer o mundo perigoso

E receber o galardão no céu.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'6f2c5d71-01e1-5567-a4a6-794e7f7b4fa8', 114, 56, 56) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'6d2148e1-9f3f-5dab-9969-ec29d459d8a1', E'CONFIANÇA', E'Teus anjos nos acompanhando
Nossos olhos não podem ver
Na frente eles vão nos guiando
À ordem é nos proteger.
quando louvamos teu nome
NtUmos alegria e prazer,
Mtimos o Espírito Santo
Ni Fis alegre cantando
ria de Deus se envolver.

uem vai receber

bes :
Salva agora, tu so Cábeii queremos cumpri teu querer
um

Estamos sen nós pedimos poder
Manda agora do Sam e renova que pede com fé.

Batiza com Es,

alegria é visível

dá pra ficar. ''

São anjos que estão passeando

Da porta até ao altar.

Irmão fica atento agora

Não deixe de glorificar.

A benção já está chegando

Deus sabe o que mais precisamos.
Não deixe a benção escapar.

Na igreja à
Calado não') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'6d2148e1-9f3f-5dab-9969-ec29d459d8a1', 115, 56, 57) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9c669d69-0b8f-5dc1-8bed-fb4b828ec99a', E'SURGE BRILHANDO NA HISTÓRIA', E'Surge brilhando na história com poder e glória em nosso Brasil

Para um real cumprimento, esse acontecimento na igreja surgiu

Um movimento entre os crentes, hoje ainda se sente falar aos corações
A voz de Cristo soando, clamando: é tempo de restauração!

A todo crente, do jovem ao ancião

Que seja reluzente em meio a grande escuridão

A luz de Cristo refletindo, é tempo de restauração
No mundo mal e corrompido, como astro reluzindo
Apontando a salvação.

Bem longe no firmamento Os astros suspensos irradiam luz
a nas noites escuras o clarão da lua a todos conduz
uando ia há
es Rania o dia há grande alegria, a noite já passou
9Jé, O crente, seja reluzente brilhando no Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9c669d69-0b8f-5dc1-8bed-fb4b828ec99a', 116, 57, 57) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e1d9ff61-2894-5812-9add-2e540d70ba44', E'VOU ESTAR COM MEU SENHOR', E'Vou estar com meu Se

nhor tun 2
No meu lar que não à » Juntos em Jerusalém

qui onde breve chegarei

Ão passa
ro rio além
me es
Esta vid E pç
aa vador
Squecerei, nova vida

. » Santa e pura, eu terei
Onde não terei pd

k mais dor,

. roupa
S tri Pas nova :
Stezas esquecerei no S eu terei

meu lar de Paz e amor

u j endor
or.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e1d9ff61-2894-5812-9add-2e540d70ba44', 117, 57, 57) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'708b2501-f783-56f3-8cb1-06af5749099e', E'LINDA CANÇÃO', E'Vou cantar uma linda canção

e amor que transmite a paz
Como base ela tem o perdão
E a todos OS corações satisfaz
Que transforma em tudo o meu ser
Que me traz alegria em cantar
Que morrer com Cristo é viver
Que viver com Cristo é amar.

Vou fazer um convite a você

Não se esqueça o que vou te falar
Jesus transformou o meu ser

E chama pra te transformar

Não rejeites e venha dizer

Vem comigo juntos cantar

Que morrer com Cristo é viver
Que viver com Cristo é amar') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'708b2501-f783-56f3-8cb1-06af5749099e', 118, 58, 58) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b5970250-c6a3-582a-a670-a3464ca45217', E'UM DIA CRISTO OUTRA VEZ', E'Um dia Cristo outra vez nas nuvens aparecerá

E todos os remidos seus Ele levará

E cantarei hosanas a Deus e deixarei o mundo atroz
E não mais lembrarei daqui, sim, nunca mais.

Com Jesus Jesus) eu partirei

E pra sempre, sempre anjo serei |
Hosanas nas alturas, hosanas sempre ao Rei
Com Jesus Jesus) não lembrarei

Das angústias que no mundo passei
Com Jesus Qesus) eu para sempre anjo seret.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b5970250-c6a3-582a-a670-a3464ca45217', 119, 58, 58) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'cabdb265-f2f0-5b23-bfe9-df458401bf02', E'VEM FAZER EM MIM', E'Vem fazer em mim, Senhor, o teu querer
à EU quero obedecer ao teu dizer |
82, ó Senhor, pra mim, eis-me aos teus pés aqui
“Ja O que quiseres, sei que é o melhor pra Raia.

rr!

; * queimar
Eu sinto em im
Eu quero 1 ie que devo if

Eu sinto em m Mr
Pois cristo veto e me S€.

Eu vou partit') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'cabdb265-f2f0-5b23-bfe9-df458401bf02', 120, 58, 59) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'960b6cf4-b76c-5a52-a183-c3a7304c4e9b', E'EU, VOCÊ E JESUS', E'Você me ama, €U te amo
Vamos unir à$ nossas mãos
E a partir deste momento
Que seja um OS nossos corações
Com um sorriso bem aberto

A alegria se traduz

E como a rima desses versos
Que seja um: eu, você e Jesus. (bis)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'960b6cf4-b76c-5a52-a183-c3a7304c4e9b', 121, 59, 59) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'eca48fa5-16e1-527a-80b3-fcdd21b3a803', E'ROCHA ETERNAL', E'Seguro em Cristo o crente caminha
Mesmo que a luta seja cruel

Não se abate, não desanima

Dá testemunho de crente fiel

Cristo é a rocha firme e segura

Quem nele crê tem vida eternal

Só ele salva, livra e cura

Cristo é a rocha firme e segura contra o mal

Seguindo a Cristo, nele firmado
Todo cristão será vencedor

Em oração, com todo cuidado
Caminha firme com fé no Senhor

paia vencer a vil tempestade
mundo que tenta
nos demov.
et
Ro o alvo: Cristo, a verdad.
a a “ Eq e
e ninguém pode o crente deter') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'eca48fa5-16e1-527a-80b3-fcdd21b3a803', 122, 59, 59) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'5a1b3f38-9fd7-5b93-beec-f3628e694d22', E'A NOSSA FORÇA É O SENHOR', E's o mundo em total confusão
da parte o maior turbilhão
Matam € morrem sem saber porque
Ljsam à maldade pra se defenderem
omo vencer esse mundo cruel?
Como tornar-se um crente fiel?
Cristo é O caminho pra quem quer Vencer
Ele é à graça, à força e o poder.

vemo
Por to

Minha é a vitória, não vou desistir

Cristo garante que vou conseguir

para lutar Ele tem o poder

Ele é a força que preciso ter

O inimigo é astuto e feroz

Mas clamo o sangue e Ele escuta minha voz
Sínto o Senhor envolver o meu ser

E tenho a força que me faz vencer

Na esperança de um mundo melhor
Quantos que lutam e querem vencer
Mas na verdade está tudo pior

Pois no pecado desejam viver

Mas para os crentes em Cristo Jesus
O novo mundo é coisa real

Não há mais trevas e raiou a luz
Temos a força que vence o mal.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'5a1b3f38-9fd7-5b93-beec-f3628e694d22', 123, 60, 60) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4d3be40d-0a99-5222-8521-f54b432e3ef2', E'EU VIVEREI, TU VIVERÁS', E'Vivo a vida neste mundo
Sei sim que breve vai findar
É nova vida me espera

Sta, sim, jamais terminará

Eu viverei, tu viverás
Untos ao lado de Jesus
Jo serei, anjo serás, anjos de luz
Temos um, todos iguais
“N mais tristezas dores e ais =
“legria, amor e pra sempre teremos P

i o
Quero viver aqui nO ee
Como um cidadão do á
Num verdadeiro testem E
De cristão exemplo dos

ps  vEMJES

stá chegando à á
inar O que V
O céu, à lua € todo ser

e A
Jesus Cristo em glória aparecend

Toda terra € todos os seres tremendo
E tanta alegria sei que jamais senti
Só imaginando como tudo acontecera
Se num lado O mundo em aflição
Desespero, correria em vão

Entre os salvos O gozo da redenção') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4d3be40d-0a99-5222-8521-f54b432e3ef2', 124, 60, 61) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'00c2510d-ec85-596a-8ae8-c0e462ad5b85', E'Us, 6 SIM VEM JESUS', E'ora de irmos
aí acontecer

Vem Jesus, ó sim, vem Jesus

Nós estamos te esperando

Vem levar-nos para nosso lugar
Vem Jesus, vem Jesus, vem Jesus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'00c2510d-ec85-596a-8ae8-c0e462ad5b85', 125, 61, 61) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'400cc4ac-537d-512a-a4bb-49782c8177ff', E'ERAASSIM...', E'Quando outrora eu vivia no mundo

Quando andava sem destino e sem rumo
Era triste, não tinha alegria no meu coração
Quando outrora era um peregrino

Quando não sabia meu destino

Procurava para minha vida

O que existia, qualquer emoção.

Er ]

ó pista o meu passado triste

Espe a gente existe nesta condição
tando que alguém evite

Onde 5
O mal persi
persiste na destruição

eu quero
Ser um j
Para o mundo in mensageiro

E salvar do fogo ris conhecer Jesus
o
Para o lar eterno inferno

» Para o lar de luz

dia encontrei com Cristo

MS e deu visão do meu destino
Que" a triste, tenho alegria no meu coracs
ão SOU À ração
N - falo para Os meus amigos
Ho| esus é o verdadeiro irmão
Que nem se encontra perdido
di rer um destino, sem ter direção.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'400cc4ac-537d-512a-a4bb-49782c8177ff', 126, 61, 62) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'3453e8f4-c72f-5540-89c4-dace127afd9c', E'USEI QUE ELE VIRÁ', E'ando As Vezes eu vou ao passado é Contemplo o que Cri

o fico maravilhado porque sinto a Presença de Deus dO me fez
E se choro não me envergonho, a alegria é grande demais

gu vivia sozinho no mundo, eu não tinha alegria nem paz

Mas agora eu canto alegre, me sinto liberto do mal

Realmente eu hoje sou livre, hoje tenho comigo a paz

E unido à minha família, à igreja que Cristo me deu

Vou vivendo esperando o dia de ir para o céu,

Eu sei que ele virá (virá), quero vê-lo bem perto

Jesus Cristo, te amo, tu és toda razão do meu canto
Quero ser o primeiro, quero ver o teu rosto

Vou dizer ao mundo inteiro que tu és o meu rico tesouro

Se no mundo eu era sozinho e em caminhos errados andei
Procurando em prazeres da vida preencher a ausência de Deus
Minha vida não tinha sentido, tudo era rotina pra mim

Vaidade era o que existia, ambições e desejos sem fim

Vi que existe na vida dos homens que querem uma vida sem Deus
Um vazio, uma angústia constante, desespero e embriaguez

Mas Jesus apresento agora, foi por todos que Ele morreu

Ele é fonte da água da vida que jorra de Deus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'3453e8f4-c72f-5540-89c4-dace127afd9c', 127, 62, 62) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'21a04043-1110-57cd-a90a-ecede5b10623', E'EUQUERO SANTO SER', E'a sim, ó meu Senhor, prostrado sempre 20 teus pes
ver cantando o amor. Jesus, santo, santo éS

Pi a ti se chegará sem ter a santificação
“antos, santos haverá porque tu és à purificação.

Eu ,
. Quero santo ser, quero me santificar dá
Maior desejo é ver o leão da tribo de Judá

ant À da
k 9, Santo, cantam os anjos em união
Juero ser santo, eu quero a santificação

— e aa

+ dizer aos que estão na escuridão;

uanto x
Quero enq em se arrepender, recebe dele a o
i u
A Cristo, q ais se consagrar, buscar a santi icação o
Porém, quem m plar o semblante de Cristo em Sião.

Então haverá de contem

aqui vIvE') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'21a04043-1110-57cd-a90a-ecede5b10623', 128, 62, 63) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'fb744e55-b06d-548c-bab5-acf2543f5a1a', E'DEZ VIRGENS', E'quero que preste atenção

istória.

Vou te contar uma his , j
Onde à vinda de Cristo esta numa comparação

m ao esposo encontrar

] À as saíra
s com suas lâmpad
Ea virgens eram loucas.

Cinco virgens eram prudentes e cinco
não deixe o azeite faltar

Ó não esqueça o azeite, j ;
Não deixe apagar a lâmpada, o esposo está pra chegar

Ó não esqueça o azeite, não deixe o azeite faltar
Quando Ele fechar a porta será tarde para se preparar,

Foram encontrar o esposo levando as tochas nas mãos
Cinco tinham o azeite e as outras cinco não viram razão
Porém, o esposo tardava, cansadas foram dormir

À meia-noite são acordadas: É o esposo que está vindo aí.

Então prepararam as lâmpadas e vejam só o que se deu
Cinco acenderam as tochas e as outras cinco nada acenderam

O esposo recebeu as prudentes e não pôde mais esperar
E as loucas que não tinham o azeite com o esposo não puderam entrar

Esta história ensina: Cristo está pra voltar

Quem não estiver vigiando com a igreja não irá triunfar
Vamos buscar o azeite, Deus pode nos dar

E sermos uma tocha acesa, a nossa lâmpada não pode apagar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'fb744e55-b06d-548c-bab5-acf2543f5a1a', 129, 63, 63) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'984bc11f-7b19-5a27-bba9-6235e11ec9a9', E'LÁ NÃO HÁ DOR', E'Vou para onde está Cristo

Onde desejo pra sempre ficar

O céu é o meu paraíso

Eu sei que brevemente Cristo me levará

pão há dor, nenhum pesar
Já a tristeza Já se verá
Ne e justiça nós vamos gozar
P não Se chora, ninguém morrerá
vou viver junto de Deus
Re ver meus amigos € Os entes meus
Estou aguardando Jesus me buscar
dou para onde Jesus Cristo está
que Jesus está vindo
nha morada já foi preparar
Breve estarei subindo
E para sempre vou com Ele habitar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'984bc11f-7b19-5a27-bba9-6235e11ec9a9', 130, 63, 64) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'5a631e45-1d14-52a0-b9e3-44038bbeaf49', E'REGRESSO', E'Você se afastou da igreja, deixou-se iludir pelo mund

Partiu para longe, distante, deixou seu lugar o
Achando que melhor seria viver as suas fantasias
Mostrando aparente alegria no seu caminhar

Porém, muitas vezes distante, uma voz lhe falava constante
Por você eu morri, dei meu sangue pra te resgatar

O inimigo quer ver a sua derrota, mas no sangue de Cristo há vitória
Volta agora, esta é a hora, é o momento de você voltar

Volta agora, esta é a hora, Cristo te chama, Ele te ama
Esta é a hora, volta agora, entrega tua vida a Cristo
Venha e receba a vitória.

Você hoje vive sozinho querendo voltar ao caminho
Porém suas forças são poucas, não sabes voltar
p ara
Amigo, esta voz que te fala também te ajuda e te amp
E Jesus, o amigo, Ele ajuda a recomeçar
E hoje também a igreja que te ama € orou € meia
e Você volte agora, esta é a hora pra recomeç
€ ora
Ceba um anel, outra veste, o abraço ag
NO sangue de Cristo há vitória escolhe
Olta agora, é o momento, é a hora de você') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'5a631e45-1d14-52a0-b9e3-44038bbeaf49', 131, 64, 64) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'5ed9dcee-76c7-5b9f-9db1-786052f98e33', E'JESUS FAZ RENASCER', E'Vamos cantando louvores

Ao nome de Jesus EM

Hoje agora € sempre, eluia

A quem nos deu vida e luz ,
Ob! Aleluia à Cristo eternamente eu quero render
Pois a minha alma cansada Cristo fez reviver

Enquanto há vida há esperança
Em Jesus tu podes crer

Ele é o último e o primeiro

Só Jesus faz renascer

Se hoje canto alegremente

Jesus Cristo é a razão

Se alegre vivo e sempre contente
Ele é a paz do meu coração.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'5ed9dcee-76c7-5b9f-9db1-786052f98e33', 132, 65, 65) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'0837f6a3-0265-5620-8967-49844b4f1571', E'TODO PODER VEM DE TI', E'Senhor, em tua presença nós estamos a cantar
Louvando o teu nome em quem podemos confiar
Pela tua graça e teu infinito amor

Visita nosso coração, Senhor!

Nós louvamos teu nome, Senhor
Bendito é teu nome, Senhor
Príncipe da paz, maravilhoso és
Todo poder vem de ti.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'0837f6a3-0265-5620-8967-49844b4f1571', 133, 65, 65) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e7039318-7b0d-5ede-9e37-091b662692f4', E'JESUS MINHA ALEGRIA', E'Vivo a minha vida para Cristo, vivo eu
Vou cantar (cantar) que feliz sou eu

E agora sinto, minha vida renasceu
Nova paz (nova paz) Ele me deu

a mim nasceu a alegria de viver
le é a razão Porque eu vivo
Dele é o meu querer
O amor d. um
e Deus é a razã
ão po. i ú
Eu sou feliz com J E

Q esus Cristo

”
ocê quer renascer
se vitória alcançar .
u « espera por você
“ar vida quer mudar
pe todos como irmãos
Ser! dos em um só coração
poça a vida, O Nosso amor
pasa à glória do Senhor.

você quer renascer
na vitória alcançar .
Deus espera por você

A tua vida quer mudar.

Y

; inha vida, canto pra louvar a De
quit (feliz), sim, feliz sou eu. ss
ja que Jesus me concedeu

Jiz
sou fe a alegr

rg «ar que feliz sou eu.

vou é') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e7039318-7b0d-5ede-9e37-091b662692f4', 134, 65, 67) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'2dc631ee-b071-53be-bbe4-c1c527a55119', E'FINAL DA JORNADA', E'no final dessa jornada
verei dia 2 missão que Ele me deu.
nha sido a minha cruz pesada.
ste mão por mim venceu.
- gle quem me deu a vida
a vida que à Ele dediquei
Por isso tenho alegria
pa missão cumprida
Os talentos granjeel.
Ócidade santa, minha pátria, meu país
Em teu terei a recompensa e casa que eu sempre quis
E entre os anjos, e arcanjos e os salvos redimidos do Senhor

oh! Glória, glória e aleluia, canto com alegria grande foi o seu amor.

Aguardo O dia glorioso
Com Cristo Jesus me encontrarei

Irei para o céu vitorioso
Os talentos que me deu multipliquei

Por isso quero trabalhar para Cristo
Na luta pela causa do Senhor

Terei no final dessa jornada

À missão recompensada

Como um grande vencedor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'2dc631ee-b071-53be-bbe4-c1c527a55119', 135, 67, 67) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'bc70b69d-5990-5d78-8433-d3dd61df04a7', E'TE QUERO SENHOR', E'E em meu viver, em meu dia-a-dia
U serei provado por ti, ó Senhor
Jéro provar a ti com alegria
Ué te amo, ó Cristo, te amo, Senhor

e pi alí sofrimento
averá terrível dor
Em que eu sofra por um momento
te amo e te quero, Senhor

'' u SO
E z em me
Me sinto feli E aidore

Von a ensamento
E me sustenta esse p a Gm,
Pois sei que um dia ter') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'bc70b69d-5990-5d78-8433-d3dd61df04a7', 136, 67, 68) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e2d3ab3b-7f7d-5155-bca9-198a652579ab', E'MINHA vITÓRIA', E'Minha vitória foi o seu sangue
Honras € glórias dou ao o En
A sua morte deu vida pra to a
E minha alegria, de noite ou de dià;
É louvá-lo com minha vOZ-

s temos 0 preço
o seu sangue nó
ao ap o seu sofrimento

Na cruz que nos É
Morrendo por todos € tudo só por amor
canto

E é por isso que hoje eu |
Me deste alegria, enxugaste meu pranto
Eu sou redimido, eu salvo estou

Quando eu canto alegro à alma

Penso na hora que vou te encontrar

Ver no seu corpo as marcas daquela cruz
Será glorioso pra mim

Ver o rosto de Cristo Jesus

Entrar na glótia, na vida celeste

Vestir-se das roupas que os anjos se vestem
Unir-se à grande família de Deus
Reencontrar os que viveram comigo
Conhecer de perto os cristãos mais antigos
Conhecer de perto o justo e fiel,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e2d3ab3b-7f7d-5155-bca9-198a652579ab', 137, 68, 68) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b28ea903-c298-525a-b492-f77e5bbff12a', E'NÃO VACILAREI', E'Meus segredos, meu viver

São para te louvar, Senhor

E quanto mais te busco, ó Deus
Mais quero te buscar, Senhor
Perto estás, eu sei que sim

Nada vai me atingir

Tudo O que quiser farei

Não, eu não vacilarei') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b28ea903-c298-525a-b492-f77e5bbff12a', 138, 68, 68) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4f703e6a-a1a6-55e6-bcab-9b5630d42a4b', E'E TUDO SE REALIZOU', E'Saímos em viagem missionária

Para cortar estrada ao nordeste do Brasil
Irmãs, irmãos, diáconos, pastores

Evangelista e todos em um só Deus nos uniu.
Partimos do Rio de Janeiro

Pra Itamarajú primeiro e Deus ali nos visitou

O casamento e a posse do pastor
Como o Senhor mandou e tudo se realizou.

Deus enviou lá dos céus as milícias de anjos
Deus conduziu nossos pés e ungiu nosso canto
Jamais eu poderia esquecer-me

Por que Deus cumpriu conosco a sua voz

Foi ficou e esteve na viagem bem junto de nós.

Para o norte da Bahia prosseguimos .
uvando a Deus com hinos e também em oração
Pois nosso Deus havia orientado
€ seriam consagrados a diáconos irmãos.
qimbém ali o ponto de trabalho
“la Organizado em igreja do Senhor
“US Visitou de perto O seu povo
E falou conosco e tudo se realizou.

Bahia
Então de Capim ps ordem do Senhor
4 partimos .
Para o Ceará p ar
A caravana Fr paz e apo Ta a serio
a egria [o
Cantava com

: entos
: zados os casam
Ali realiza Ito num momento o seu vaso Deus usou
Em um cu

r
E antes do regresso ao nosso a ce realizou
Deus mandou-nos visitar e tudo

tú BA) e Ceará
Itamarajú e Capim Grosso(i
fo esti em Pacajús no regresso. 22/11/99.18:40hs )') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4f703e6a-a1a6-55e6-bcab-9b5630d42a4b', 139, 66, 69) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'fdb5ce3f-6116-51e4-9284-c400a1b15825', E'O EVANGELISTA', E'(Inspirado no testemunho do pr. Luis Leite)

Dei minha vida nas mãos de Jesus

Fui humilhado, sofri por amor

Dos meus parentes ninguém entendeu
Mas atendi ao chamado de Deus

Fui para o campo Pregar por amor
Esposa e filhos deixei com meu Deus
É confiando no consolador

Ele cuidava de mim e dos meus

Muito cansado de tanto andar

Com muita sede e sem Pão pra comer
O Deus de Elias me vinha animar
Segue avante estou com você,

Em tecompensa ao ide de Deus

Vi muitas almas aceitarem a Jesus

À esperança é que no céu verei

Vidas marcadas com o Sangue na cruz') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'fdb5ce3f-6116-51e4-9284-c400a1b15825', 140, 69, 69) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'7c39ba59-a227-5bdb-ac0d-cf0803034019', E'EU SEI', E'al
| que no céu serei bem-vindo

pu st ue um novo lar terei
pu Se viverei entre Os remidos
pos os coroa trocarei
A a lá não haverá pecado
Eu A como Ele eu hei de ser
Eu ci ve num corpo transformado
No céu para sempre viverei

+ sei que Ele foi tão humilhado
eus ei que por mim tanto sofreu

sei que Ele foi crucificado
três dias sepultado permaneceu
Fu sei, triunfante em grande glória
Fu sei que Jesus ressuscitou
Eu sei que me garantiu vitória
E tudo sofreu só por amor

Eu sei, nunca mais terei tristeza

Eu sei, nunca mais irei pecar

Eu sei, com os anjos, com certeza
Num grande coral irei cantar

Eu sei, lá verei o que partiram

Eu sei que vou conhecer Jesus

Eu sei, com os crentes mais antigos
Habitarei ali no céu de luz.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'7c39ba59-a227-5bdb-ac0d-cf0803034019', 141, 70, 70) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4933899b-3ba0-584a-9393-26d98c7d8b50', E'ADORAMOS-TE SENHOR', E'Deus está presente aqui conosco
Sua presença enche este lugar
Vou abrir meu coração
You pedir com devoção
“Estás aqui e eu vim pra te adorar
ainda que eu não possa vê-lo
pada Posso a ti comparar
“pirito de Deus,
no à terra, que enche os céus
S aqui e eu quero te adorar

Senhor, € rendemos-te louvor
verdade, por tua santidade

de amor.

Te adoramos,
Em espírito em
E por teu tão gran') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4933899b-3ba0-584a-9393-26d98c7d8b50', 142, 70, 71) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'7a61a801-979c-5300-acb0-bece38d306cd', E'O AMOR DE DEUS', E'Jesus ensinou o amor e em tudo Ele pe
Amai-vos uns a0s outros, perdoai-vos tam ém
Armai Os que vos amam e quem amor não tem

O amor é tudo que quero pra mim
Amar, quero amar com amor sem fim

143

Quero amar os amigos, quero amar os irmãos
Quero amar os perdidos, quero estender-lhes a mão
Quero dizer que eu amo, quero viver o amor

Eu sou feliz porque amo, tenho o amor do Senhor.

A Bíblia nos fala do amor e da excelência de amar
Quem ama perdoa, não deseja mal

Quem ama espera a hora final

O amor é tudo que quero pra mim

Amar, quero amar com amor sem fim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'7a61a801-979c-5300-acb0-bece38d306cd', 143, 71, 71) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'7c268acb-c680-57cc-86b4-de6dd6bdd892', E'BRILHO DE DEUS', E'Quero parecer com meu Jesus

Quero parecer com Deus

Quero O meu ser do Espírito encher

E em mim o brilho dele aparecer

Quero transmitir à luz

A beleza dele em mim

e Es faz feliz, Que me faz cantar
O belo quanto Ele ser

Espírito, quero brilhar
Espírito, me faz luzir
Que outros Possam ver
Ei mim fesplandecer
brilho do Espírito de Deus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'7c268acb-c680-57cc-86b4-de6dd6bdd892', 144, 71, 71) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'490e04e6-578d-5636-ab16-a9e3498b5d82', E'PERDOA-ME', E'á
peu não quero ficar pecando

sonho” eu não posso ficar assim

Ear se estou atrapalhando

aê quiseres, Senhor, faça em mim

ado a-me, perdoa-me
Pp OU errado, mas estou arrependido
perdoa-me

Eu renho errado, mas estou arrependido') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'490e04e6-578d-5636-ab16-a9e3498b5d82', 145, 72, 72) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'888421a0-abb9-5725-9eca-40f6e650ed69', E'PRA TE SERVIR', E'«sus, minhºalma anseia de ti mais perto estar

a quero sentir a tua presença

Pois creio que aqui presente em glória tu estás
Vem visitar e alegrar meu coração

Senhor, eu quero andar na tua presença
Meu coração aberto está pra te ouvir

Contigo eu quero andar, és minha esperança
Por que eu sei que só contigo serei feliz.

A minha juventude eu quero dedicar

Pra te servir com toda força

Eu quero a minha vida inteiramente dedicar

Eu quero ser nas tuas mãos um vaso de benção.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'888421a0-abb9-5725-9eca-40f6e650ed69', 146, 72, 72) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'52954228-eb33-512f-a98e-219df45a09fc', E'EMJESUS ENCONTREI PAZ', E'Em Jesus encontrei paz pra o meu coração
a paz) — bis
e Je? à graça e alegria eficaz
Ta prged sim, de ti quero mais
T nça me faz entender
Ê E a eu vou receber
Cm “SeJO, Jesus, de te ver
28, vou contigo viver

i i terminar

Í Í ui breve vai
Minha vida ag ar
Vou (com Jesus). Vou (desca se Eai
Gozarei as delícias do céu y
As riquezas que me ja .
Entre os anjos € os queru a
As maravilhas do céu são pr e
Mas, entre tudo o que mais quero
Meu Jesus, sua glória € poder.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'52954228-eb33-512f-a98e-219df45a09fc', 147, 72, 73) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'24791fe3-bb0c-5fd5-b2cd-452b4e75a05e', E'CONSELHO', E'Quando as tristezas € lutas me sobrevém
Dobro os joelhos e faço uma oração
E logo a resposta e o consolo que peço vem

Dobro os joelhos e oro em gratidão o .
Se você neste momento sofre angústia no teu coração.
Talvez penses até que a morte é tua sorte, será tua salvação.

Não deixes que o inimigo te vença. |
Entregue a Deus tua vida e terás vitória então garantida.

Se sofro injúrias na vida e difamação
Dobro os joelhos e faço uma oração
E sinto de Deus a presença no meu coração
Dobro os joelhos e oro em gratidão.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'24791fe3-bb0c-5fd5-b2cd-452b4e75a05e', 148, 73, 73) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'81bb25eb-1afe-5445-a39c-cccecea2f463', E'SENHOR É REI', E'Os anjos te adoram, Senhor
Te honram, te prestam louvor
São teus enviados que vão
Ao lado de quem teme à ti
Minha alma também vem louvar
Honrar e servir neste altar
Porque confiando estou

sempre serei vencedor

O Senhor é ret, Ele é meu Deus
Rocha em quem me firmarei
2 Vitória receberei
E a minha vida e o que Ele me deu
2 Sua vontade aplicarei
eternamente confiarei,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'81bb25eb-1afe-5445-a39c-cccecea2f463', 149, 73, 73) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'650ad99a-0874-5c3a-a72f-1428337c52b1', E'A LUZ DE DEUS', E'ver à luz de Deus em mim brilhar
a sua glória sobre mim

Pi neste mundo vil a luz de Deus resplandec

a Suá lória em mim transparecer ne
quero iluminar os que vão na escuridão
foz prá que está sem direção

JetO receber em mim o brilho que vem do Senhor
tera luz que leva ao Salvador

us presente está neste lugar
gua gló ria € poder e a virtude do Senhor
A sua presença invade o meu ser
F eu sinto me envolver, aleluia e glória dou
O meu coração aberto está pra Deus
Fa unção que Ele me deu faz a minha luz brilhar
Quero a luz de Deus resplandecer
E que todos possam ver sua glória sobre mim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'650ad99a-0874-5c3a-a72f-1428337c52b1', 150, 74, 74) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'7fcd4692-4006-51e7-8287-ccef04f9d148', E'ENTREGA-TE A DEUS', E'Ó Cristo, vieste ao mundo

Por mim tu morreste na cruz
Me amaste com amor profundo
Por isso te amo, Jesus.

No céu tua gloria deixaste

Por mim tu vieste sofrer

Sofreste tanto pra salvar-me
Atieu entrego o meu ser.

Venha agora, entrega-te a Deus
Viva feliz os dias teus

Ele te chama é Ele quem diz:
Vinde após mim e serás feliz.

Se queres ter a alma pura
Ena de paz e de luz
na os problemas a Cristo
a 8a tua vida a Jesus
j di de Cristo há pureza
io a de Cristo há poder
bo “te hoje a Ele
8a à Jesus o teu ser') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'7fcd4692-4006-51e7-8287-ccef04f9d148', 151, 74, 74) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'1ac7688b-5a58-5cf9-a245-6feebc4ae13b', E'NADA TENHO, NADA sOU', E'Sei, Senhor, que não mereço
Nada tenho, nada sou

Sei, Senhor, sem ti pereço
Me sustenta teu amor

Não resisto O desejo

Me ofereço à fi Senhor
Suplicando dos meus erros
Teu perdão, 6 Salvador

Sobre mim repousa à honra

Escolhido fui por ti
Nesta obra pura € S2
Santidade queres de mim
Mas, sou homem imperfeito
Imperfeito é o meu louvor
O que tenho té ofereço
Quero-te servir, Senhor

nta

Sinto em mim tua presença
Nos meus olhos vão brotar
Lágrimas de esperança

Um desejo salutar

És a fonte inesgotável

O manancial de amor

Sou apenas uma ponte
Desta fonte, ó Salvador (3x)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'1ac7688b-5a58-5cf9-a245-6feebc4ae13b', 152, 75, 75) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'01cd67b3-93e6-5c43-a162-e0008ee8c2bb', E'DESPEDIDA', E'RA, o momento chegou
m Ed es
ia que nós já saudosos vamos nos despedir
o meu peito gravado ficou
s momentos em |
que juntos passa
EO meio alegria e dor presos do
m
a à meu rosto rolam lágrimas de amor
a o em mente gravado
S momentos que juntos o Senh ist
enhor nos visitou

” do Senhor, vaí

aj na p2Z s Var na paz de J,
p gÍ não nos vermos mais esus
Nos veremos no céu de luz

sando, irmão, pra Cristo Jogo vol
então, ij tar
» 1EMOS pra Sempre fi
car,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'01cd67b3-93e6-5c43-a162-e0008ee8c2bb', 153, 75, 76) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'8eb4899e-74d2-581c-ad26-390034cb9d22', E'O NOME DO SENHOR', E'srosê Deus a cada instante minha vi
ui ropósito é de obedecer

EDS santos mandamentos, tuas leis obsery

E cumpri-las sei que é o meu dever “

Quero, ó Deus, tua palavra aplicar em meu vivo
As doutrinas reveladas fielmente obedecer a

«me mais, a cada instante, santi :
Dá , ii » Santidade em meu viver
E que eu possa tão somente obedecer

Tu deixaste os mandamentos para a igreja observar
São ensinamentos para O cristão

O pecado e a vaidade não conseguem penetrar
Onde obediência há, santidade haverá.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'8eb4899e-74d2-581c-ad26-390034cb9d22', 154, 76, 76) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'1b04f409-a971-5d95-9a3d-4eab24ebefa8', E'NOME DO SENHOR', E'Senhor, teu nome é santo, mais devo devoção
Enxugas o meu pranto, consola o cotação

Tu és onipotente, meu guia, meu Senhor

Tu és minha alegria, de tudo és Senhor.

E sempre te louvando desejo até morrer

Ao mundo anunciando enquanto aqui viver
De tudo és bendito, divino Criador

Com gratidão e devoção eu sirvo à ti, Senhor.

À ti poder e glória desejo tributar
Or todas as vitórias desejo te honrar
Ués o meu tesouro, meu Cristo, meu

U és m; ai
és minha alegria, ó fonte de amor.

Senhor') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'1b04f409-a971-5d95-9a3d-4eab24ebefa8', 155, 76, 76) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'fee96cad-90e6-500e-965f-974fd650437f', E'OS ESCRIBAS E FARISEUS', E'Í ndo
Certa vez estava Jesus na areia je
E por certo o coração no peito palp

em silencio
e abaixado
a ul de homens o interrogava

s logo uma
e es mulher estava adulterando
E pela lei teremos que lhe apedrejar
HE ração estavam pensando

| ue no co
Mas bem sabia O q a
E disse: “quem não tem pecado pode começar”.

156

De que adianta o homem querer contender com Deus
Nenhum sábio desta terra o poderá vencer

Pois a sabedoria que um homem pode ter

É dom de Deus, que é maior e tem mais poder.

Os homens sábios não entendem a grande verdade
Confiam irrestritamente em seus conhecimentos
Evitam até com os humildes terem amizade
Pergunto: Quem deu ao homem o entendimento?
Não sabem que a sabedoria aqui da terra

Jamais poderá vencer um sevo de Deus.

Os homens sabem da ciência, coisas que não levam
Os crentes sabem do Espírito, que é dom Deus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'fee96cad-90e6-500e-965f-974fd650437f', 156, 77, 77) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'ef3adb98-de3a-522c-aaa0-cabc2e807039', E'QUEROSIM', E'Nesta Obra santa estou, o Senhor me convocou
Entre mil, entre milhares e milhões

Na palavra escrita está para a igreja observar

Os preceitos as doutrinas de valor.

Quero sim, quero sim

À sagrada escritura obedecer
Quero Sim, quero sim

Tua preciosa VOZ guiando-me

Pronto
est
Ou ao te querer, ao que ordenado for') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'ef3adb98-de3a-522c-aaa0-cabc2e807039', 157, 77, 77) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'961b9c62-33d7-5135-9dcf-25a9ee0798fc', E'IGREJA', E'a antiga dos tempos de outrora
ag sabe a tua história se move em
vu A templo pequeno, tão apertado,

cendo improvisado unia mais os irmãos
cada crente se via muita vontade

buscar à santidade de viver em Otação

Nadoê trumentista, no coral, na mocidade

Land via vaidade, no louvor havia unção.

Irmãos amados, o mesmo Deus está Presente

Não se pode estar contente se Ele não te visito

Você aínda permanece tão calado u

Com o coração fechado e não sente o Senhor

se humilha e chora, pede a Ele aqui e agora

Que à frieza vai embora e vem a glória do Senhor,

“Moção

Simplicidade, não vivia de aparência

No temor e na decência cultuava ao Senhor

Mãos calejadas e no corpo outras marcas

De quem com rigor trabalha sem tristeza, sem rancor
O traje simples, longe da modernidade

Conservava a humildade e a igualdade entre os irmãos
Em cada culto Deus mostrava-se presente

Eram crentes diferentes. Crentes de consagração.

Sobre o conceito do tal: “nada tem a ver”
“Isso é coisa do passado”, “Deus só quer O coração”
O mundanismo e a terrível apostasia

Tem tornado igrejas frias, sem calor e sem unção.
Na vaidade Deus não se mostra presente
O povo sofre e a igreja sente, está faltando o prin
Falar, cantar, tocar bonito não resolve º
Mio oferta que não sobe, se não sai do coração.

cipal') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'961b9c62-33d7-5135-9dcf-25a9ee0798fc', 158, 78, 78) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'26f6b54b-f641-5c88-a5a2-749fdd241980', E'CRISTO É REALIDADE', E'ai tealidade, Ele vive em mim
ema mo o mundo inteiro
Mor sem fim
o ao mundo vil |
* Morreu por mim, pot ti

ao céu subiu
Clio nome sem igual
Verdadeiro imort
Cristo, Salvador real
cristo, bom mestre
Meu Pai celestial. |') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'26f6b54b-f641-5c88-a5a2-749fdd241980', 159, 78, 79) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'a10184ab-7aae-5983-acac-b3fa9062bdde', E'Ó ESPÍRITO DE D', E'é onsolador
Ó Espírito de Deus, tu és 0 €
odaaend que de ti depende vem clamar

Ó Espírito, que esperamos, ensinados
Nos reveste, nos ensina mais nosso eus louvar

Ó Espírito, que NOS entende pot teu favor,
Nos desperta para esse mundo anunciar

A unção divina nos concede pot teu amor.
Espírito de paz, que nos

EUS
160

satisfaz, vem sobre nós.

Ó Espírito de Deus, que nos faz vencer o mal
Fortalece nossa fé e nos faz mais fiéis a Deus

Ó Espírito, nos entregamos ao teu querer
Nossas vidas sim precisam mais de te conhecer
Ó Espírito, que nos conhece e nos pode bem
Cada dia encher de fé e amor nossos corações,
Nos unir, ungir, usar com glória e muito poder.
Espírito de paz, que nos satisfaz, vem sobre nós.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'a10184ab-7aae-5983-acac-b3fa9062bdde', 160, 79, 79) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'8365ecbe-adab-5ff9-90c3-b606888f4c39', E'CRISTO É O AMIGO', E'Você tem amigos importantes, você vive sem se preocupar
Você tem dinheiro num instante, vai aonde você desejar
tem amigos tantos que te cercam e parece que vai tudo bem
ua vida é viver o mundo e gastar o tempo no que o mundo tem.

Olha, m )
prima ; E amigo, deste mundo salvo estou
osso amigo, o nosso Redentor.

Nossa vida é tã
a é tão dif
Conhecidos somos ERES tempo é para O Senhor
Temos paz e temos alega os crentes”. Aleluia, Ele nos salvou
pd egria ; ,
Nos visita de noite e d ria, nosso amigo, Ele é fiel
e dia e com muita alegria nos conduz 40 céu.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'8365ecbe-adab-5ff9-90c3-b606888f4c39', 161, 79, 79) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9e029165-3af9-539f-b5e1-0ca842fa7dc9', E'CRISTO TE AMA', E'|

| 62

| » pode até não concordar, meu amigo
|

l

ia e achar que isso não é real

o jo ver razão nas coisas que digo
E forma de viver tem outro ideal
= entendo e não concordo contig
Não desisto e vou pedir a Deus por você
pois não há quem se entregue a Jesus Cristo
g que não consiga achar razão pra viver.

oh! Eu seí que Jesus Cristo te ama
esus te chama e quer te salvar

Ele é amigo, à fonte de vida

Alegria e inspiração do nosso cantar,

Você pode agora concordar, meu amigo
Perceber que o amor de Deus é real

Aceitar pela razão as coisas que digo

E sua forma de viver ter outro ideal

A felicidade e paz terás, meu amigo

Vou continuar pedindo a Deus por você

E então verás que quem se entrega a Cristo
Encontrou a paz e a razão pra viver.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9e029165-3af9-539f-b5e1-0ca842fa7dc9', 162, 80, 80) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'7dc25ad8-4cae-511a-81b4-5dcf17703d5b', E'AQUI ESTOU JESUS', E'Aqui estou, Jesus, pra te adorar
Louvar-te com meu coração
Por tudo que tenho, por tudo que sou
Senhor, devo a ti a gratidão
nbora tão fraco e tão pecador
“ Que não mereço o teu grande amor
“tem quando olho e vejo a cruz
à0 há outro amigo melhor que Jesus
anto mais te louvo mais quero louvar
alma te ama, Senhor
Presença me vem confortar
9 em mim o teu amor
Em ia deseja contigo estar
eterna contigo morar
Serão, pe vida, o meu coração
à tua glória e adoração.

E sim

O, amigo

petermeim a e aterrar a DE er = a
EDER sr artrose ro ge e e PENN O ERP SA ER RESTAR RSA AQ DIRETAS ISSIEDTSNE TST

Re peer nm

rei ira is

ria ia isa

rd Di ap a 0 pç

AA e a ra sp gp e
bom page ig

DN VENIDT RARO O DGE UE

Ca

APL A a

RECTA ET RR

SDL nt

4') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'7dc25ad8-4cae-511a-81b4-5dcf17703d5b', 163, 80, 81) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd800b447-b356-5d7b-8491-23ca775c6945', E'SOU FELIZ, COM ELE SOU', E'buscava um abrigo

. =
Andei perdido, | A
Sob trevas andei na escurid

Aflito andava minh''alma tão cansada
. Ed

Jesus à mim me recebeu
Jesus minh''alma reviveu
E minha vida Ele transformou

Sou feliz com Ele sou

Vivi sozinho, buscava um amigo
Que pudesse estender-me a mao
Cansado estava, encontrei Jesus na estrada

Que ergueu-me e deu-me à salvação.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd800b447-b356-5d7b-8491-23ca775c6945', 164, 81, 81) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'377fbc05-bb88-5221-9665-1b4a7a50b23e', E'NÃO SOFRA MAIS', E'Porque sofrer, porque chorar, porque tanta tristeza?
Porque deixar que o teu viver não tenha alegria?

Porque pensar que é o fim vida
Se Deus está querendo mostrar uma saída?

Entrega tua vída a Deus, nele confia

Só Ele sabe o que você precisa

Quando a Cristo aceitei, que maravilha!

Tudo mudou, Jesus transformou a minha vida.

Não sofras mais, não chores mais, hoje é teu dia
Deus vaí tirar, te libertar de toda agonia

Te salvará e te dará verdadeira alegria

Feliz serás, teu nome terás no livro da vida.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'377fbc05-bb88-5221-9665-1b4a7a50b23e', 165, 81, 81) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e69acc63-25d0-53c0-873b-cd17df10301a', E'MAIS PERTO DE CRISTO', E'Mais pe j i
Seg no de Cristo, mais perto quero estar
Mes caminho, mais perto de Cristo
E Pi eU quero estar
om Ele nã tri
Não temerei tristezas e o mundo mal

Com Cri
Sto prossi
Prossigo, seguro caminho até ao final.

cof
gnt
18

isto eu certo chegarei
je tivo (a glória de Deus)
Ao? em Cristo, vencendo O perigo, vitó
Se va cilarei eu set, confiando
náo

na de glória na minha vitória e
cor

u Teceberei,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e69acc63-25d0-53c0-873b-cd17df10301a', 166, 81, 82) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'c60c487b-4ba6-5894-a033-5dcc383abf02', E'COMO AGRADECER A DEUS', E'mo agradecer a Deus pelo que tem feito a mim?
e vou retribuir O que vai dentro de mim>
E mil, entre milhões me honraste como sou

x snsformando meu viver, renovando meu amor

sou de Jesus, nada no mundo pode me separar
E com Ele vou no caminho do céu,

Sei que é o meu dever ser fiel ao grande Rei
Demonstrar o meu amor, ser fiel a sua lei
Recebê-lo como pai, como filho lhe servir

E hontar o seu amor dando tudo que há em mim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'c60c487b-4ba6-5894-a033-5dcc383abf02', 167, 82, 82) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd50beb46-bc3a-578c-8fd6-439c17694d63', E'O MEU TESOURO', E'Achei um tesouro de infinito valor
Mais precioso que o ouro

Nada se compara ao Senhor

Elk me fez ser herdeiro

Ele me fez seu companheiro

Nem as riquezas do mundo aqui
Nada é maior, sou mais feliz.

Dele é meu desejo, quero servi-lo melhor
Com Coração sincero
Inha vitória é maior
ha alegria é ouvi-lo
“, Ele sabe o que é bom
“é Meu maior amigo
“na no meu coração.

ria terei
em Cris to

NA

E = e;
RIEREENESD TETO TN

RASA STORES

&.
[rt
r
f
A
Ê
Fr
[á
É
E
b
É
fg
TM
5
Z
z
[A
%
É
Wa
H
g
í
LA
E
E
be

esmas me

e

e Vs') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd50beb46-bc3a-578c-8fd6-439c17694d63', 168, 82, 83) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'5ca9c5e0-8956-59dc-8c21-e663523c3388', E'TUA VONTADE', E'E | Seja feito teu querer, tua vota ; p
-Ê s eu quero se |
so O que tu quere À
É Sou um vaso para ser um instrumento =”
E Um passaporte do teu querer.
A! 7)
Ro pó
: Faça em mim tua vontade (oo!
É Seja o dono do meu coração Os sé
É Que eu esteja prepar. ado o
E Para a tua decisão
Minha vida te pertence b
Quero para ti viver fo
| E fazer tua vontade | é

É o desejo do meu ser.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'5ca9c5e0-8956-59dc-8c21-e663523c3388', 169, 83, 83) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'c5472f12-6a90-5bcf-8ea6-37ee2aa30ab6', E'MANSÃO CELESTIAL', E'| Breve eu deixarei este mundo

As tristezas são muitas aqui

Lá no céu não há dor nem gemidos |
Oh sim, eu desejo as delicias dali. |

Que prazer! Me aguardam os profetas de Deus
Meus irmãos que lutaram e descansam, eu sei
Conhecer os segredos das mansões celestiais

Onde as ruas são de ouros e os muros são de cristais

Sem contar que verei meus queridos
Não teremos mais separação

| Saudarei os cristãos mais antigos

| Oh! Sim, é o desejo do meu coração.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'c5472f12-6a90-5bcf-8ea6-37ee2aa30ab6', 170, 83, 83) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9f0abb89-967e-5bf7-825e-3101299701ba', E'SER MELHOR', E'Vem Senhor, a minha fé está em ti, vem sustentar-me
Vem Senhor, eu fraco SOU, SÓ posso crer no teu amor
Que me sustém e me mantém, Senhor,

Eu bem queria ser melhor
| Ser mais fiel, em tudo um só
F h
az em mim o teu querer, Senhor

aghos, vem me guardar do mundo
0
O. Gem
Ss

« ent') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9f0abb89-967e-5bf7-825e-3101299701ba', 171, 83, 84) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'0d38f0c8-7de7-547b-ae2d-68b9f41601a8', E'ESTAR PERTO JÁ VEM', E'im alegre vou, Senhor,

Po.

erto já Vil, meu Jesus vai voltar
a] erusalém, lá está o meu lar

vou E dos de Deus todos se unirão

Ea ú um, Sim, virão, com Jesus reinarão,

pstá P

pot ambém vou subir, a Jesus me entre

dou em busca do meu galardão

Eua glória com Deus eu então viverei
inca mais, nunca mais sofrerei

dn al) Eu reinarei.

Quero ver à Sião, contemplar seu fulgor

Ver também Abraão, a Davi, o pastor

Ver os queridos meus e as mãos de Jesus

Ver o trono de Deus e o esplendor da sua luz,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'0d38f0c8-7de7-547b-ae2d-68b9f41601a8', 172, 84, 84) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'dec3dc00-fd3f-5161-a775-c3b41e6478db', E'DEUS CUIDA DE MIM', E'Deus cuida sempre de mim
Não temo mais nem a morte
Ele venceu lá na cruz

Cristo selou minha sorte

Sou vencedor com Jesus
Minha vitória é certa

Vou dedicar meu viver

Minha coroa é linda

Que no céu vou receber.

Deus cuida sempre de mim
Jovem serei para Cristo
ta Deus quero sempre viver
Om Ele ter compromisso
“onto a Ele ouvir
“um exemplo de vida
no apareça em mim
nt o ado de Cristo
a sempre de mim (bis)

m
ot, que vou vencer se confiar € Quer tra
no teu pod Bar
er

guei

RSA

a STS') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'dec3dc00-fd3f-5161-a775-c3b41e6478db', 173, 84, 84) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'a256a49b-0cb1-5fc5-aca6-fbf38fd03c2f', E'ONDE ESTARÁS?', E'Onde estarás NO dia em que
teu viver?

Findar à aqui O es
Onde estarás? Onde estarás”
É certo que um dia enfim
Teremos que partif daqui

Onde estarás, onde estarás?

só um caminho é real

Só um caminho leva ao céu

Ninguém sozinho poderá chegar à Deus
Por mim, também foi por você

Na cruz Jesus veio morrer

Onde estarás? Onde estarás?

E se agora acontecer Jesus nas nuvens aparecer?

Onde estarás? Onde estarás?

Porem se cedo ou tarde vem, ninguém jamais se esconderá
Onde estarás? Onde estarás?

Que seja tua decisão viver 20 lado de Jesus

Feliz serás, feliz serás

No dia em que Jesus voltar, no juízo Deus te absolverá
Tu saberás onde estarás.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'a256a49b-0cb1-5fc5-aca6-fbf38fd03c2f', 174, 85, 85) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b2d32ee9-04bb-5b8b-9313-361c687238fd', E'SEM LIMITES', E'Todos, gra
dor ndes e pequenos, reinos, reis, todas as nações
ps od pg aquele que formou a criação
eu domínio são imi
[A $ â
Ele É Deus Ele é Senhor d em limites, não tem fim
os anjos e querubins

Toda glória e mai
. ajestade, santi .
Seu domínio não se mede, é pd igual

Tudo xi b u
ue /
nd existe é belo, criação das mãos de D
N vida, tudo nosso Deus nos concedeu “E
eu.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b2d32ee9-04bb-5b8b-9313-361c687238fd', 175, 85, 85) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'7621e2af-74a5-5dfa-b24e-d9ce7c79bf95', E'AINDA MAIS EU TE LOUVAREI', E'«s te louvarei, Senhor
da is desejo te servir

ais fiel serei
poda is me esforçarei

inda + melhor à ti, meu Rei,

varei (eu te louvarei)
e ontafei (eu te honrarei)
feh direi (eu te bendirei)

hem
fe so é O teu nome

aa vontade é O teu querer

A da mais eu te louvarei

gute Jouvarei (final)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'7621e2af-74a5-5dfa-b24e-d9ce7c79bf95', 176, 86, 86) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'2d4dd693-fa02-5a1b-820f-ce108a42841d', E'LUTAREI POR ESSE AMOR', E'Fu sei, me escolheste e tenho que aceitar

Não posso entender porque fizeste assim
Melhor não poderia assim imaginar

Que escolhesse a mim, que me pudesse amar
Eu não seria alguém, não posso duvidar

Sem esse amor de Deus feliz ninguém será
Com esse amor real eu viverei feliz

Pois tu amaste a mim com esse amor sem fim.

Lutarei por esse amor

Que com medida sem igual
Me faz feliz, me faz viver

Me faz sentir real prazer

Oh! Como eu sou feliz

Com esse amor eu viverei.

Emesmo sem saber porque escolheste à mim
“ Quero assim dizer-te O quanto eu sou feliz
ed seus prazeres, riquezas € ninguém

“Ha amar com esse amot alguém

à gratidão, dedico no louvor

ess Coração declaro a ti Senhor

0 You lutar, tentar corresponder
º Só a ti enquanto aqui viver.

De tod') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'2d4dd693-fa02-5a1b-820f-ce108a42841d', 177, 86, 86) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9f9360c9-8d2d-578b-be5e-c7b9e07a9b81', E'DEUS AINDA FALA', E'oo ''4 tem maturidade, já conhece a verdade

Você é jovem € 4 nhor. Muito cuidado com a tal da vaidade

Ea vontade do Sreniê “somos o amor”. Não se iluda,

E a sensualida da ente, o futuro e O presente e quer fazer VOCÊ fe
Deus conhece toda g cê for malsucedido não querendo o esc olhido ”
Mas, se lá na frente você f 0,
Foi porque você quem quis.

178

E Deus ainda fala e também revela,

Dá a coordenada pata a escolha cette , ,
Ele sabe tudo, ninguém sabe nada, Ele É O professor,
,

E quem tem juízo faz o que Ele manda, ,
Não se entristece, canta e não reclama, ora e agradece

E Deus do céu reveste o coração de amor.

O homem é barro, foi criado e formado e com vida animado
Obra-prima do Senhor. E disso esquece que é pó e se envaidece
E assim não reconhece que Deus é seu criador.

O entendido que se dá por avisado,
Se afasta do pecado e da mentira tem pavor
Na sua vida Deus está sempre presente, honra a Deus, não mente

É crente, é servo e Deus é o Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9f9360c9-8d2d-578b-be5e-c7b9e07a9b81', 178, 87, 87) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f0e00da7-e35e-5aa5-87aa-4e18281aca29', E'ME ENVOLVA SENHOR', E'Sonda o meu coração e me vê, ó Senhor
Só consintas em mim o que é honra e louvor
Eis a minha ambição, meu desejo maior
Pois encontro em ti o que há de melhor.

Vem visitar meu coração

Eu quero contigo sempre ter comunhão
Sou como pó, como nada bem sei

Me envolva, Senhor, em tuas mãos

Sonda O meu coração e me vê, ó Senhor
Só consintas em mim tua Braça e favor
Como pequeno barco na fúria do mar
Eu sozinho sem ti não irei triunfar') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f0e00da7-e35e-5aa5-87aa-4e18281aca29', 179, 87, 87) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'a6eb81c5-e49c-5af5-8c4e-7c04cf86a29e', E'A CRISTO ENTREGUEI O MEU CORAÇÃO', E'csisto entreguei o meu coração
bém à direção do meu viver
Eri há Deus tão bom e grande
eroso, forte e glorioso

n0SSO, NOSSO redentor.
g nele posso e sempre confiarei

e mim o bem e à paz se apegará
g nada para mim será melhor
E Cristo esta coiniga
Meu melhor amigo Salvador.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'a6eb81c5-e49c-5af5-8c4e-7c04cf86a29e', 180, 88, 88) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'da9ef75a-fef4-56b6-a0dc-66da8e55b0e0', E'REI DOS REIS', E'Ainda que as estações não firmem-se

Todavia eu me alegrarei no Senhor

Do seu amor eu falarei, do juízo

Da retidão e justiça de Deus. Bis
Ainda que o Sol não brilhe em seu fulgor

E o mundo inteiro não conheça teu amor

Meu coração, a minha fé e o meu louvor

Serão pra ti meu Deus, Senhor, Rei dos reis.

Serão pra ti, meu Senhor, Rei dos reis

Será pra 8 o meu louvor, Rei dos reis.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'da9ef75a-fef4-56b6-a0dc-66da8e55b0e0', 181, 88, 88) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'846b8dfc-1ccb-57f8-822a-cc87f5e4bc55', E'CRISTO MINHA SALVAÇÃO', E'dy “erei a Cristo e assim insisto
ai Cantando seu amor
to é o imenso, nele sempre penso

Efe eu eterno Salvador.

Nes, Seb Sempre O seguirei

Ele estão Ta Peregrinação

E seguro ISOs nunca estou sozinho
estou em suas mãos.

Cantarei alegre, nada mais me impede

Minha vida Cristo resgatou |
Vou dizer ao mundo esse é meu assunto:
Jesus Cristo salva O pecador

E ainda sei, mais feliz serei

Quando Jesus Cristo me buscar

Vou subir com Ele e ao céu 1ré1

Para sempre com Ele reinar.

Jesus Cristo é minha salvação o

O maior tesouro que encontrei
Alegria tenho e satisfação

Porque tenho paz no coração
Sempre quero, sim, tê-lo junto a mim
E amá-lo com dedicação

Cada dia mais desfrutar a paz

Jesus Cristo está e comigo vai (bis)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'846b8dfc-1ccb-57f8-822a-cc87f5e4bc55', 182, 88, 89) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'ab938cc8-7b45-5e03-bbca-cd562e309669', E'SOMOS HERÓIS', E'Somos heróis, vamos lutar e o inimigo um a um derrotar
Para vencer nós iremos lutar, vamos vencer, nós vamos ganhar
E com decisão e fé no Senhor nossa vitória Ele já decretou

Somos heróis e campeões de Jeová.

Somos heróis do tempo do fim
Somos de Deus o seu belo jardim
Somos heróis do amor e da paz
Somos heróis e a Cristo leais

Pra combater contra a força do mal
Somos heróis pra vencer afinal
Nessa batalha alçamos a voz
Somos heróis, nós somos heróis.

Se O inimigo se levantar para os heróis tentar afrontar

Ele verá que entrou pra perder, contra os heróis ninguém poder vence!
O general é o nosso Senhor, nunca perdeu, sempre é vencedor

Entra na guerra e luta por nós, somos heróis.

,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'ab938cc8-7b45-5e03-bbca-cd562e309669', 183, 89, 90) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'24815bf4-e309-515e-b568-a0ea58490999', E'AMOS TE BUSCAR SENHOR', E'f
Senhor, vam
os té buscar, , Os nos Un; .
e uma só fé, em um só amor, todos dum d
amos adorar teu nome sem cessar em ora O Coração
Ne sas vidas dar para receber teu poder O
, Ação,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'24815bf4-e309-515e-b568-a0ea58490999', 184, 90, 90) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'58d272a3-9890-50a3-812d-533b86b27166', E'VITÓRIA CERTA', E'Q inimigo furioso se levanta com astúcia para igre;

Na verdade, não suporta ver OS Crentes que não deixado
É preciso sempre andar em Vigilância, ele quer fazer al ar
Mas, se procurarmos ter a vida santa, Deus defende e vence,

Deus glorificar
OSsa voz

a guerra para nós.

Pode, pode atirar as pedras, difamar áin da
Planejar até tirar a nossa vida

Deus é nosso escudo, nosso forte guardião
Pode, pode levantar o mundo e acusar a igreja
Ela é invencível, ganha a peleja

Avitória Cristo dá em suas mãos.

Quando o crente ora e santifica a vida, o inimigo se levanta pra lutar
Revestido o crente parte para a luta na certeza da vitória alcançar

Nossa vida agora está nas mãos de Cristo e não temos que temer acusações
Jesus Cristo já venceu o inimigo, nós já somos verdadeiros campeões.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'58d272a3-9890-50a3-812d-533b86b27166', 185, 90, 90) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'2d33457e-8c2d-50df-ba2b-7e9ccba55b45', E'O CAMPO MISSIONÁRIO', E'ma a obra de missões,

alvação. .
do, isoladas estao

lização. (bis)

petmpo missionário clama, chama por quem a
So e Jesus Cristo enfrentar perigo e levar a
das que estão perecendo, longe estão vIv ou
* são vidas preciosas esperando as novas, à evang
?
pum Itá ao campo agora ao chamado atee io
» “Mpo missionário é cumprir na
e a de Jesus Cristo ama a evange
as lo; S Jouva e canta =
80 levanta pra fazer missões

Rondônia.

Esta ordem é de Cristo, é nosso compromisso anunciar Jesus

Ir ao campo missionário ou ao vizinho ao lado pra falar da cruz.
O tempo está se esgotando, o clamor soando por todas as nações.
Se levanta irmão agora pra fazer a obra, pra fazer missões. (bis)

(Goiás, 27/05/2003,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'2d33457e-8c2d-50df-ba2b-7e9ccba55b45', 186, 90, 91) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'38e5007e-4097-56ca-bdd2-8503a9424bf9', E'FELIZ ANIVERSÁRIO', E'Feliz aniversário pra você, que Deus te abençoe neste dia
Se os anjos dizem amém, a igreja diz também

Feliz aniversário pra você. |
Você é uma pessoa especial, que Deus te abençoe até o final

Presente és de Deus, pra igreja e para os teus
Feliz aniversário pra você.

Parabéns, parabéns,
Muitas felicidades, paz e alegria, parabéns.

Parabéns, parabéns,
Que as bênçãos e o amor de Deus perdurem em tua vida,

Parabéns.

Feliz aniversário pra você e que este elo forte de união,

Que hoje aqui nos traz, aumente ainda mais

Feliz aniversário pra você.

Que Deus conceda a tua oração e nunca falte a sua orientação
E em toda a tua vida a proteção divina,

Feliz aniversário pra você.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'38e5007e-4097-56ca-bdd2-8503a9424bf9', 187, 91, 91) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'bbda9382-0845-5e74-8fb6-36063b53b241', E'NO MEU CANTAR', E'No meu cantar, no meu agir
No meu falar, no meu sorrir
No meu orar, no meu vestir
No meu andar, no meu pedir.

No meu viver, no meu amar

No meu querer, no meu perdoar
No meu dever de repartir

Todo o meu ser, tudo só pra ti.

ominar, vem me ungir
Ve? e usar, vem sobre mim

vem + meu Deus, quero também
se pra ti para sempre. Amém,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'bbda9382-0845-5e74-8fb6-36063b53b241', 188, 91, 92) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f44f1c10-1aa8-5c20-9ba4-6c126cdae813', E'Ó ESPÍRITO DE DEUS', E'epírito de Deus,

e está dentro de mim

né conhece meu Viver, meu caminhar
sonda € vês meu coração
Me renova € faz sentir
A unção que vem de Deus me dominar
santifica meu falar
Meu cantar e meu vestir
0 que tenho unges para ti, Senhor
Muda todo o meu ser
Resplandeça sobre mim
Ó Espírito, preciso mais de ti.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f44f1c10-1aa8-5c20-9ba4-6c126cdae813', 189, 92, 92) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'da49a219-8e1f-5cbd-bcb4-192de82fb865', E'RESTAURAÇÃO DA IGREJA', E'Do Brasil se espalhando pra o mundo
O movimento de Restauração
Deus decreta e levanta a bandeira
“Jantidade, temor e oração”,
Pata a igreja o modelo da Bíblia
Para ter uma vida exemplar

eus promete fazer maravilhas

mM poder a igreja usar

Sempre avante, atento aos perigos
rg a Cristo leais |
Os na fé, invencíveis
“Mpeões pela causa da paz
'' '' ae a vida e bens passageiros
dador na missão ser fiel
Escolhido Distr companheiros
Os, eleitos de Deus

É

A verdade acima de tudo
as decisões

r base d |
Csrendendo a causa altaneira
O processo de Restauração
Destemida, ficl, submissa
Ao comando da voz do Senhor
A igreja verá maravilhas
A vitória da fé e do amor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'da49a219-8e1f-5cbd-bcb4-192de82fb865', 190, 92, 93) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e39671aa-da0c-51cc-9d83-7c83cc56ae6b', E'HAVERÁ, SIM HAVERÁ', E'Aleluia, não desisto porque creio € tenho visto

A alegria invadir meu coração
Quando penso e me dedico, trabalhar pra Jesus Cristo

Recompensa haverá, sim, galardão.

Haverá (haverá), haverá (haverá)
Regozijo e alegria havetá.
Haverá (haverá), haverá (haverá)
Aleluia para os salvos haverá.
(final) ...sim haverá

haverá... haverá.

Se o coração do crente estiver nos bens do mundo
Perderá de Deus a íntima comunhão
Mas quem crer nas suas promessas.

Confiando não se apressa
Pois recompensa haverá, sim galardão.

Para quem tem Jesus Cristo e com ele compromisso
O mundo, bens, tiquezas, nada lhe seduz

Não ajunta aqui na terra

O evangelho é o que interessa

Seu tesouro e riqueza é Jesus,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e39671aa-da0c-51cc-9d83-7c83cc56ae6b', 191, 93, 93) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'ae77d85f-3d64-52d6-9a53-2bc464b022a6', E'QUANDO ENCONTREI COM O SENHOR', E'Qu ando encontrei com o Senhor

E prá Ele abri meu coração
opheci de perto o seu amor
onheci também o seu perdão.
nha vida inteira transformou
felicidade renasceu

Encontrei a paz, salvo agora sou.

Cristo vive em mim, não eul

Feliz (Feliz eu sou, eu sou)

Feliz (Com meu Senhor, Senho r)
A vida (Eu encontrei, achei)

esus (Tu és meu Salvador)
Louvar (Louvar, louvá-lo-ei)

Pra Ele (A Ele louvarei)

Jesus (É meu amado Rei)

Tu és (meu Salvador).

Enquanto eu viver te louvarei Senhor.
Nos teus caminhos andarei. (Bis)

Quando encontrei com o Senhor
Ele estendeu-me sua mão.
Conheci de perto seu amor

E entreguei-lhe o meu coração.
E agora canto seu louvor

E honrá-lo vou no meu viver.

Ele me deu paz, me reconciliou
Cristo vive em mim, não eu.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'ae77d85f-3d64-52d6-9a53-2bc464b022a6', 192, 94, 94) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd8dff24e-42a3-5ab3-a072-b73b00023d9b', E'MINHA JUVENTUDE VOU DEDICAR', E'pia juventude vou dedicar, meus talentos VOM usar com amor

“a voz será pra mim como vento a soprar

frescor que alívia a dor

“Us desejos serão para teu louvor

ia queres para mim será

9 ovelha de um bom pastor
ii € guía com amor
le quer serei.

Que o mundo possa me conhecer
Como indicação de servo de Deus
Que o amor de Deus em mim
Outros possam amat também |

Sem medir, sem separar ninguem
Minha vida será para teu louvor
Vou buscar pra refletir Jesus

Que me amou sem mesmo merecer

Se entregou por mim até morrer
Como Ele, viverei.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd8dff24e-42a3-5ab3-a072-b73b00023d9b', 193, 94, 95) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f47e3b70-3005-5af7-be07-113c00043104', E'AINDA QUE EU TIVESSE TUDO AQUI', E'Ainda que eu tivesse tudo aqui

E entre os homens a fama fosse total
Sem Deus jamais seria alguém

Sem Ele, apenas um mortal

Mas Ele me tornou herdeiro do céu
Ainda que não tenha amigos leais

E o mundo inteiro vire as costas pra mim
Eu sinto o amor de Deus fluir

A minha alma alegrar

O que importa é que me sinto feliz.

Não há ninguém, ninguém igual
Bondade tem e amor total

E nele sempre confiarei

E toda glória, e honra, e louvores darei.

Ainda que eu não tenha tudo aqui

Mas tenho Jesus Cristo meu ideal

Eu seí que cuidará de mim

Me guardará de todo mal

Por isso é que eu me sinto feliz.

Viver com Cristo é sentir proteção

Ser livre, ser feliz e ter seu perdão
Sentir o amor de Deus em mim

A minha alma alegrar

O que importa é que eu me sinto feliz,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f47e3b70-3005-5af7-be07-113c00043104', 194, 95, 95) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'395df059-6a44-5d42-a3e8-0bae617d9499', E'O GRANDE AMOR DE MEU DEUS', E'1a vezes e pergunto; por que tem

do vejo tão distante outros sem
tas vezes vejo tantos Numa vida s
então pergunto pata ti:

porque que sou assim, Senhor?
então nesse dilema OUÇO tua voz de amor

sgilho, eu te escolhi porque te quero Vencedor

só eu tenho paz, felicidade € amor para te dar

7 demais meu filho eu morri numa Cruz pra te salvar”

UE ser assim;
Pensar no fi ''

m
EM temor

Grande amor de meu Deus.

Que sem merecer provou 0 quanto Ele amou a mim
E agora quero mais dedicar-lhe meu louvor
Compreendo que só Ele pode me fazer feliz.

Quantas vezes eu me lembro me deixei desanimar

Por olhar o mundo e as coisas que aqui irão ficar
Viaté que parecia ter uma vida sem razão

Vendo tantos neste mundo desfrutando em diversões.
Mas olhei para o passado quando aceitei Jesus

Quando me tirou das trevas e me conduziu à luz

E do fardo do pecado meu Jesus me libertou

Livre e salvo agora canto aleluias ao Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'395df059-6a44-5d42-a3e8-0bae617d9499', 195, 96, 96) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f28102ab-196b-56ce-8c2c-d5154d40e94a', E'QUANDO DEUS NÃO FALA', E'Quando Deus não fala o homem se corrompe
Não entende nada é tudo quer fazer
Como um viajante segue na estrada
Sem destino certo, anda sem saber
Quando Deus não fala o perigo é grande
Pecado entra e quer se esconder
“ando Deus não fala a frieza vem
“em discernimento o homem diz amém
locausto estranho quer oferecer.

E a Deus não fala algo não vaí bem
a O crente deve se humilhar também
o f ovo
Que” de Deus que guia o seu po nde valo

e
m despreza a voz Deus é um

Vaí andar sem rumo, não vai ser ninguém
Quando Deus não fala o homem quer fazer
Toma a frente e avança e a guerra vai perder

Juto
Deus é soberano, é abso
Sua voz pra igreja vale mais que tudo

Deus está falando agora pra você.

Quando Deus não fala o desvio é certo
Os problemas surgem e vem às decisões

Logo então se julga o que se acha certo
Quando Deus não fala surgem opiniões,
A igreja sente o homem dirigindo .
Ninguém se entende e vem a divisão
Quando Deus não fala é grande o perigo
Pode o homem ir e caminhar sozinho
Quando Deus não fala entra a confusão.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f28102ab-196b-56ce-8c2c-d5154d40e94a', 196, 96, 97) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'a3f36439-3b39-5d8d-b641-a1fbd03c4487', E'SE MEU CORAÇAO', E'Se meu coração encontra-se assim

Sem força me vejo perdendo enfim

O amor que me faz vencedor

À graça que vai sem poder segurar
Confesso parece que vou sucumbir
Não resisto mais e parece o fim
Socorro me vem, Deus me vem animar

Me faz levantar e o caminho seguir
Seguir pra vencer, novamente lutar
Mostrar pra valer que sou tão feliz

Se a vida parece que não tem valor

Às cores, o Sol não parecem brilhar

É o tempo vai e o sorriso não vem
Então vem diferente o toque de Deus
Novamente o amor e a fé restaurar
Sobre o meu coração, chama do Senhor
Eu posso cantar, novamente dizer
Ninguém vai tirar de mim esse amor
Jesus tu és meu, jamais vou negar

Que quero pra sempre contigo viver.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'a3f36439-3b39-5d8d-b641-a1fbd03c4487', 197, 97, 97) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'ba293124-8726-58b9-ba8e-610687c4f3a8', E'RESTAURA-NOS SENHOR', E'0 coração contrito buscarei
com a presença me apresentarei
br idade me virá
é “ado em tua casa adentrar
u
ç ajvação encontram Os que buscam em ti
pestaura-noss Senhor, nosso víver
Restaura-nos, Senhor, o caminhar
qua unção o teu poder
Tua glória sobre o nosso ser
pestaura-nos, Senhor, o teu querer
Restaura-nos, Senhor... Nosso Viver
Restaura-nos, Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'ba293124-8726-58b9-ba8e-610687c4f3a8', 198, 98, 98) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b91ad2e4-1e09-53a7-8f83-6c61ff5fa74c', E'A LUZ DE DEUS', E'Brilha a luz em ti que vem do nosso Deus

Brilha a luz que vem mostrar teu ser
Será que em ti a luz de Deus brilha como novo amanhecer?

Esta luz que resplandece um novo ser

Deixa a luz de Deus (brilhar)

Deixa a luz brilhar (em você)

Essa luz que brilha mais que o sol e tem poder
Essa luz que vem de Deus

Ilumina o meu ser

E Jesus a luz que vem de Deus...

Vem de Deus. (final)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b91ad2e4-1e09-53a7-8f83-6c61ff5fa74c', 199, 98, 98) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'5c6174b7-2712-5e47-a512-522ea2712c89', E'TUDO EM MIM MUDOU', E'Eu amo a Cristo, Jesus é meu

Quando aceitei Jesus tudo em mim mudou
minha vida, meu falar, meus pensamentos, enfim.
“muito bom pra mim, será ainda mais
* mãos de Cristo eu serei muito feliz.

Oh! Eu sei que Ele cuidará de mim
Dará a direção

Jamais me deixará

Oh! Eu sei com Ele eu serei feliz
Com Ele viverei e Ele em mim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'5c6174b7-2712-5e47-a512-522ea2712c89', 200, 98, 99) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'361c8148-0574-5461-8dd1-1e95c7a170a8', E'A GLÓRIA DE DEUS', E'Sei que pra mim será
E sem comparação
Santo lindo lugar
Minha bela mansão
Meu desejo é voar
Na cidade adentrar
Conhecer o meu Rei
E com Ele morar

Sei que vou ver meu Jesus
Contemplar o meu Deus

Ver a glória e a luz

Minha casa verei

E pra sempre ali

Nunca mais sofrerei

E pra sempre feliz eu então viverei.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'361c8148-0574-5461-8dd1-1e95c7a170a8', 201, 99, 99) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'57301e05-f137-51b5-935c-e24c9218c169', E'QUERO A UNÇÃO DE DEUS', E'Quero a unção de Deus a sua glória sobre mim
Quero a unção, a força, a fé que tinha o rei Davi
Quero sobre mim, quero sobre mim

Frutos quero dar e vidas quero transformar

O evangelho santo de Jesus anunciar

Quero seu poder, quero ser assim

Quero conduzir a cruz que leva à salvação
Resgatar das trevas de pecado corações

Retirar do mundo quem está na perdição

Eu quero sim, quero sim.

Tea

eso ter de Deus a comunhão Com me
yero erdoar, amar € ser um vencedor Senhor
O Sr assim, quero ser assim
cos quero dar e vidas quero transfor
asangelho santo de Jesus anunciar Mar
am poder, quero sobre mim
E minha vida o evangelho ANUNciar
ecado vidas que se perdem Tesgatar
dos pés de Cristo muitas almas apresentar
au quero sim, quero ser assim.

Quero') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'57301e05-f137-51b5-935c-e24c9218c169', 202, 99, 100) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'7e2fa30f-9a8b-5d4d-abcb-d52d83051774', E'O SENHOR, MEU DEUS', E'confiarei no Senhor, Ele é o meu Deus

Confiarei no Senhor, Ele é Rei dos Reis

sou vencedor no Senhor, sempre vitória terei
Confiarei no Senhor, Ele é o meu Deus

Rocha segura Ele é, me esconde e me livra do mal
Nada me pode deter sou vencedor afinal

Se o inimigo vier, forças do mal atacar

Luto e venço com fé Deus é meu general.

Venço, com Ele eu avanço, sempre vou pra vencer
Cristo venceu e na cruz demonstrou seu poder
Nada me pode parar, venço e vou avançar

Vou de vitória em vitória vencendo com Deus
Cristo comigo é fiel, sua vida e seu sangue verteu
Só por amor que viveu, como homem sofreu

Para vitória alcançar, o inimigo e o mal derrotar
Sou vencedor afinal porque vivo com Deus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'7e2fa30f-9a8b-5d4d-abcb-d52d83051774', 203, 100, 100) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'57b44d01-1bf4-5fa9-806a-3a44266c8f9b', E'ÓHSIM EU SEI', E'Ob! Sim eu sei (sei). Meu Jesus regressará
dia vem (vem), tudo aqui terá seu tim
M Jesus irei ao céu, nova vida viverei
vrioso, majestoso o dia vem .
+ tenho paz (paz) dentro do meu coração
diz cu Sou (sou), meu Jesus cuida de O enê
ra dispensá-lo-ei, meu tesouro € meu
“Jesus jamais eu deixarei.

|
a!
as |

Não importa quem não quer

Eu jamais irei negar |

Sei que um dia Ele vem e ninguém se esconderá
Eu confesso meu Jesus, só com Ele sou feliz

Pois Jesus cuída de mim. (bis)

u ser (ser) Jesus tem o seu lugar

A sua paz (paz) Ele derramou em mim

O que mais desejo ser € fiel e mais leal

Não trocá-lo pelo mundo e ninguém

Sua vida deu, o sangue derramou por mim

Sim, tudo Ele fez por amor pra me salvar

Como poderia assim negar? Minhas dores Ele carregou

Meus pecados, minha culpa perdoou.

No me') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'57b44d01-1bf4-5fa9-806a-3a44266c8f9b', 204, 100, 101) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'5d0b49d7-8982-5731-ba19-4db57a30c85a', E'DESEJO DE DEUS', E'Ah! Se o meu povo, a minha família, os meus irmãos
Por quem dei a vida com preço de sangue, a salvação
Pudesse mais compreender e em mim descansar
Obedecer e sem palavras avançar

Maiores maravilhas iriam contemplar.

O Pai conhece, no fundo, o desejo dos corações

E muito se alegra quando se espera sem murmutração
Eis que a vontade de Deus, que é fiel

É abrir os tesouros da glória no céu

E os seus segredos compartilhar com os seus.

“Igreja querida, por quem dei a vida,
Lutai com amor, terás recompensa,
Não há quem te vença, eu sou teu Senhor
Quando chegar o momento final
O céu te espera, o gozo eternal.
Viverás pra sempre diante do trono do Pai

(No Rio Madeira, no barco. / Manaus)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'5d0b49d7-8982-5731-ba19-4db57a30c85a', 205, 101, 101) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'c5fa7b1d-c016-5c30-85c5-e91f9c388e0c', E'COMO VAI JOVEM', E'Como vai jovem a tua vida?
Como vai jovem o teu viver?
Vives alegre ou vives triste?
Como vai jovem o teu viver?

N A omos jovens — somos alegr
pImOS razão — razão de ser és
egtia — QUE EU percebes
A Liísto em nosso viver,
9 VÍVEr — Meu viver
ão há razão — não há razão
pur 4 ser infeliz.
sto te chama, Ele te ama
em meu amigo, vem ser feliz
viver alegre, ter paz na vida
para à tristeza vem dar um fim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'c5fa7b1d-c016-5c30-85c5-e91f9c388e0c', 206, 101, 102) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'356bbb42-be7b-5c44-a822-645423ff6da1', E'O CRENTE CONSAGRADO', E'Esta é a história de um crente Consagrado
Que não vive nO pecado, nem com falta de tem
Obediente, na doutrina ele é zelóso .
Não se envolve com tolos, Mas, escuta o pastor
Não vive entrando e saindo da igreja
Ora é santo, ora é sujeira, ora é mundo, ora é cristão
Ele tem Bíblia, ele tem harpa e o cantor
Glorífica ao Senhor, ele abre o coraçã

ção.

E na igreja ele canta e glorifica

Ora, pede e participa com amor no coração
E do seu lado ninguém fica calado

Logo é contagiado porque ele tem unção
Ele é quente, animado e amoroso

Á sua face resplandece como a luz.

Aonde chega ele é bem recebido

Ele tem o brilho glorioso de Jesus

À tua vida também é uma história

E agora é a hora de escrevê-la num papel

Escreva tudo, analise e veja o saldo .

E Compare o resultado, vê se deu crente fiel:
hegou o tempo, acabou à brincadeira o
40 se pode estar na igreja sem temor no coraç

crente sério não chega atrasado ”
não vive envergonhado, ele é crente de oraç

Deus tem falado, o seu pri

E quem não tiver cuidado vai parar o

E ie ndo ão aceita correção
iver 1 ao mu

is é Humilde e sempre tem uma deseuipa

E sempre coloca culpa na igreja ou NO p

Mas o fiel com Jesus tem od jd .

Na igreja ele é querido e amado do Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'356bbb42-be7b-5c44-a822-645423ff6da1', 207, 102, 103) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9f7f153e-4769-5471-a529-6e22293a58a7', E'NAS CAMPINAS DO JORDÃO', E'Muitas foram as aflições, dores, lutas que passei

Tentações e até perseguições. dou
Foram fortes emoções, mas o mundo abandonei

Entreguei a Jesus meu coração.

Oh! Cantarei com os santos nas campínas do Jordão

Celebrando a vitória no Senhor |
Oh! Cantarei com os anjos novo cântico em Sião

Aleluia, sou vencedor.

Vou vivendo no Senhor com prazer no coração

Breve irei encontrar-me com Jesus
Lá então avistarei as planícies do Jordão

Aleluia, com os salvos viverei.

Novo canto entoarei, melodias de Sião

Glorioso, entre os anjos viverei
Jesus Cristo, nosso Rei, no seu trono estará

E com todos os salvos vou cantar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9f7f153e-4769-5471-a529-6e22293a58a7', 208, 103, 103) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'a668e87d-2929-5ffe-a804-cbae4cc53a21', E'JESUS NÃO MUDOU', E'Cristo operou grandes milagres

Curas fez que a muitos espantou
Morto ressurgiu já sepultado

Quantas maravilhas operou
Multidões seguiram seu caminho
Suas palavras tinham vida e luz
Transformou a água num bom vinho
Glorioso é o nome de Jesus.

7 aiscípulos deu autoridade oro

LA nome o mal repreender

a tem Cristo tem felicidade
Qu gre vê na vida acontecer

a é ainda o mesmo poderoso
Je ê ainda opera com poder

La q santo sangue glorioso |
A vitória dá a quem nele crer,

aior milagre continua
operando com grandes sinais
es tando vidas que são suas
transformando e dando sua paz
Aleluia, glórias ao Cordeiro
Que na cruz seu sangue derramou
Tenho mais valor que o mundo inteiro
Salvo pata sempre agora sou.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'a668e87d-2929-5ffe-a804-cbae4cc53a21', 209, 103, 104) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'6efacd45-2d2c-5a1c-8425-5097a13983db', E'MINHA GRATIDÃO', E'No amanhecer de um novo dia dobro meus joelhos em oração
Agradeço a Deus com alegria pelo sono e a paz no coração
Peço a Deus a proteção divina para a igreja e para meu país
O temor a Deus em cada vida, agradeço a Deus, pois sou feliz

Assim vaí passando a minha vida
Destftutando desta comunhão
Por vocês eu oro todo dia

Deus vos abençoe meus irmãos.

Vai chegando então ao meio-dia, meu trabalho faço com prazer
Agradeço a Deus com alegria pelo pão que agora vou po =
Peço a Deus que lembre dos aflitos, das ars etam ém

o É ê a tua paz.
Dá Senhor sustento, eu suplico, O Senhor, lhes P

pais

o o dia que passou
te mão me sustentou

asa vou Orar
pelo meu lar.

Vai à tarde e noite vem chegando, agradeç
!amão de Deus me abençoando, sua for
“tem culto vou para a igreja e se não em c us

agradeço a Le

Btadeço a Deus por minha vida,

aa TR') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'6efacd45-2d2c-5a1c-8425-5097a13983db', 210, 104, 104) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b72ddc35-d6a1-53e9-b46a-13dfb21e4665', E'OBRA ESTRANHA', E'bra de Deus é estranha
Es de realizar

Nenhum homem po
Deus exige que sejamos santos
O mundanismo não pode entrar
Todo crente que deseja o puro

Santidade, comunhão com Deus

Nesta obra tem lugar seguro
Quem deseja a Deus ser mais fiel.

Não importa se é novo ou velho
Se criança, jovem ou ancião

Esta Obra de Deus é estranha

É o processo de Restauração
Deus ensina como anda o crente
Diferente é nossa adoração
Vaidade e aparência humana
Deus proíbe, é Restauração!') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b72ddc35-d6a1-53e9-b46a-13dfb21e4665', 211, 105, 105) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'74e2d52e-05f1-57b5-b076-984781ac477a', E'FELIZ COM JESUS', E'No mundo andei em grandes perigos
Até encontrei quem fosse comigo
Seguia o mundo, ouvi seus conselhos
Perdi muito tempo, gastei meu dinheiro

Achei impossível voltar ao convívio:
Pensei: “eu não volto, não sou mais querido”

Mas hoje estou livre, voltei para casa
Deus me abençoou, a igreja orava.

Pois Ele é o Senhor, Ele está comigo
E por seu amor me sinto querido

E tudo mudou, eu tenho um amigo
Nos seus braços estou feliz, protegido.

Querido, o conselho que dou é de amigo
Não perca seu tempo no mundo perdido
Não seja covarde negando a Cristo

Você é ovelha vivendo em perigo
Mentira do mundo, a Igreja te ama

Até de joelhos por você ela clama

De braços abertos, sorrindo e cantando
Nossa alegria é vê-lo voltando,

RA

Rj') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'74e2d52e-05f1-57b5-b076-984781ac477a', 212, 105, 106) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'1018ebcb-a92c-56f8-a179-cd434ed5d100', E'NUPCIAL', E'/
nos fez algo especial
e ou e nos uniu o Senhor
Nos « mesmo que pudéssemos escolher
nt 7 nascer esse amor entre nós
a Ele à direção do meu viver
mim foi mais que especial
; escolha me fez ver
Melhor não poderia ser
Você me faz feliz assim

pei
pata

nero dar à Deus minha gratidão
pedi-lhe que escolhesse para mim

Realmente foi demais
Você pra mim é tudo e muito mais
Te amo e quero te fazer feliz

E nossa união, aliança no Senhor
Viveremos para sempre unidos pelo amor (bis).') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'1018ebcb-a92c-56f8-a179-cd434ed5d100', 213, 106, 106) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'6f9be3a9-9cf2-51fa-8c51-6754b0796c37', E'AQUI CHEGUEI', E'Eaqui cheguei (cheguei), Deus me abençoou
Toda honra e glória ao nome de Jesus

Me alegrei (me alegrei) Deus me visitou
Aleluia! A vitória foi na cruz.

Quando Deus me convocou eu abri meu coração

Minha vida entreguei ao meu Senhor

Ele é quem cuida de mim, me sustenta sua mão
O meu trabalho Ele prosperou.

Em qualquer situação ninguém deve duvidar
opera e faz milagres acontecer
“€ alegra o coração e tem prazer em aben
ele tecompensará você.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'6f9be3a9-9cf2-51fa-8c51-6754b0796c37', 214, 106, 106) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'5b9e4baa-b4bb-5ef3-a0f3-8ab426452a4b', E'VITÓRIA CERTA', E'çoar

pri Jesus dará a todos que nele crer.
Porto seguro irá e com Cristo Jesus viver
do findar aqui sua glória há de contemplar
le irá subir, com Ele irá reinar.

(Manaus, 14/ 09/2005).

O A

Pois é meu maior prazer estar a0s pés do Senhor
oi ) .
Ouvir sua voz dizer: eu tenho por ti amor.

É de Jesus
Iguém duvidar provar do amor c
Ed ao ainda mais amá-lo, das trevas raiou a luz. . (Manaus: 16 103)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'5b9e4baa-b4bb-5ef3-a0f3-8ab426452a4b', 215, 106, 107) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4c18bcb0-8a9a-51ad-a9da-677abda6df9c', E'REVERÊNCIA', E'Reverência, Deus presente conosco está. |
Torna santo também o lugar, sua voz poderemos ouvir.

Vigilância, porque santo é este lugar |
Unidade até no pensar, sua presença Ele fará sentir.

Aleluia, o momento é de grande prazer.
Isso é benção pra eu e você

A resposta da nossa oração

Aleluia, seí que posso até não merecer
Mas, confio que vou receber

Deus habita no meu coração.

Reverência, o milagre vai acontecer.
Quando opera Deus mostra o poder
Tudo pode por nós operar

Todo crente sua fé deve, sim, desprender
À vitória é daquele que crer

Por amor Deus quer abençoar.

Aleluia, nada vai impedir nossa fé

Ele opera do jeito que quer

Nosso Deus não faz acepção

Ão contrito que humilde suplica o favor
Deus responde é por puro amor

Porque olha nossos corações.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4c18bcb0-8a9a-51ad-a9da-677abda6df9c', 216, 107, 107) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'3088ff72-a316-5fd7-99df-1fbf6f1312da', E'RESTAURA-ME', E'Quero dar a minha vida à Cristo
Dedicar-lhe o meu coração
Submisso sempre mais humilde
Consagrando-me em oração

Na palavra sempre vigilante

E no tratamento com amor
Aos irmãos amados escolhidos
Sermos um, unidos no Senhor.

Ré

gudente e ter discernimento
buscar pra ser um vaso teu
evas-te em mim à todas as gentes
vação € O amor de Deus
ber a unção do teu Espírito
os aflitos consolar
ha vida anunciando Cristo
Es perando meu Jesus voltar,

jem restaura-me, restaura-me
Toma minha vida, oh...

vem restaura-me, Testaura-me
Toma minha vida, oh...

Vem restaura-me.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'3088ff72-a316-5fd7-99df-1fbf6f1312da', 217, 107, 108) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9c29bcd4-599e-5614-a79e-d15dbfa50a50', E'SALMO 133', E'Quão bom e quão suave é

Que os irmãos exercitem a fé

Em Cristo unidos em um só coração
Quão bom e quão suave é

Que os irmãos vivam pela fé

Com muita graça e muita unção.

pece

Como o orvalho de Hermom

Que desce do monte Sião

Sobre a cabeça de Arão

O óleo precioso da unção.

Pois Jeová ordenou

Ávida jamais faltará.

Paz e alegria que vem do Senhor,
4excelência de amar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9c29bcd4-599e-5614-a79e-d15dbfa50a50', 218, 108, 108) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'40a0a654-1333-5977-8c2e-bfe005a2b9ef', E'DEUS FORTE', E'Ele é o , ; s verdadeiro.
e é Deus forte, é invencível, Ele é Deu

. 4 Í 2
“ conselheiro, meu amigo e príncipe pi
que tudo existisse Ele existiu o mais
“avilhoso, eu te ofereço minha ia
És po: al ir idade.
hoje, ontem, amanhã, Pai da ie

u é em.
= tu sabes e me conheces muito mim tuà vontade.
O oleiro faz com o barro, faz em “m

0)
e pertenço para todo sempre;

O aid

so te sentir e te servir, tu és totalmente santo.
am alívio para O seu coração.

enxugas todo pranto.

eis a minha gratidão.

É glorio
Os que te buscam encontr
Alegra o triste, ergue O caído,
Oh! Aleluia, louvo o teu nome,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'40a0a654-1333-5977-8c2e-bfe005a2b9ef', 219, 108, 109) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'58e88139-d237-571c-9d46-d704889effff', E'QUANDO DEUS QUER OPERAR', E'Quando Deus que operar
Ele opera como quer

Faz milagre acontecer
Ele acrescenta a fé

Faz até O cego ver.

E se você quer sentir
Deus está neste lugar
Abra o teu coração

Ele te dará a unção
Você vai se alegrar.

Aleluia! A glória de Deus vai chegar

A frieza do crente Deus vai aquecer

Deus vaí também batizar

Vai derramar seu poder

Ele também vai falar para o que crer
Olha a glória de Deus espalhando aqui
Peça a Deus, mas com fé, Ele vaí atender
Cante louvores a Deus

Ele conhece os seus
Tem sua marca em você,

Ele é DEUS. (bis)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'58e88139-d237-571c-9d46-d704889effff', 220, 109, 109) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'1616d00b-c2f6-5f77-a38d-1515350853c4', E'JESUS VEM', E'Jesus vem, vem lá nas alturas.
Jesus vem, Ele voltará,

Jesus vem, glorioso o dia.
Jesus vem, Ele reinará,

Jesus vem, vem vitorioso,
Jesus vem, com poder virá.
Jesus vem todo majestoso,
Jesus vem, grande Jeová

Tá

y

vem triunfante em glória |

pesvê vem nos arrebatar.
josé vem, é nossa vitória.
, grande shekiná,

s vem, É O NOSSO dia
JS sem, vamos triunfar,
si, vem. Oh! Que alegria!
es s vem Jesus voltará (bis)

eiará, Voltará.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'1616d00b-c2f6-5f77-a38d-1515350853c4', 221, 109, 110) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'46074a6b-dab0-5c6c-88bc-b077586632e5', E'ALÉM, ALÉM DO INFINTro', E'gm, além do infinito azul
pa minha pobre imaginação
Na sua glória Deus está, todos os anjos a o ad
Com hinos de exaltação. Orar
O que então farei a ti, Senhor?
Como mostrar-te minha gratidão?
par-te-ei o de melhor, pois essa vida é como pó
só tem valor em tuas mãos.

Toda glória honra e poder

És o único merecedor

Dar-te-ei o meu louvor

Santo, santo és, Senhor

Deus de toda criação, meu Criador
Ainda assim és muito mais

Meu Conselheiro e Príncipe da paz

Tu és Salvador, amigo, és o meu Senhor
Nunca te deixarei, jamais.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'46074a6b-dab0-5c6c-88bc-b077586632e5', 222, 110, 110) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f12dd459-2086-53fd-a054-5524c1da33b4', E'H MARAVILHOSO E SANTO', E'Abrigo para o desprovido de amor
Esperança do perdido pecador

uz que ilumina quem nas trevas está
Para o aflito és a paz.

Ó maravilhoso e santo,

Por tua presença clamo
EM O teu amor não vivo
U te amo, Jesus Cristo

— mae RD

Tu és abrigo para o homem sofredor
Consolo para quem padece com a dor

O teu sangue é poderoso
Glorioso és, Senhor.

Não há maior prazer do que a tua presença traz
Razão do meu viver, tu és e tudo e muito mais

Viver sem ti é impossível para mim
Tu és o meu principio e fim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f12dd459-2086-53fd-a054-5524c1da33b4', 223, 110, 111) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f6d3d3f5-396a-5f9c-b7cf-98909ae1fee2', E'GLORIOSO SALVADOR', E'Ó maravilhoso e glorioso Salvador,

Justo, Santo és assim

Como compreender quem foi que te criou
Sem princípio e fim?

Antes que o mundo existisse eras Deus

Soberano sem igual

Ai de mim que nada fiz por merecer
Esse amor maior de quem tem o poder
Toda criação, o infinito ser,

Ninguém é sem razão pra Deus.

Oh! maravilhosa e gloriosa criação!

Tudo fez pensando em mim

Quando olho o céu e a sua amplidão

Oh! Eu sou feliz!

O leito do rio entre montanhas e pedregais
Da nascente ao mar as águas vão

Ai de mim que nada fiz por merecer
Esse amor maior de quem tem o poder
Toda criação, o infinito ser,

Ninguém é sem razão pra Deus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f6d3d3f5-396a-5f9c-b7cf-98909ae1fee2', 224, 111, 111) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e6c3b2ff-3701-5701-85d8-5c2846df187c', E'MAIOR É O MEU DEUS', E'Eu creio no poder de Deus
Vitórias eu alcançarei

Pecador eu sei que sou indigno
Mas eu creio no meu Salvador.

vs, elevo 2 ti a minha oração
Ea fé que eu receberei
E roblemas podem ser maiores do
nas não 8 ão maiores que meu Deus

a tempestade açoitar

m fúria O mar me sacudir

, saber que não estou sozinho
E fiarei que O mar vai se acalmar.

que eu

eus PASSOS, sim, eu seguirei

À tua sombra descansar

qu és à fonte cristalina para eu beber
Alimento que me faz andar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e6c3b2ff-3701-5701-85d8-5c2846df187c', 225, 111, 112) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'474ddc12-ac55-5750-8bd2-6c555d006000', E'MUITAS FELICIDADES', E'Mais uma vitória tens

Muitas bênçãos Deus te deu

Lutas e provações vencestes, glória a Deus!
E por isso, parabéns!

Nos caminhos do Senhor

Mais um ano se passou
Confiando em Deus, servindo a Jesus

Ao Senhor nosso louvor.

Muitas felicidades desejamos pra você
Que Deus te abençoe aínda muito mais

Muitas alegrias e fé nas provações
Confiando em Deus, parabéns de coração.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'474ddc12-ac55-5750-8bd2-6c555d006000', 226, 112, 112) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'58b69ba4-1213-5cc2-843c-d9de27f855df', E'OCRENTE É FELIZ', E'Jesus me encontrou, abri meu coração
O mundo me tirou, me deu a salvação
Felicidade tenho, agora estou na luz
à alegria é Jesus.

de queres possuir no reino um bom lugar
“Us convida, vem, de graça te dará
da dos pecados te dará perdão
tás a sua salvação.

me |

Ser crente é ser feliz, é bom ser um cristão
Viver o que a Bíblia diz de todo coração
Dos vícios para o bem, das trevas para a luz
Salvação só em Jesus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'58b69ba4-1213-5cc2-843c-d9de27f855df', 227, 112, 113) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'ae524a59-32e8-5800-a18d-a04846858a46', E'NUPCIAL', E'Deus uniu-vos no amor
Mais que simples afeição
Para serdes um Ele vos criou
Uniu vossos corações
Escolhidos sois de Deus
Para as bênçãos nupciais

E terem um lar feliz

Numa santa unção

Com o príncipe da paz

Com amor e alegria

Sejam assim as vossas vidas

No temor e na presença de Jesus
Deus vos dê sabedoria

Que o Senhor vos abençoe

Tenha as mãos sempre estendidas
E guiados pela gloriosa luz

Sejam assim os vossos dias. Amém.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'ae524a59-32e8-5800-a18d-a04846858a46', 228, 113, 113) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f20ffe8a-3651-5e53-bd3b-276f10f5f929', E'MENSAGEIRO DO AMOR', E'Quem irá anunciar o evangelho, proclamar
A mensagem de amor e salvação?

Quem irá aceitar o convite pra levar

Aos perdidos a mensagem da cruz?

Eis-me aqui, servo sou para anunciar o amor

De Jesus para salvar o pecador.

Pra dizer que Deus amou

De tal maneira que enviou

O seu Filho pra morrer por nós na cruz.
Quero ser, Senhor, mensageiro do amor
Que mostrou Jesus na cruz. (bis)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f20ffe8a-3651-5e53-bd3b-276f10f5f929', 229, 113, 113) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'260dbf34-6e66-5405-832a-6b58a59871a0', E'N JESUS MEU GUIA', E'E indo meu Senhor e Ele Me condu>;
vo o teino de amor onde irei hab; ax Uzirá
: eterna compaixao sempre sobr

. as e mim ,
a do céu um cidadão, Deus com sera
O!

igo
8 Sempre está,

5
om Deus ao céu de Plena luz,

ei comb"
per, verei, 20 lado de Jesus eu reinarei

uv , a “ge
Gom 08 anjos estarei ali
E antarei vitória enfim

0 mundo eu venci.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'260dbf34-6e66-5405-832a-6b58a59871a0', 230, 114, 114) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'fb900a6a-b333-5f4c-bea4-f1bdb923f4ef', E'NADA É MELHOR', E'Entre milhões me escolheste

Melhor não poderia ser.

Entre humanos, mais que todos

A alegria de saber que sou de Deus

O escolhido pra dele ser... Pra dele ser.

Aceito sim e pra dizer minha alegria em pertencer
A essa família e viver ao lado de Jesus, meu Mestre.
E como é bom! Eu sou feliz!

Nada melhor.... Nada melhor...

Aceito sim . (final)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'fb900a6a-b333-5f4c-bea4-f1bdb923f4ef', 231, 114, 114) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'a55b77e0-10d6-562e-a78e-853c94dd8d3a', E'ADORAÇÃO', E'Nós queremos te adorar
O teu nome exaltar, ó Salvador.
Em tua presença sempre estar
Na verdade proclamar O teu amor.
Pois maravilhoso és, invencível no reves,
Glorioso e soberano Criador.
iNguém poderá medir
“ amor é tudo, enfim, é sem igual.
“amo Salvador, pra sempre és
enhor da minha vida.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'a55b77e0-10d6-562e-a78e-853c94dd8d3a', 232, 114, 114) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'36fd2f7e-15ad-5ca1-bcb1-3fb45cf36a68', E'BREVEMENTE COM JESUS', E'Brevemente estaremos com Cristo
Nosso Mestre que nos conduz
Nosso amado brevemente vindo
Com toda glória, com poder e luz
Nossa vitória está garantida

Um novo nome vamos ouvir
Num só rebanho todos reunidos
Cantaremos, vamos subir.

Nosso sonho será realizado
Face a face vamos ver Jesus
Aleluia! Glorioso dia

Pela porta que se abriu na cruz
Fim de todas as lutas e gemidos
Nova vida de paz e amor

Ó Senhor, nós te amamos muito
Oh! Que glória! Dia de louvor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'36fd2f7e-15ad-5ca1-bcb1-3fb45cf36a68', 237, 115, 115) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4bb36352-be0e-5be0-a77b-0f44458fd390', E'ATUA PALAVRA', E'(26º congresso da Umimobrart/julho 08)

Vivifica o meu coração

Os teus mandamentos buscarei

Sim, os teus juízos santos e retos são
Amo teus preceitos, ó Rei dos reis,
Olha para minha aflição

Pois desejo andar nas tuas leis

Nelas encontrei minha salvação

Por guardá-las sei que viverei

A tua palavra é a verdade
Desde o princípio é assim
De geração em geração
Teus juízos não terão fim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4bb36352-be0e-5be0-a77b-0f44458fd390', 238, 115, 115) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'63d0f122-faec-5cfd-9b85-98243d290e48', E'ANDAI EM AMOR', E'Y

9
I Congresso UMIMOB

or AMOS que Cristo a si mesmo Serem
(0) sacrifício que suave foi a Dais egou

not nós seu sangue no calvário derramo

ve com ele nós andássemos u

para 9 em amos
z que morr,
a Cl, Que seu Sangue verteu

Fez nos filhos amados, amados de Deus
para todos andarmos também eramos
como filhos amados do nosso Senhor') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'63d0f122-faec-5cfd-9b85-98243d290e48', 239, 116, 116) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9a1bfd0f-c613-5216-be36-e7e665a4b0be', E'DEUS MEU PRAZER', E'Deus, tu és meu maior prazer
Deus, a minha razão de viver
Deus, eu quero te obedecer
Deus, santo eu quero ser
Contigo até parecer

Contigo sempre aprender

Que somente em ti tenho paz
Minha vida está em tuas mãos
Sigo certo na direção

Até contigo encontrar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9a1bfd0f-c613-5216-be36-e7e665a4b0be', 240, 116, 116) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'37c1fc09-13fd-59c3-b31f-2c41c233045c', E'JAMAIS TE NEGAREI', E'Não vou deixar meu Deus, à casa que me deu,
Minha família e meus irmãos
qui eu sou feliz, assim a Bíblia diz:
mundo é grande ilusão.
ia irei negar, jamais irei mentir
“Mais me rebelar, jamais irei sair
o mo meu Jesus, por mim levaste à cruz
“Es, no meu caminho, luz.

— eme

Não vou deixar meu Deus, a casa que me deu,
Minha família e meus irmãos

Aqui eu sou feliz, assim a Bíblia diz:

O mundo é grande ilusão.

E qual maior prazer o mundo pode dar?
Ninguém há de viver, feliz ninguém será

Pois nada é melhor e nada é igual.

Tu és, Senhor, meu ideal.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'37c1fc09-13fd-59c3-b31f-2c41c233045c', 241, 116, 117) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b1300b60-8e36-589b-95f4-9871735e6815', E'EU VOLTEI A SER FELIZ', E'O que seria de mim? Onde estaria agora?
Já teria um fim, minha pequena história
Quando eu decidi desprezar a Jesus,

Foi o que resolvi, eu larguei minha cruz

E foi quando aceitei o conselho dos ímpios
E também desprezei o amor dos irmãos
Eu nãos quis mais saber de falar de Jesus
Fui no mundo viver, para as trevas eu fui
Fui buscar o prazer que lá fora eu via
Resolvido parti pra viver minha vida.

No inicio então era só maravilhas

Me sentia o tal, só mostrava alegria

Mudei meu visual para os moldes do mundo

De amigos troquei, me vesti como ímpio.

Já não queria mais ler a Bíblia Sagrada

Ir à igreja, talvez, pra agradar os irmãos

E assim cultivei as sementes das trevas

Esse mundo abracei, sem temor eu vivi

Entre o mundo aceitei-me, me sentia um encanto
E assim fiz chorar o Espírito Santo.

Eu voltei ser feliz, Deus mudou minha história
Eu voltei a sorrir, teve misericórdia

Quando eu decidi retornar a Jesus

Foi o que resolvi: carregar minha cruz

E foi quando aceitei os conselhos de Cristo

E também abracei o amor dos irmãos

Eu voltei a viver, a andar com Jesus

E o mundo deixei pra andar só na luz

Vim buscar o prazer que lá fora não tinha
Resolvido voltei pra verdade, a vida,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b1300b60-8e36-589b-95f4-9871735e6815', 242, 117, 117) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'69477806-d19f-5d50-9575-6bdd2336b2a1', E'IVER COM JESUS', E'343
as VEZES quando olho as Coisas da ”
vi
) sando vejo como o mundo e as Eblsas A
Q à dade, à violência e vidas Perdidas Estão
a antos gastam € Outros Morrem sem pn:
verdade até parece virou mentira Pão!
nem mente até parece ter a razão
ata OS poderosos ninguém vê a justiça
Ninguém vê O amor nos corações

ph! Pode o mundo escolher viver sem
Escolhf pra eu viver na tua luz

Te agradeço a minha salvação
Reconheço em mim O teu amor

Quero a tua proteção, ó Meu Senhor

Jesus

Que felicidade tenho em meu dia-a-dia
sinto a paz de Deus fluir no meu coração
E falar sobre Jesus é minha alegria

E no meu louvor mostrar gratidão

No caminho da verdade estou e da vida
Onde posso descansar sem preocupação
Pois em Deus confio e na sua justiça
Deu-me por amor a salvação.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'69477806-d19f-5d50-9575-6bdd2336b2a1', 243, 118, 118) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'581a61bd-36b5-56b0-8911-b6185cf4afff', E'VIVER PARA TI', E'Sim, eu quero ser, Senhor, sempre uma benção
Eu quero ser, Senhor, sempre assim

Vivendo sempre em tua presença

Vivendo minha vida para ti

ao mundo o teu amor

Orando, cantando, anunciando
alva o pecador.

F eliz, falando que Jesus Cristo s

e') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'581a61bd-36b5-56b0-8911-b6185cf4afff', 244, 118, 118) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4fc0a5c8-a5a4-51f8-ae7d-fdbf72ebf4c8', E'OS CAMINHOS DO SENHOR', E'Nos caminhos que andei não encontrei o que eu precisava achar
Insisti, continuei pelos caminhos que escolhi pra caminhar

Me perdi e, sem direção, em trevas eu clamei ao meu Senhor
Logo recebi o seu perdão e fui resgatado pelo seu amor

Os caminhos do Senhor são caminhos de justiça e promovem paz

E que neles caminhar achará prazer felicidade e salvação
Pois os caminhos do Senhor são caminhos que nos levam ao encontro

de Jesus
E quem neles caminhar verdadeiramente a luz encontrará.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4fc0a5c8-a5a4-51f8-ae7d-fdbf72ebf4c8', 245, 119, 119) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd1a9c47b-f6d9-57c4-baf6-207c5d86a345', E'SEDES HERÓIS', E'Levantai-vos e andai
Levantai-vos e andaí

É a ordem que Ele dá
Sede heróis, sede heróis
Na seara do Senhor.

(Este hino foi dado pelo Senhor ao Pastor Luiz Leite Farias. Agradecemos ao autor a
autorização para a inclusão no binário Inspirações)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd1a9c47b-f6d9-57c4-baf6-207c5d86a345', 246, 119, 119) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'57e1e2fc-f3ed-5fa2-b0a0-c6ec1bb218fb', E'VOU BUSCAR A TI SENHOR.', E'(1º Congresso da UMIMOBRART no Ceará )

Vou buscar a ti Senhor, sei que podes me ouvir. Nada tenho, nada sou, mas,
eu posso te sentir. Guarda o meu coração, quero ser fiel a ti. Livra-me a tua
mão, sim, preserva-me.

Quero reter, guardar e viver todas palavras que o Pai me ensinou, sei
que assim tudo posso vencer, ter uma vida de fé e amor. Sabedoria eu
peço a Deus para aplicar seus preceitos em mim e nessa vida aq ui
viverei testemunhando de ti.

Y') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'57e1e2fc-f3ed-5fa2-b0a0-c6ec1bb218fb', 247, 119, 120) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'636a4e51-bcd8-5fc6-9eb6-93b9e1531392', E'DEUS VISITA VOCÊ,', E'uê
aa dia da vida Deus sempre vem Visit
No “ovelhas queridas, com elas vem Conversa
t.

quer momento do dia você poderá recep
er

dante Senhor Jesus Cristo e anicc o.
oman ANJOS visita A
t Você,

AP

0e
sinto à presença de Cristo,

; sinto a presença de Deus,

y sinto à presença do Espírito Santo,

Fu sínto alegria do céu.

às vezes, dormindo em meu leito, meu nome eu ouço ch

oh! Que momento glorioso, eu sinto e não sei explicar e

Mas sei que é Ele chegando, é o momento da visitação,

Qu oro, ou choro, ou canto um hino, desfruto com Deus comunhão') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'636a4e51-bcd8-5fc6-9eb6-93b9e1531392', 248, 120, 120) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'253bc9c7-1027-5107-a8c6-1a8166f4879b', E'JESUS É..', E'Jesus é minha vitória, Jesus é meu Salvador,

Jesus é O Rei da glória, Jesus é o meu Pastor.

Jesus é o carpinteiro, Jesus é o mediador,

Jesus é o Jardineiro, Jesus é o conquistador.

Jesus é a minha vida, Jesus é princípio e fim,

Jesus é no caminho o guia, Jesus é tudo pra mim.
Jesus é minha alegria, Jesus é minha canção,

Jesus é o pão da vida, Jesus é a Salvação.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'253bc9c7-1027-5107-a8c6-1a8166f4879b', 249, 120, 120) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'a64df039-34db-5b1e-be8f-d1196638506c', E'SEI QUE O TEMPO AGORA CHEGOU.', E'Sei que o tempo agora chegou

Dos adoradores que o Pai separou

Louvar ao Senhor com sinceridade.

E Deus é Espírito, Cristo falou
Importa adorá-lo como Ele ensinou
m, em espírito e em verdade.

D ,
“US através de seu filho Jesus
Ostrou o caminho que a verdade conduz

“sim desfrutarmos com Deus comunhão.
“US, quero dar-te meu maior louvor.

ins Pltito e em verdade com todo amor
minha vida em adoração.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'a64df039-34db-5b1e-be8f-d1196638506c', 250, 120, 120) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'89823086-f369-5a45-85a2-cdb1b238202f', E'FOI ASSIM QUE JESUS', E'Foi condenado a morrer entre malfeitores quem só fez O bem,
Humilharam e maltrataram o meu Senhor Jesus

E ainda zombavam: “Salve o Rei dos Judeus”.
Foi com uma coroa de espinhos e com cravos fixaram-no na cruz,
Sobre Ele meus pecados ainda mais pesou.

Foi assim que morreu, com seu sangue Ele me salvou.

Mas, foi a nossa vitória

Quando o eco do seu brado ressoou na cruz

E rendendo seu espírito assim falou:

“Eis que tudo ó Paí, consumado está”.

O céu e a terra moveram-se,

Sepultado dentre os mortos Ele ressuscitou

E pra nossa alegria ele voltará.

Foi assim que Jesus, com seu sangue na cruz, me salvou.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'89823086-f369-5a45-85a2-cdb1b238202f', 251, 121, 121) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd2f683bf-6b8c-57a4-a80a-efd3710ce1de', E'UM CORAÇÃO SINCERO', E'Dá-me um coração sincero, dá-me mais e mais amor.
Só falar o que é reto, não falar o que não sou.
Transparente e verdadeiro, uma vida exemplar.
Nunca exigir primeiro, mas o primeiro em amar.

Dá-me um coração sincero, dá-me mais unção do Céu.
Pra viver o que eu prego, ser exemplo e ser fiel.

Ao olhar o companheiro transmitir-lhe amor e paz.
Pois perdoando-lhe os erros minha culpa se desfaz.

Dá-me um coração sincero pra servir a ti Senhor.

Com cuidado e com mais zelo, humildade e com temor.
Sempre andar com vigilância, uma vida de oração.

Ter as obras de quem ama, ser um servo, um cristão,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd2f683bf-6b8c-57a4-a80a-efd3710ce1de', 252, 121, 121) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'61dd223a-19d5-5ed9-b2db-7655fed4849c', E'GLÓRIA AO SENHOR,', E'Quero, ó Deus, viver sendo útil ao teu serviço
Quero aprender, crescer com compromisso,
Mais que um amigo, sempre andar contigo,
Juntos na missão levar ao mundo paz.
Quanto mais te busco mais de ti preciso,
Sinto tua presença e quero mais comigo,

into torno-me ij ,
ndo eu te si N O-Me invencível,
(e sentir, Senhor, um campeão,

pure
qria 20 Senhor com louvor, sei que sou
Q um
aça imensa é a força que sust Vencedor
qua gr2S eNta, Glória

| ao Senhor, (bis)
et0, 6 Deus, viver sendo uma luz no Mundo
vero apresentar-te COM Meu testemunho, *
.s que um amigo, único caminho,
Única esperança de alcançar a paz.
nero aprender a ser um bom discípulo,
Quero repassar O que aprendi contigo.
Quando estou contigo sinto-me num abrigo,
protegido e salvo. Sou um campeão.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'61dd223a-19d5-5ed9-b2db-7655fed4849c', 253, 121, 122) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'ace66f89-4cb3-5410-a9d6-ac87adcf05f5', E'VÊ-LO-EI, VÊ-LO-EI.', E'Existem sim paisagens na terra, beleza de imenso valor.

São coisas onde Deus se revela, só mesmo as santas mãos do Senhor
Porém, para O homem um destino, em trevas e vivendo sem luz,

Sem Deus e totalmente perdido, mas pra salvar-lhe veio Jesus,

Vê-lo-ei, vê-lo-et. E um santo desejo que tenho de ver a Jesus.
Vé-lo-ei, vê-lo-eí. Consagrando e me santificando verei a Jesus.

Existem tantas coisas na vida, possuem realmente valor.

À natureza, obra divina. Com o homem a criação coroou.

E nada é puro, santo e mais belo na terra, céus, nem do sol a luz.
O que desejo e o que eu mais quero é ver o meu amado Jesus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'ace66f89-4cb3-5410-a9d6-ac87adcf05f5', 254, 122, 122) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'60045f70-f021-5edb-b1f3-82ba4578c942', E'SOU FELIZ', E'Sou feliz, Jesus me Salvou

Oh! Sou feliz, Ele habita em meu ser

dU feliz, comigo Ele está

OU feliz por Ele tanto me amar

o feliz, vou servi-lo melhor

x li é tê-lo na vida

4 12 É ter felicidade ação
Saber na verdade que habita o seu cor

E

Cera

casas

Oh! Grande amor que sua vida deu

Pra nos salvar e dar vida aos seus

Oh! Grande amor que por nós se entregou e morreu
Grande amor de Jesus e de Deus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'60045f70-f021-5edb-b1f3-82ba4578c942', 255, 122, 123) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'0dff3b78-a7cf-59ae-bee3-9459936c6a2f', E'ADMIRAÇÃO.', E'Quando eu contemplo a natureza em harmonia no amanhecer do dia, ao
nascer do Sol. O cantar dos pássaros, perfeita sincronia, destacando à
sinfonia, canta o rouxinol. O orvalho que à relva saciou a sede. A melodia que
o vento entoa faz bailar a flor. A luz que imperiosa vem trazendo um novo
dia. No horizonte, os vales e os montes louvam ao Senhor.

Eu devo aprender no amanhecer de um novo dia, agradecer a Deus por
tudo que Ele fez por mim. O Sol, a chuva e a casa que me aquece em
noites frias, a terra onde colhi o pão que me alimentou. E ainda o
louvarei por minha família. Por todos que professam Cristo como
Salvador. Se a natureza aqui da terra tanto me fascina, O que direi da

nova terra para onde vou?

Caudaloso corre o rio exuberantemente, refrescando e alimentando o homem
e a plantação. Nuvens em nichos de algodão nos cumes do monte. Nos altos,
os frutos da semente que plantei no chão. Se eu amo a Deus, eu amarei
também a natureza. Nada é sem motivo, tudo tem sua razão. Nem uma folha
caí da árvore que Ele não queira. Ele tem o universo na palma da mão.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'0dff3b78-a7cf-59ae-bee3-9459936c6a2f', 256, 123, 123) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'28421a4b-db11-5482-8c0b-2d71dc815f11', E'SANTA CEIA.', E'Por tua santa convocação nos separamos e em oração

Aqui estamos para cear, te suplicamos nos preparar.

Fortalecidos em fé e amor nós te pedimos, ó Salvador

Que nos permita com tua aprovação tomar o cálix, comer o pão.

Iremos juntos todos cear com reverência e todo temor
Solenemente com gratidão, com alegria e devoção.

O que recebi eu vos ensinei, na noite em que traído foi
Tomando o pão agradeceu, Por nós seu corpo e o sangue deu.

Nesse momento de comunhão quando iremos comer o pão.

Comei, disseste, em memória de mim, com minha morte eu vos remi.
Tomando o cálix, disseste bem: nova aliança faço também.

Bebei, disseste, em memória de mim, até que eu venha, fareis assim.

ós o vinho e o pão, a ordenan

na a
job? dade entre OS 1rMãos, todos iguai O lava-pés,

S se

se O

pia') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'28421a4b-db11-5482-8c0b-2d71dc815f11', 257, 123, 124) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'dbd969d6-cacf-5484-9659-c5b99d9058b6', E'O FILHO DE DEUS', E'j nasceu numa humilde manjedoura

Eu os humildes Ele se criou
gabalhou numa carpintaria

ceus braços € mãos de um trabalhador

Mas Ele era O filho de Deus

Ao seu dispor os exércitos do céu
Como ninguém falava Ele falou:
usou Jesus, o filho de Deus

0 filho de Deus

Ele nasceu para nossa alegria
E como servo viveu sendo Senhor

El sofreu no corpo a agonia
Quando morreu na cruz só por amor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'dbd969d6-cacf-5484-9659-c5b99d9058b6', 258, 124, 124) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'26b7be31-063c-5eeb-9e01-63ecc2a62d3b', E'OFUNDO DO MAR', E'Quem quer saber o que Jonas enfrentou
Quando fugiu da missão de pregador?
Deus quis salvar Nínive da perdição
Mandou o profeta falar da salvação
Num porão de um navio se escondeu
OU pra Társis lá estou longe de Deus
to a tempestade e o navio ia naufragar
ibendo o motivo jogaram Jonas no mar

Quem quer saber o que pode acontecer
“ão fizer 0 que ele mandou fazer?
“ando Ele ordena Ele dá a direção
“em Vai para Társis está indo na contrama
sm Jonas, o profeta, nos ensinou andou
Se º S€ arrisque, obedeça ao que Ele m

à assim você não quer acreditar r
“ento Vem, você vai pro fundo do mat

ns N

pr decerdes ao que vos ordenei, bem-a acepção.
i Í ém é : : -“dVen

te de mim ninguem € maior, pois Ry co a fados todos Sereis

Somos um só :') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'26b7be31-063c-5eeb-9e01-63ecc2a62d3b', 259, 124, 124) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'63ced5c3-c09f-585c-b694-6cf47e934c29', E'A FELICIDADE', E'A felicidade é O desejo de Deus pra todo cristão
A felicidade é a virtude que faz bem ao coração
A felicidade acrescenta a paz, a felicidade é tudo e mais

É a busca do ser que almeja viver da forma eficaz
A felicidade é possível em tempos de tribulação

A felicidade se adquire amando os irmãos

A felicidade se encontra em Jesus

Caminho que leva a verdadeira luz

A felicidade nasceu com a morte de Cristo na cruz

A felicidade é o desejo de Deus pra todo cristão

À felicidade é a virtude que faz bem ao coração

À felicidade acrescenta a paz, a felicidade é tudo e mais
É a busca do ser que almeja viver da forma eficaz

À felicidade é possível em tempos de tribulação

A felicidade se adquire amando os irmãos

A felicidade se encontra em Jesus

Caminho que leva a verdadeira luz

Oh! Felicidade. Eu sou feliz, feliz, feliz.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'63ced5c3-c09f-585c-b694-6cf47e934c29', 260, 125, 125) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4781ba5b-e8f8-5b48-8065-3dff0c0b9f20', E'QUEM VEM A MIM', E'Quem vem a mim jamais rejeitarei
Quem vem a mim eu o treceberei

Quem vem a mim o caminho encontrará
Verdade e vida ele receberá

Sou bom pastor eu o alimentarei

D''água da vida sua alma saciarei

Quem vem a mim, sim, pode descansar
Nos braços meus sua vida estará

Quem vem 4 mim, sim, eu o amarei
Seremos um, ovelha e pastor

Eu lhe darei comer do pão do céu
Quem vem a mim o livrarei do mal
Quem vem a mim eu o esconderei
Vitória certa, eu o defenderei

Serei seu Deus comigo habitará
Quem vem a mim a paz encontrará

o

quem vem a mim (receberei)

qem vem a mim (o amarei)
vem vem a mim (serei seu Deus)
vem vem a mim.

Q') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4781ba5b-e8f8-5b48-8065-3dff0c0b9f20', 261, 125, 126) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9c42191f-e1b5-5097-90bd-c3bf1ef6ec3e', E'VIDA DE CRISTÃO', E'Vou viver à minha vida de cristão
Com amor, com devoção

Vou anunciar com mais satisfação
gm Jesus a salvação

viver com Deus é viver feliz

se viver o que a Bíblia diz

Ser a luz no mundo em escuridão
Quero ser, ser um cristão

Vou viver a minha vida de cristão
Sempre andar em oração

E da Bíblia vou encher meu coração
Tem água viva, tem também o pão

Vou viver a minha vida de cristão
Em temor com retidão
O meu sacrifício não será em vão
Sim terei meu galardão.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9c42191f-e1b5-5097-90bd-c3bf1ef6ec3e', 262, 126, 126) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd3575983-4f31-51b7-b8f8-31a7d7ba9c74', E'VERDADEIRA VIDA', E'Eu sei que Cristo me ama

E quer o meu bem

Eu sei que Cristo te chama

Pra dar-te também

Verdadeira vida que só Cristo tem

Quando a dor chegar e tribulações
àmos nos lembrar que consolação
fometida está para os corações
é de tesponder nossas orações
É € fiel e conosco está
“fa nos livrar e nos guardar do mal

RL Btaça enfim será sobre nós

“assim nos diz: Você vencerá.

am NS e') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd3575983-4f31-51b7-b8f8-31a7d7ba9c74', 263, 126, 126) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd4b2e600-a8b8-56d7-b1ca-0ea7dae36a9d', E'RENDEMOS GRAÇAS', E'Nós te rendemos graças, Ó Senhor, de coração
Sim de coração, de todo coração

Por tua santidade e por nossa salvação

A ti a nossa adoração

Nós vamos te adorar, vamos glorificar
Tua fidelidade nós queremos proclamar
Nós vamos te adorar, vamos glorificar
Oh! Glória e aleluia, tu estás neste lugar

Somente tu és digno de receber louvor
Tu és o meu Senhor, excelso Deus de amor

Es majestoso e santo, tu és sem comparação
A ti a nossa adoração

E se a angústia sobre o nosso coração vier
Sabemos que estarás provando a nossa fé

Por certo ouvirás, Senhor, a nossa oração

A ti a nossa adoração.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd4b2e600-a8b8-56d7-b1ca-0ea7dae36a9d', 264, 127, 127) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'60f6debb-6b66-51f4-81fb-5387cd1123a7', E'CIDADÃO DO CÉU', E'Oh! Que alegria sinto dentro do meu coração
Por três votos fui eleito do céu cidadão
De tal maneira Deus assim me amou

Jesus com sangue me comprou
O Espírito Santo em mim habita, salvo agora sou.

Sou muito mais que milionário, agora rico sou
Riqueza e glória deste mundo não têm mais valor
A nova identidade diz: sou muito mais que coronel
Com sangue de Jesus marcado, cidadão do céu

Oh! Que alegria sinto dentro do meu coração
Poder cantar com alegria na tribulação

Se a minha cruz pesada é,

Não é maior que a minha fé

Eu creio na minha vitória e minha salvação

y muito mais que milionário

44 Ed e 6) a A | o
sig uezA esta a deste mundo não a Fo sou a
identidade diz: s . :
nova ou Muito . Mais Valor

com sangue de Jesus Marcado, ci dada UE Coronel
do do cé') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'60f6debb-6b66-51f4-81fb-5387cd1123a7', 265, 127, 128) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'29e3b088-a56a-5950-bc88-a7b7bff2ccf7', E'CRISTO ME AMA', E'oh! Eu amo a Cristo, sei que sou querid
Sou por Ele amado, d''Ele escolhido o
Grande é à vitória, me tornou seu fn Elmo
E mudou a história, me tornou s eu filho') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'29e3b088-a56a-5950-bc88-a7b7bff2ccf7', 266, 128, 128) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'83a8b7db-1c0c-52be-82e5-315a2dd4b341', E'SER COMO TU ÉS', E'Nós nos reunimos pra te adorar

E nos consagramos pra estarmos aqui
Queremos ouvir O que tens a falar
Ensina-nos como devemos agir

A fim de imitarmos a ti, ó Senhor
Queremos em tudo ser como tu és
Mostrar pelos frutos o nosso amor
Também pelas obras mostrar nossa fé

Ser como tu és.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'83a8b7db-1c0c-52be-82e5-315a2dd4b341', 267, 128, 128) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd51e78d1-5751-5b17-b0ae-e719bbdcde4b', E'O AMOR DE DEUS', E'Oh! Como eu gostaria de explicar o amor
Pois sem merecimento Ele.me amou
Tornando-me assim capaz de amar
E não olhar a quem
Oh! Como eu poderia imaginar assim |
Que Cristo amou-me a ponto de morrer por Fura
Mudando a minha triste história para um final feliz
Oh! Como eu gostaria de explicar o amor
Tornando um derrotado em grande vencedor
De um caído e deprimido, .
Cristo transformou-me em campeão

gora eu vou falar do seu amor pra quem (2»)
Quiser vitória e se levantar também

iz é ite e vem.
eliz é aquele que recebe o convite

o
mama age

Egas') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd51e78d1-5751-5b17-b0ae-e719bbdcde4b', 268, 128, 128) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd24d90ee-735e-5bf6-acd4-9a77f45ba306', E'SE O AMANHÃ CHEGAR', E'Se o amanhã chegar será também pra mim
O tempo de amar a tantos que ofendi

Se o amanhã chegar será também pra mim
Tempo de trabalhar, fazer o que não fiz

Mas o melhor se hoje acontecer

O encontro triunfal, Jesus me receber

Oh! Como almejo vet o rosto de Jesus

Oh! Como almejo ver o trono do meu Deus
Assim pra mim será se o amanhã chegar
Mas hoje espero meu Jesus voltar

Se o amanhã chegar será também pra mim
Tempo de granjear o dom que recebi
Se o amanhã chegar será também pra mim
Tempo de repensar, ser mais leal a ti.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd24d90ee-735e-5bf6-acd4-9a77f45ba306', 269, 129, 129) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f5b0147f-fbfb-5903-a318-01bf70e00a5a', E'EXISTE UMA CIDADE', E'Existe uma cidade

Longe, mui longe daqui

Um paraíso reservado

Preparado para mim

Cidade construída em ouro e cristal
Num reino de justiça onde reina a paz
A vida é eterna e morte não há jamais.

Com meu Deus eu viverei

Glória a Deus eu cantarei

Oh! Que bom, descansarei

Aleluia, santo e santo, glória a Deus

Verei Jesus irmão, amigo e meu pastor
Amado, a quem eu devo a vida e meu louvor
Sião, Jerusalém, pra ti voando vou.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f5b0147f-fbfb-5903-a318-01bf70e00a5a', 270, 129, 129) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'991cc505-191a-5003-b18a-02971558a6c6', E'LÁ NÃO HÁ DOR', E'í o há dor, ninguém Vai SOfrer
E pj vê ma, nin
ore mproble guém vai morre er
IN e idade, justiça e amor |
| [só rebanho e um só pastor |
| os todos como Ele é 1]
| [Ss em tudo nos mostra a fé |
sm Que alegria! Eu posso dizer. |

pronto pra eu e você,

nr o está') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'991cc505-191a-5003-b18a-02971558a6c6', 271, 130, 130) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e7ccaac6-156a-52cd-99eb-97f93f78a3bc', E'BUSCAI DE DEUS', E'ascai de Deus a sabedoria | |

ga inteligência também
Como O sábio vivendo seus dias |
| Com discernimento do mal e do bem |

De Deus é o dom do conhecimento

De toda ciência e de todo saber |
| Deus é à fonte da inteligência

O homem jamais deverá se esquecer

Ó Terra, ó Céus, ó Abismos dos mares,
Ó Montes e vales, sol, lua também
Sabedoria, onde moras? Quem sabe?
Achei-te no homem que teme a Deus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e7ccaac6-156a-52cd-99eb-97f93f78a3bc', 272, 130, 130) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'3f4cd6c5-86ed-5b97-8010-e488b73787b2', E'TENHO NOVA VIDA', E'Tenho nova vida, vida de alegria
Vivo a liberdade que Cristo me outorgou
Sou ovelha viva e por Deus querida

“luia, Jesus Cristo é meu Salvador

Bom Pastor é o Senhor
“U Cajado me conduz
Oba sua sombra vou

no é minha luz

da então eu temerei

cn

RE
o nes ee

Nele eu descansarei

Em verdes pastos me faz andar
Nada, nada faltará

Nada faltará.

Tenho nova vida, vida de alegria

Tenho garantia, seguro em Cristo estou
Meu pastor me guia às águas tranquilas

Sou ovelha protegida, Jesus é meu protetor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'3f4cd6c5-86ed-5b97-8010-e488b73787b2', 273, 130, 131) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b8ead9de-0a02-5508-bf20-486c0ab9da28', E'COM CRISTO ESTAREI', E'Eu tenho certeza em Cristo

Um dia com Ele estarei

Com toda certeza eu digo:
Verei o semblante do Rei.

Eu tenho certeza em Cristo

Eu tenho meu lugar no céu
Novo nome já escolhido

Pros salvos benditos de Deus

A hora já se aproxima

O dia glorioso virá

A face então eu verei do Senhor
E sempre, pra sempre louvor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b8ead9de-0a02-5508-bf20-486c0ab9da28', 274, 131, 131) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'22defb96-eac0-5ec3-87aa-44fd75bf4d6d', E'EU SOU UM MILAGRE', E'Quero testemunhar do poder do meu Deus.
Um milagre salvou minha vida.

Lá no mundo estaria perdido eu sei.

Mas aqui sou um milagre de Deus.

Milagre, eu sou um milagre
Do poder e do amor de Jesus
Milagre, sou o maior milagre
Do sangue vertido na cruz.

Desprezado também como foi meu Senhor.
Sem valor, para muitos um inútil.

Tenho, porém, valor porque Cristo me amou.
E por Deus sou amado e querido.

Não me falta Prazer, alegria e paz

Nas aflições sempre Passa Comigo

Nerd melhor, nem pior, Ele me fa, ca
Pois eu sou um milagre de Cristo, pie.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'22defb96-eac0-5ec3-87aa-44fd75bf4d6d', 275, 131, 132) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'c6d39ee9-7928-5a4e-8807-25d5e67cd02f', E'CUIDADEMIM', E'Cuida de mim, cuida de mim

Às águas tranquilas e serenas

Minh “alma quer descansar,

Cuida de mim, cuida de mim

À sombra da tua presença

Eu posso, irei repousar.

Cuida de mim, cuida de mim

Sou forte quando eu tenho a
Alegria que o mundo não pode dá
Tu és entre tudo que tenho o tesouro maior.
E de todas as coisas o melhor,
Por isso eu peço, cuida de mim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'c6d39ee9-7928-5a4e-8807-25d5e67cd02f', 276, 132, 132) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'55f71220-c6b3-591d-8a47-048feb04883b', E'MINHA ABSOLVIÇÃO', E'Venho perante ti numa declaração.

Dizer-te o que senti em minhas recordações.

Cheguei até chorar, lembranças do que vivi,

De tantos erros meus, coisas que cometi.

Até que eu lutei tentando escapar,

Ainda assim deixei meu coração levar.

Se eu queria ou não,

Dilemas tão cruéis que me fizeram ser um servo infiel.

Mas o mover da cruz se revelou como à razão de tanto amor,

Que tu ó meu Jesus, meu Mestre € meu Es

P 2gando alto preço pra me conceé der dh as 4 condenação.
Íque eu merecia, por tantos erros € ú

: nerdão.
ÔMo sou grato, em troca recebi perdi. 0
Do amor da cruz, MINHA ABS OLVIÇÃ') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'55f71220-c6b3-591d-8a47-048feb04883b', 277, 132, 132) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'2fca1a87-041d-525f-8d31-861030fd3605', E'ÓH GLÓRIA', E'Minha vida era só pecado.

E eu só queria diversão.

Era muito triste meu estado.
Mas Jesus me trouxe salvação.

Oh! Glória! Hoje sou remido pelo sangue puro carmesim,
Oh! Glória! Hoje canto hinos, minha alegria é Cristo em mim,

Pelos vícios era carregado.

Sem temor nenhum no coração.
Cada vez de Deus mais afastado.
Totalmente cego, sem visão.

Arrumei pra mim amigos ímpios.
Nos meus lábios só depravação.
Enganado e sempre iludido.

Era assim minha situação.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'2fca1a87-041d-525f-8d31-861030fd3605', 278, 133, 133) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'cacb9d03-2c99-5860-8289-59e22a9b9c93', E'O NOSSO NATAL', E'Nós nos reunimos e como jamais
Diante do trono do Deus Criador

E irmanados em laços de paz

Sem diferença de raça e cor

Há esperança em cada olhar

E emanados por gloriosa luz

Até conseguimos com fé contemplar
Na face do irmão o rosto de Jesus.

Sorria, se alegre, levante a voz
Confie, acredite Ele está entre nós
Você foi ungido, é tão especial
Nós fomos unidos no sangue,
Sangue Real,

dá

«e é um dia muito especial
qi celebramos o nosso nata] |
dia em que nós conhecemos Jesus
0 dia em que as trevas se tornaram luz
edimos à Deus, soberano Senhor
ue todos humanos conheçam Jesus
obre, O tico, O mendigo, o doutor
A novas de vida, Jesus

Jesus Salvador.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'cacb9d03-2c99-5860-8289-59e22a9b9c93', 279, 133, 134) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9a86ec51-611c-513d-ab56-d1c958d4da79', E'CRISTO ME FAZ TÃO FELIZ', E'sinto o amor de Deus em mim,
Posso dizer que sou feliz,

Meu coração se alegrou no Senhor.
Deus me fez, me separou,

Me escolheu pra seu louvor

Posso cantar pra o mundo ouvir:
Cristo me faz tão feliz.

Vou cantar (adorar e louvar)

Vou louvar (somente a Deus adorar)
Adorar (com alegria a Deus exaltar)
Minha alegria é cantar.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9a86ec51-611c-513d-ab56-d1c958d4da79', 280, 134, 134) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9dd20824-0eec-5763-8bdb-9981bcc0cfb9', E'OUVIR TUA VOZ', E'Eis me aqui em tua presença. Tua voz preciso ouvir. —

O Senhor, minha alma anseia mais que tudo ouvir-te, sim.
Não suportarei a ausência, impossível é prosseguir.

Oh, tua voz me orienta, eis me aqui pra te ouvir.

Nada mais é precioso do que tua voz ouvir.
ada é o valor do ouro comparado a ouvir à fi.
Ja voz me alimenta, reanima a prosseguir.
“a voz me tranquiliza, eis me aqui pra te MIT.

e

meme sena!') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9dd20824-0eec-5763-8bdb-9981bcc0cfb9', 281, 134, 135) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'e3b10fa4-ac4e-52cd-a72f-ea70df9b858e', E'JESUS, O BOM PASTOR', E'que me enviou para dar vida pelo pecador,

o Pai amado
Pel m nenhum temor buscam as ovelhas que sj

Pois os mercenários se
Senhor.
Sou Jesus o bom pastor, amo minhas ovelhas e por todas Geri

amor, amo sem diferenças. Quando as chamo pelo nome,
conhecido sou. Todas têm valor pra mim, sou o bom pastor,

Pela porta entro, sou o bom pastor. Pastos verdejantes e águas puras
dou. Livro-as da garra do enganador. Amo as ovelhas, sou o bom

pastor.

E de toda terra eu as ajuntarei, pois, um só rebanho eu apascentarei,
Sou do Pai amado, minha vida dei. E à glória vou levar todas que

ganhei.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'e3b10fa4-ac4e-52cd-a72f-ea70df9b858e', 282, 135, 135) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'fedf250e-ce3b-5cf8-a57f-ad80ad3fce71', E'CONFIANÇA NO SENHOR', E'Ao Senhor a glória e honra, Criador da terra e céu. E ainda assim me
ama, fez-me herdeiro e filho seu. Confiemos no seu nome, no seu
nome há poder. Ontem, hoje, amanhã e sempre. Unico e supremo ser.

Nenhum Deus é semelhante, nada sabem, nada são. Só Jesus que nos
garante a eterna salvação. Soberano e absoluto. Quem confia nºEle tem
o amparo e escudo hoje e para sempre, amém! (Final: Amém)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'fedf250e-ce3b-5cf8-a57f-ad80ad3fce71', 283, 135, 135) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'a47d3c54-7b0a-51f4-bf0c-41c11e91038e', E'TEMOR DO SENHOR', E'Feliz é o homem que teme ao Senhor

Não anda ou se assenta e nem se detém
Entre malfeitores e escarnecedores

E maus conselheiros não houve também
Bem-aventurado quem teme ao Senhor
E em seus mandamentos tem o seu prazer
Justiça, bondade e amor ele traz
E no seu caminho Deus com ele vai,

sal
a

IS E PEMIEEDA DD re mm me

como árvore plantada à be;

4
era eir.
S rempo e nunca falha. Firme asd guas
Sfo » Prod;
GS faz prosperar, mas o f . a ) Uuzos
peu Mpio s erá c n rão, a frut
a mão

| Mas o ímpio 4
espalha PIO será como a 0a alh |
Palha a que |
que O vento |') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'a47d3c54-7b0a-51f4-bf0c-41c11e91038e', 284, 135, 136) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'420bf47f-3126-5b0f-b534-2fcd9872702c', E'VELA POR MIM', E'jo temo O mal, nem o vil tentador
ada me pode deter.

abençoado e amado eu sou

Cuida de mim pra valer

Vela por mim, vela por mim
Sob seus cuídados estou

Vela por mim, vela por mim
Destruto do seu grande amor

Nem mesmo a morte será o meu fim
Não há mais separação

Absolvido pra sempre eu fui

Livre da condenação.

Posso deitar e em paz descansar
Vela por mim com amor

Minha vitória é certa e virá
Cuída de mim o Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'420bf47f-3126-5b0f-b534-2fcd9872702c', 285, 136, 136) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'd4f1abc4-abfb-51be-a4e0-abea6ec794d9', E'OVELHA, SIM.', E'Sou ovelha do Senhor
Seu cajado me conduz
Aos pastos verdejantes vou
Unde águas sempre flui
Ainda que por vale for
Nenhum mal eu temerei

Se O inimigo atacar

le me protegerá.

Ovelha (sou ovelha) do bom pastor
Somos todos dEle sim
Ovelha (sou ovelha) do bom pastor

Zela com amor por mim
Bondade e paz desfrutarei
Sempre e sempre o louvarei.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'd4f1abc4-abfb-51be-a4e0-abea6ec794d9', 286, 136, 137) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'37d4319f-35b5-534c-9ff0-f99512d7d30f', E'VAMOS TRABALHAR', E'Segundo nossas obras haverá o galardão.
Quem no verão ajunta no inverno tem seu pão.
Mas quem só admira fica na contemplação.
Diante da escolha qual a sua decisão?

Vamos trabalhar o dia passa a noite vem
Deus é o exemplo de quem trabalhou também.

Quem semera colhe e quem planta frutos tem.
Deus é nossa força, vamos semear o bem.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'37d4319f-35b5-534c-9ff0-f99512d7d30f', 287, 137, 137) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'bcf924d4-ec12-50c6-a052-8b31b8c9f6ba', E'SATISFAÇÃO', E'Minha juventude está nas mãos de Deus.

Sou ovelha do supremo e bom pastor.

O louvarei com meu viver, com meu falar onde estiver.
Sou guiado e vivo pela fé.

Vou testemunhar quão grande é o seu amor.

Da salvação que ofereceu na cruz.

O louvarei pois me amou, a minha vida resgatou.

Salvo e livre canto a Jesus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'bcf924d4-ec12-50c6-a052-8b31b8c9f6ba', 288, 137, 137) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'ef305ec4-7cca-5845-ab21-a7cae1ec6e85', E'PORTO SEGURO', E'Ele é o Deus poderoso, amor e justiça.
Faz como lhe aprouver, Ele tem a medida.
Deus zeloso Ele é, nas nuvens caminha.
E conhece os seus, os que n''Ele confiam.

Meu escudo, minha força

Meu refúgio e fortaleza,

Me conhece, não me esquece,

Me protege, bom Ele é.

Me conforta também nas m aire

Nele aporto seguro, nºEle está 9 tristezas,
Minha fé,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'ef305ec4-7cca-5845-ab21-a7cae1ec6e85', 289, 137, 138) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'7040171e-6853-5f81-8688-a19014d230d3', E'AVIDA POR VIR', E'Quando a noite chegar para mim

Os meus dias chegarem ao final

O momento em que irei partir

Para a minha morada eternal

Quero ir encontrar meu Senhor

Do trabalho enfim descansar

Oh! Que glória será quando a noite chegar
Quando for convidado por ti.

Oh! Espero feliz, sempre minha alma quis.
Conhecer e viver com Jesus.

Tantos días aqui me fizeram sentir.

Que o melhor é a vída por vir.

Quando a noite chegar para mim
Dormirei para estar com o Senhor

Para os santos que dormem em ti

Já não há mais qualquer dissabor

Oh! Que gozo será para mim

Alcançar o descanso afinal

Oh! Que glória será quando a noite chegar.
Quando eu for convidado por ti.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'7040171e-6853-5f81-8688-a19014d230d3', 290, 138, 138) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b96c9f7d-5378-5ac5-88ba-78c5e169ec60', E'LEVANTAI-VOS', E'Oh! Que alegria na minha vida

A luz divina resplandeceu |

Com Jesus Cristo no meu caminho
u tenho brilho, eu sou de Deus.

Oh! Levantai-vos e resplandeça
Em vós o brilho, a vossa Juz

De Deus a glória em nós apareça
Que todos vejam em nossas vidas

Cristo Jesus.

De glória e glória vou prosseguindo,
Resplandecendo a luz de Deus.

Na minha vida vou refletindo,

A luz de Cristo que em mim nasceu.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b96c9f7d-5378-5ac5-88ba-78c5e169ec60', 291, 138, 139) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9d5a04a2-009b-5844-b0ad-7d13bfbb1775', E'PORQUE CLAMAS A MIM', E'Eu conheço a tua dor também teu interior.

Das angústias do teu coração.
Pensas em não suportar, não ter forças pra lutar.

Que não vejo a tua aflição. -

Porque clamas a mim?

Porque pensas assim:
Que será o teu fim, que de ti esqueci?

Muito mais por ti softi.
Faça a obra eu te escolhi.
Só eu Sou e estou perto de ti.

Todo que chamado for, é provado e por amor preparado para a grande
missão. Ninguém pode compreender o que fiz e vou fazer. Preparai,
sim, O teu coração.

Ide, pois, a frente andai, nem sequer pra trás olhai.

Siga atento minhas instruções.
Cada um que eu chamei no final entregarei por suas obras O Seu
galardão.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9d5a04a2-009b-5844-b0ad-7d13bfbb1775', 292, 139, 139) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'683afacb-179b-5222-963f-63398204e03f', E'FALAR DE JESUS', E'Nao Nega a Mensagem d
À S à Cruz,
e SA oo. .
º ampo ou em grandes cidades, não !Mporta a idade se pobre ou
No cà
of.
dout

bra no ide do mestre que todos Confessem Jesus Salvador.
em
Mas)

ntos no mundo perdidos não Pensam em Cris
a “” º Ld
oh! pas Oh! Quantos não creem no Juízo,
or. Ob.
Salva
4 or. e .
Deus € a isa amor sem medida que Deus enviou-nos seu filho
co o.
Mas foi 4 re Justiça, levou-o a morrer na cruz,
- ue é amor e justiça,
Pois Deus q

to Jesus
apenas aceitam que

1 Í tr.

homem que espera e em vida se alegra em Cristo Senho

iz é o hom ê e amor.
ei divina promessa do céu, nova terra de o o

eia ro e desejo Jesus pra você.
, F aqui deixo um conselh, Espe inh ra uem quer viver.
Amigo, é a verdade e a vida, único caminho pra q

. a vV
Pois Ele é') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'683afacb-179b-5222-963f-63398204e03f', 293, 140, 140) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4b3ca84c-a12c-5fe2-a84b-9dbf18c28761', E'NO MEU CORAÇÃO', E'Enquanto eu viver desejo Hg dei ;
Em tudo obedecer, ser su E da
Ó Deus, o meu louvor é min a

À minha vida está nas tuas maos.

Tá o! 0Z
E róptia V

Minhas palavras sejam 2 var ntê nós.
E em mim que todos vejam- o perdão.

. re ,
Que eu transmita paz, ros está em mim,
Em tudo refletir que Cris rs )
No meu coração. (no fina') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4b3ca84c-a12c-5fe2-a84b-9dbf18c28761', 294, 140, 140) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b21d96d5-7d17-5a75-9997-ddba7ffcba97', E'FONTE DE ÁGUAS CRISTALINAS', E'(35º congresso da UIMOBRART / Julho 2017)

Fonte de águas cristalinas

A fonte divina que é Cristo Jesus
Pão que alimenta a alma

A tua palavra que dá vida e luz.

Sim, gerados fomos no poder de Deus
Ressurgindo Cristo, com Ele os seus
Incorruptível herança nos ganhou
Pela fé seguimos e por seu amor.

Pela sua presciência, Deus nos separou
E no Santo Espírito nos santificou
Para obediência e na aspersão

Do sangue de Cristo, a nossa salvação.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b21d96d5-7d17-5a75-9997-ddba7ffcba97', 295, 141, 141) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'92290c62-4547-5c44-a9ce-9b31adfc93b4', E'E ASSIM DIZ O SENHOR', E'(10º congresso UMIMOBRART 8º RG/Ago. 2017)

E assim diz o Senhor que habita em um alto e santo lugar:

Eu estou entre os contritos para os tornar a vivificar

Minha glória é transcendente, tão sublime e singular

É mais alto onde habito, não se pode mensurar

Mas ainda um Deus presente para os abatidos levantar

Se com o coração contrito e arrependido a mim se apresentar. Eu sou
Deus, estou presente e quero te abençoar e contigo novamente habitar.

Vinde a mim, eis o convite, tudo novo se fará
Vou curar suas feridas, também vou te perdoar
Minha glória, santidade, eternidade e poder

Só eu tenho e compartilho com você

Só eu tenho e compartilho com você. Com você.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'92290c62-4547-5c44-a9ce-9b31adfc93b4', 296, 141, 141) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'68cfdcda-255f-5642-b267-b3d9dbfc22de', E'ISSO É FÉ', E'RT 7a

qres no Deus do impossível e que a vitória já
Vem

pla fé. ]
fer naquilo que espera, em coisas

eso é fé ”
nfrenta fornalha, sossega leão
esrota gigante, atravessa Jordão

Co nfia e na prova permanece em pé

crer no que a Bíblia ensina e nas promessas que tem

Pela fé.

Crer na graça divina e que Jesus Cristo vem
Isso é fé.

Caminha pra frente e pra trás nem pensar
Ser parte da igreja e jamais se afastar
Alegra-se em Deus e ser como Ele é

Isso é fé. — Final: Pela fé, isso é fé.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'68cfdcda-255f-5642-b267-b3d9dbfc22de', 297, 142, 142) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'3841a15b-ce8b-5a0f-84b0-35de729f5e8f', E'E QUEM É ESSE', E'E quem é esse que tem toda autoridade,
Com Daniel fechou a boca dos leões?

E quem é esse que domina a gravidade,

E sobre as águas anda como fossem chão?

E quem é esse que acalma a tempestade,
O mar e o vento obedecem a sua voz?
E quem é esse que opera e faz milagre?
É Deus Pai, Filho, Espírito e Ele é por nos.
é quem é esse que é desde a eternidade, | , ,
“e veio ao mundo pra cumprir sua missão!
- Quem é esse, cura as enfermidades?
Jesus Cristo, o caminho, a salvação.

E quem é esse que aqui está agora?
Sua presença acalma nossos corações.
E quem é esse que já decretou vitória?
Por seu amor ouviu as nossas otaçoes.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'3841a15b-ce8b-5a0f-84b0-35de729f5e8f', 298, 142, 143) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'1e337611-0251-564e-bb13-5e64c074086e', E'EU PRECISO DE UM RENOVO', E'(9º congresso Umimobrart 8º RG / agosto 2016)

Sei que tu Senhor, és puro e santo

E estou aqui pta te adorar
Como oleiro que trabalha o barro

Me domina, vem me renovar.
Tenho em mim esse desejo ardente
De servir-te com mais devoção
Como purificador de prata

Purifica o meu coração.

Eu preciso de um renovo

Faz como o fogo faz ao ouro

Elimina as impurezas que há em mim
Purifica-me agora e retira toda escória
Dá-me um coração sincero pra te servir.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'1e337611-0251-564e-bb13-5e64c074086e', 299, 143, 143) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'2d4ca509-456a-517e-8126-4811b1330a52', E'GRAÇA, FAVOR IMERECIDO', E'A tua graça é O que preciso
Sempre vitórias vou alcançar
Sempre mais forte e até invencível
À tua graça me faz triunfar

Graça é favor, sim, imerecido

Tão rude e mal não posso almejar
Por tua bondade e amor infinito
De Cristo a £raça eu vou desfrutar

A tua graça é O que preciso

Nas tentações que me sobrevêm
Quando em dilema, quando aflito
À tua graça É o que me sustém

| Pará
| somente à ti serei submisso

| Pois o que basta é tua graça em mim,

a graça é O que eu preciso
opta AS vis ofertas do mal
orte zeloso e assim decidido

| com tua graça venço afinal

A tua graça é o que preciso
viver, ter paz, ser feliz') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'2d4ca509-456a-517e-8126-4811b1330a52', 300, 143, 144) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'cb33caa5-91f0-5b24-836b-29147cc22b7f', E'JESUS COMPANHEIRO', E'Jesus Companheiro é sempre fiel
Em todo tempo cuida de mim
Jesus conselheiro, caminho do céu
Meu destino está em suas mãos

Eu entreguei.

Vou, porque está comigo

Vou, és o meu abrigo

Vou, suas fortes mãos estão sobre mim
Vou, porque me sustentas

Vou, porque me alimentas

Vou e vencerei o mal

Com Jesus vou vencedor

Jesus verdadeiro, ninguém é igual
Conforto e alívio para o meu coração
“sus paz perfeita, vitória real

; To 6) mal.
Nvencível, santo, no seu nome venço') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'cb33caa5-91f0-5b24-836b-29147cc22b7f', 301, 144, 144) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'004926a0-0ad4-543d-8eb1-d71ede8f884b', E'NÃO TROCO JESUS', E'Andava pensando na vida: Quem sabe um dia eu seria alguém?
Pensei que a maior alegria seriam os amigos e possuir muitos bens,
Pensei num brilhante futuro, comprando de tudo o que enfim desejar,
Vivendo uma vida de luxo, meu prazer: desfilar.

Buscando dos homens a glória, a fama e uma história de ostentação,
Ser capa de muitas revistas, aclamado na mídia e da moda, o vilão.
Quem sabe na praça uma estátua escrita na base: fulano é o tal,

Pensei essa vida é pra mim: ideal.

Mas quem vive ou busca essa vida

Cai numa armadilha, uma grande ilusão

Verá que é espuma na areia que essa grandeza é bolha de sabão.
Jesus: o presente, o futuro a alegria dos homens só Ele contém
Por isso eu não troco Jesus por ninguém.

Se andas pensando na vida, querendo de fato também ser alguém.
Existe um projeto já pronto pra dar à sua vida a importância que tem.
Então serás mais do que rico, mais nobre que os nobres dos reinos daqui,
Terás um futuro de glória, um homem feliz.

Amigo qual é teu destino? Aonde tu pensas que tu podes chegar?

Jesus disse: Sou o caminho, a verdade e a vida só eu posso te dar.

Se queres a paz e alegria um futuro de glória que só Cristo tem.

Por isso eu não troco Jesus, por ninguém.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'004926a0-0ad4-543d-8eb1-d71ede8f884b', 302, 145, 145) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'2cbf1e19-9c77-5d57-8e7a-1e72addb4efc', E'TUDO ELE É', E'Jesus é o nome mais lindo de pronunciar
O nome que traz alegria, paz no caminhar
Jesus, nome puro e belo

Aquele que eu amo e quero

O nome sobre todos nomes

Não é apenas de um homem , ele é eterno.

ad Senha o
| plo é meu enhor, amigo e irmão

gle é soberano autor da salvação

pé invencível, tem todo poder

Jória é impossível descrever

| ge é Deus forte, pai da eternidade

| 4 maravilhoso, conselheiro e mais

| Be é ogrande príncipe da pa,

esus, NOME que contém toda caridade
| o nome que liberta o homem, conduz à verdade
Com ele ninguém vai sozinho
Jesus é próprio caminho
Jesus é O nome querido
É nome do divino, verdadeiro amigo.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'2cbf1e19-9c77-5d57-8e7a-1e72addb4efc', 303, 145, 146) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'420d1da8-e59f-5c92-baab-dce97cd000b0', E'QUERO CONHECER JESUS', E'Eu primeiro quero ver meu mestre
Quero muito conhecer Jesus
Quanto almejo, ó Senhor
Contemplar teu esplendor

Sim, a ti dedico meu amor.

Quando é o dia eu não sei
Quando a hora vai chegar

Que eu adentrarei no céu de luz
Multidões enfrentarei

Os milhões que também sei
Que desejam ver-te, ó Jesus

Para mim é um troféu
Quando adentrar no céu
Contemplar a face do Senhor

tras marcas do sofrer

Ve passaste até morrer

“fa resgatar um pecador

eee

Quando o dia enfim chegar

Quando iremos te encontrar

Tudo o que eu quero é conhecer Jesus
Também conhecer a Deus

Tanto amor que o filho deu
Resgatando um perdido réu.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'420d1da8-e59f-5c92-baab-dce97cd000b0', 304, 146, 147) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b574b490-cf37-57b8-ba98-d0b4777cc2f1', E'RESTAURAÇÃO', E'Sinto o teu amor por mim aqui agora

Tuas mãos me segurando pra me levantar
Teu perdão pelo que fiz, erros que eu cometi
Desprezando teu carinho e o amor por mim
Eu confesso que não fui inteligente

Quis ser ímpio e resolvi não ser mais crente
Realmente me afastei e lutei pra ser feliz

Até tentei, mas eu não consegui

Eu voltei, te procurei, arrependido retornei
Suplico, ó paí, o teu perdão, minha reconciliação
Fui infeliz na decisão, ouvi a voz da multidão
Mas reconheço e voltei pra sempre.

Obrigado por me receber de novo
Obrigado pela minha reconciliação

O abraço do Senhor, os abraços dos irmãos
Renovando a aliança que quebrei

Agradeço por voltar pra minha casa

Onde eu nasci e onde aprendi amar

Pois o mundo é ilusão, o amor não é real

Aqui há paz e liberdade afinal.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b574b490-cf37-57b8-ba98-d0b4777cc2f1', 305, 147, 147) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f6ebfbb7-6b68-53c3-bf69-f44ba3a93aef', E'GRATIDÃO', E'uero oferecer a tio meu melhor
Vou apresentar O que posso fazer
pasa mim nada é maior
Nada tem maior valor
Do que ajoelhar-me aos pés do salvador.
Manifestarei em obras meu amor
E que todos saibam e vejam isso em mim
Tudo que eu conquistei oferecerei a ti |
Eu te amo e teu amor me faz feliz.

Mestre, amigo, meu Senhor meu tudo é teu
Os meus sonhos se resumem sempre em ti
Pois a vida que viver para mim terá valor
Se oferecida for ao meu Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f6ebfbb7-6b68-53c3-bf69-f44ba3a93aef', 306, 148, 148) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'cf6b8086-084f-5396-ab50-cf2b581e2158', E'SEMENTE SANTA', E'Semente lançada na terra produz

O fruto germina de vida e luz

São frutos do Espírito que alegra o Senhor
Raízes regadas por águas de amor

Sementes lançadas no meu coração
Me deu nova vída, alcancei seu perdão
Agora os frutos darei para Deus
Firmado em Cristo, o justo e fiel

Assim era a terra do meu coração
Sem vida, esperança e sem salvação
Jesus Com seu sangue tratou € curou
Os frutos brotaram e frutos de amor

A Semente santa não morre jamais
“Bada ao seu tempo produz para a paz
s frutos são vivos a palavra quem e
OIs a água é Cristo e quem bebe € feito') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'cf6b8086-084f-5396-ab50-cf2b581e2158', 307, 148, 148) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'b4f0ab9e-13a6-5542-9731-35c5b8843ac5', E'PROFUNDIDADE DAS RIQUEZAS', E'Oh! Profundidade das riquezas,
Tanto da sabedoria

Como da ciência de Deus =
Quão insondáveis são OS Seus os caminhos ,
Ou quem compreendeu o intento do Senhor:

Ou quem foi seu conselheiro?

Quem a Ele recompensatá?

Quem deu a Ele primeiro?

Porque dele e por Ele, e para Ele

São todas as coisas, glorias, pois, a Ele

Para sempre amém, amém.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'b4f0ab9e-13a6-5542-9731-35c5b8843ac5', 308, 149, 149) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'cf97139b-c991-59d3-bbc2-86b742259923', E'FELIZ PARA SEMPRE', E'Não há riquezas no mundo
Prazeres e glória aqui

Maior e melhor é o futuro

Dos salvos que aguardam em ti
O céu é o nosso destino enfim,

Com Cristo pra sempre feliz.

Oh! Como sou grato agora
Jesus me aceitou para si
Herdeiro me fez da glória
Que os salvos terão no porvir

O mundo é puro engano

Não pode a alma alegrar

Mas, Cristo tornou-se humano
Pra o homem perdido salvar
Feliz é quem serve a Cristo Jesus
Tem vida e anda na luz,

A graça de Cristo achou-me
Me fez encontrar com Jesus
Da morte eterna salvou-me
Das trevas me trouxe pra luz
Agora há paz e alegria em mim
Com Cristo tornei me feliz,') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'cf97139b-c991-59d3-bbc2-86b742259923', 309, 149, 149) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'fa88c944-3a7b-5298-8ed4-4fd04ca5f118', E'RECONCILIAÇÃO', E'310 a ;
ongresso da UMI
MOBRART na 1º

. RG-2017)
Deus escreveu a história

para a vida que me deu

para o seu louvor e glória

Fui gerado e assim sou eu

Minha vida a ti pertence

O sangue de Jesus selou

Com a nova aliança me reconciliou,

Vou me reconciliar com Deus

Renovar a minha comunhão com Ele
Novamente o adorar, em Espírito andar
E daqui pra frente ser um novo crente
Final: Novamente, novo crente (bis)
Com Deus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'fa88c944-3a7b-5298-8ed4-4fd04ca5f118', 310, 150, 150) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'5de16030-e87b-5c54-a56e-0c3fb9da927d', E'AMIGO', E'Eu não vivo só, tenho um amigo

Sempre me acompanha mesmo em perigo
Se fraco estiver, tenho o seu auxílio
Sempre está comigo, meu melhor amigo

Não há amigo, outro igual não há
Ele é o amigo fiel

Além dos males daqui me livrar
Com ele irei aos céus

Eu não vivo só, tenho um amigo |
Sempre anda ao meu lado, nunca estou sozinho
Meu guarda fiel, sempre está comigo

Meu Senhor e mestre, amigo divino

Eu não vivo só, tenho um amigo
Companheiro sempre junto no c
Nele tenho fé, ando protegido |
Nele estou seguro, sim, em Jesus Cristo.

aminho

o') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'5de16030-e87b-5c54-a56e-0c3fb9da927d', 311, 150, 150) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'c235d85a-d2a3-5e19-9b27-34ea632c3f8a', E'FILADÉLFIA E O CRENTE', E'(8* congresso UMIMOBRART 6º RG)

Aquele que é Santo, verdadeiro e Fiel |
Dominador da terra e comandante no céu
Filadélfia, aqueles que vivem a fé

Ao anjo da igreja Jesus manda falar:

A porta está aberta, ninguém pode fechar
Filadélfia, de ti posso me orgulhar

Meu nome não negaste nem na tribulação
Guardaste firme a palavra no coração

Na provação que sobre toda terra virá
Filadélfia, também vou te guardar

Guarda o que tens, é a tua vitória
Pra que ninguém tome a tua coroa.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'c235d85a-d2a3-5e19-9b27-34ea632c3f8a', 312, 151, 151) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f2438988-19f5-5bfb-9d1e-8544730aa19a', E'ENSINA-ME', E'Quero conhecer-te mais e mais
Não apenas ver-te ou ouvir

No meu testemunho te imitar
Jamais os teus preceitos transgredir

Ensina-me, molda-me

Domina-me, usa-me

Pois o maior desejo do meu ser

É ser fiel cumprindo o teu querer
Perdoar também, amar sem distinção
E semelhante a ti e como és serei.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f2438988-19f5-5bfb-9d1e-8544730aa19a', 313, 151, 151) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'01ec3cc9-edda-5ff1-b413-e0571010612b', E'OH ALELUIA, EXULTAREI', E'Oh! Aleluia, Oh! Glória a Deus
Oh! Aleluia, proclamarei

Que grande amor de Deus
Tornando-se meu pai

Me fez seu filho e herdeiro seu

oh! Maravilha! Oh! Glória a De
m Jesus Cristo tudo se fez us

esperança, sem um 1
sem de Cristo i 26 Sem salvaçã
Agora filho e de Cristo irmão ação

oh! Aleluia, exultarei

oh! Aleluia eu cantarei

Porque eu creio em Jesus Cristo, homem D
Que veio ao mundo e por mim morreu eus
Em sua presença me alegrarei

Poís Deus me chama, amado seu

Seremos semelhantes a Ele e temos fé
Que o veremos como Ele é.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'01ec3cc9-edda-5ff1-b413-e0571010612b', 314, 151, 152) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f16e4c8d-1e6d-55af-b429-f5e605d2596f', E'A NOSSA VITÓRIA', E'De Deus é a glória e todo poder
Pois só Ele salva, o que nele crer

E sua palavra nossa espada é

E com a armadura de Deus vestidos

Lutemos com fé.

À nossa vitória garantida está
Se em Deus buscarmos

Forças pra lutar
Então revestidos do poder de Deus

Firmes sem temer, à vitória é
Do povo de Deus. (bis).') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f16e4c8d-1e6d-55af-b429-f5e605d2596f', 315, 152, 152) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'424bef0e-3a82-5cf3-a3e9-edbc8ee7dec0', E'VIVER PARA DEUS', E'humilde

Quero amar, perdoar, também ser mais
mas com amor
m testemunho |

Entre os irmãos o menor sem soberba,
Eu quero que Deus apareça através do meu bo

A honra, a glória e grandeza são do Senhor
e glória

Quero alcançar a coroa de justiça
cão vem rugin do

Fi . o
itmes na fé, na esperança, vigian
ara vencer o inimigo que como |

À . edor.
às Cristo o alicerce seguro me faz vent

Vou cantar, vou dizer | | a
Com Cristo, por Cristo e pra Cristo eu vivo a vida

Vou cantar, vou dizer |
Só Ele oferece e tem verdadeira alegria.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'424bef0e-3a82-5cf3-a3e9-edbc8ee7dec0', 316, 152, 153) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'f7de06ec-b63a-577c-8734-15e23c11cec3', E'MINHA ORAÇÃO', E'Não sei dizer como eu te amo
Suave e doce é ouvir tua voz

Ó meu Jesus, preciso tanto
Curar o mal que me destrói
Não, não me abandones
Sei, eu sou um pecador
Mas Jesus te amo

Ouve o meu clamor

Há tantos que foram curados
Jesus eu sei que foi o teu amor

E seí, nem todos os meus pecados
Podem impedir, curar-me a dor

Ó eu não mereço

Mas suplico teu perdão

Ouve, eu te peço

Minha otação.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'f7de06ec-b63a-577c-8734-15e23c11cec3', 317, 153, 153) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'13730b6a-b2fc-5497-a9ba-b0df804b140a', E'GRAÇAS TE DOU', E'(11º Congresso da Umimobrart -8º RG — 2018)

Em tua presença me apresentarei
Com meu coração eu a ti buscarei
Com minha oferta com fé e amor
Diante de ti me coloco Senhor

À tua vontade será para mim
Resposta que peço que busco de ti
Eu quero fazer o que queres Senhor
De ti vem a força serei vencedor

graças te dou por me ouvir
u imenso amor

gr té .
cuída de mim.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'13730b6a-b2fc-5497-a9ba-b0df804b140a', 318, 153, 154) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'4000d7d8-bfec-5edd-b45c-c3cc2ef9bf1c', E'SABEDORIA PROVÉM DO SENHOR', E'= 4018
abedoria provém do Senhor
conhecimento vem dele também
Como a tesouros buscar com amor
A todos concede não nega a ninguém

Inteligência ele acrescentará
É dele o desejo de dar

Quero conhecimento, discernimento
Inteligência, viver com temor

E ter alegria, uma vida digna

Ouvir e entender meu Senhor.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'4000d7d8-bfec-5edd-b45c-c3cc2ef9bf1c', 319, 154, 154) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'90d893ee-a896-52fa-a068-c9c477818302', E'A NOSSA VITÓRIA', E'(11º Congresso da Umimobrart na 7º RG — 2018)

De Deus é a glória e todo poder
Pois só Ele salva o que nele crer

E sua palavra nossa espada é

E com a armadura de Deus vestidos

Lutamos com fé

À nossa vitória garantida está

Se em Deus buscarmos

Forças pra lutar

Então revestidos do poder de Deus
Firmes sem temer, a vitória É

Do povo de Deus (bis).') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'90d893ee-a896-52fa-a068-c9c477818302', 320, 154, 154) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'859ba511-559d-5526-9c39-0f707e4bf661', E'SANGUE CARMESIM', E'E no calvário dores sofreu

Pra nos salvar na cruz morreu
Com dor e sangue nos resgatou
Crucificado só por amor

Sangue puro sim, sangue carmesim
Nesse sangue fui lavado

Meu Jesus doou por mim

Sangue puro sim, sangue carmesim
Esse sangue derramado

Foi por mim, também por ti

A cruz que Ele sim carregou
Era pra mim um pecador
Tão humilhado sendo Senhor

Poupando-me terrível dor

Oh! Aleluia, posso cantar
Jesus morreu em meu lugar
Ó meu amigo, olha pra cruz
Por ti também morreu Jesus.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'859ba511-559d-5526-9c39-0f707e4bf661', 321, 155, 155) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'0adc1c17-83f0-5e44-8f52-51398cdcc15c', E'NOSSO DEUS É SANTO', E'Nosso Deus é santo cobre com seu manto quem suplica e chora.
E aos seus pés se lança lágrimas derrama e com fé implora.
Nosso Deus é vivo Ele está contigo e te diz agora:

Recebi teu pranto e a ti respondo vou mudar tua história.

Nas minhas promessas e na esperança
E também na fé e sempre crendo

Vou te dar vitória.

E na oração e no amor do Paí

Na graça que vem lá da cruz

No santo sangue de Jesus

Ao nome do Senhor a honra e glória.

A

ms

|
|
|

Ê
F

!

Ê

Ê') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'0adc1c17-83f0-5e44-8f52-51398cdcc15c', 322, 155, 156) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'228913eb-eb36-5ff8-bcf3-2843a31865bb', E'DEUS É MEU LOUVOR', E'peus já preparou o céu pra mim
Meu futuro Ele já gatantiu

Sei pra onde irei quando eu partir
Seu amor se revelou na cruz

Pelo sacrifício de Jesus

Fui liberto e agora ando na luz

32

Aleluia, agora em Cristo salvo estou
Não há mais condenação final pra mim
Aleluia, Deus mudou meu pranto

Em gozo transformou por isso canto
Que somente para Ele é meu louvor

Hoje canto é meu maior prazer

Era um condenado a morrer

Seu perdão e salvação mudou meu fim
Oh! Que glória! Absolvido fui,
Perdoado e salvo por Jesus

Através do sangue que verteu na cruz') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'228913eb-eb36-5ff8-bcf3-2843a31865bb', 323, 156, 156) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'737261ab-7147-5d51-9c85-815323e2a5e5', E'SOBERANO DEUS', E'Exaltar-te-ei e glorificarei as tuas obras maravilhosas
Digno és Deus de honra e louvor

O que por mim fizeste, puro amor.

Eu te adoratrei e em ti me alegratei

Regozijar-me-ei em tua presença

Ouviste meu clamor, livraste-me, Senhor

Enquanto eu viver te louvarei.

À tua glória é incomparável

E sem limite o teu poder

Santo, santo és imutável

Quem pode dos teus olhos se esconder
Á tua justiça é inquestionável

Em ti habita a glória de ser

Soberano Deus, Senhor Emanu el
Louvado sejas para sempre amem.
(final: Amém, amém, amém)') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'737261ab-7147-5d51-9c85-815323e2a5e5', 324, 156, 156) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'44de7799-2553-59e9-aa43-ee9acb9f2e84', E'ABENÇOADO POR DEUS', E'Senhor com minha alma eu quero te agradecer

Em tudo reconheço o teu amor, o teu poder

Grande em misericórdia, ninguém pode te deter

Pois és soberano em tudo o que quiseres fazer o
Ninguém te dá conselhos, ninguém jamais te ensinará
Do nada fazes tudo, enriqueces a quem tu desejar

E agora agradecidos pois conosco foiassim

Antes servos tão inúteis nos comprastes para ti.
Senhor quem pode impedir teus planos?
Quem pode resistir tuas palavras?
Quem poderá aniquilar teus sonhos?
Que reservastes para nós cumprindo em glória tua voz .
Empoderando os que confiam em ti?

Quem fui? Quem sou? O que eu hei de ser?

Não fosse teu poder, tua bondade?

Mas hoje sou filho do Reí, herdeiro das riquezas sei
Por isso para sempre o louvareí. Amém, amém.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'44de7799-2553-59e9-aa43-ee9acb9f2e84', 325, 157, 157) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'6e36fea8-0bd7-5c1f-8b2d-739f818997fc', E'IMITADORES DE DEUS', E'(9º Congresso da UMIMOBRART na 6º RG — 2019)

De toda obra má, de toda impureza

Que não convém aos santos servos do Senhor
O Deus, nos livra e que nossa vida seja
Referencial de Deus o nosso Salvador

Assim é a vída de quem olha no espelho
E vê na imagem o semblante do Senhor
Pois sua vída tem as obras do Espírito
E Deus o Paí é filho amado imitador.') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'6e36fea8-0bd7-5c1f-8b2d-739f818997fc', 326, 157, 157) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9cb24c4d-6143-51c6-80e3-833a87f84c49', E'VAI EM PAZ, DEUS TE ATENDEU', E'Ana orava, com O coração buscava

Uma resposta para O sofrimento seu

O sacerdote viu que só balbuciava

Com autoridade logo a repreendeu

Até quando estarás embriagada?

Do vinho te afasta e ela então lhe respondeu:

Ó, meu senhor, não pense assim dessa mulher

Em aflição e grande angústia estou eu

Sou mulher estéril, mas busco a Deus com fé
Então disse à mulher: vaí em paz, Deus te atendeu,

Qual o problema que aflige a tua alma?
Que te traz lágrimas que molham os olhos teus?
Deus está vendo, ouvindo e Ele te acalma

Levanta agora e canta porque Deus te atendeu.
Final - (Levanta agora e canta, vaí em paz, Deus te atendeu.

Atendeu, atendeu.)

Assim Deus faz da maneira que lhe apraz
Quando nos prova Ele nos leva a oração
Mesmo pensando que a prova está demais
Deus não é homem, Ele tem a solução

Agora é a hora, o momento oportuno

Use a fé, levante aos céus o seu clamor

Deus está perto, está ouvindo tua prece

E com certeza a tua fé reconheceu

Es filho amado de um pai que não se esquece

À endeu.
E pelo sangue de Jesus: vai em paz, Deus te at') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9cb24c4d-6143-51c6-80e3-833a87f84c49', 327, 158, 158) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'fd8b145b-bc7e-5077-be42-d26db3941f5a', E'AMO TUAS LEIS', E'(Salmo 119:137-141. Tsadê)

Senhor retos são teus juízos

Os teus testemunhos fiéis

A tua palavra eu afirmo

Que eu amo, é mais doce que o mel
Pequeno eu sou € desprezível

Mas não abro mãos das tuas leis

Pois eu nela achei vida eterna |

e também encontrei O caminho pra o céu.

A tua justiça é eterna, verdade também tua lei
Conceda-me inteligência, por ela então viverei.

(S1.119:161-168. Chim)

Os meus inimigos me querem

Tuas leis guardo em meu coração
Com tua palavra eu folgo

Tesouro que tenho em minhas mãos
Quem ama tua lei não tropeça

Tem paz os que a amam também
Minha alma tem observado

Nela caminhado para sempre amém') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'fd8b145b-bc7e-5077-be42-d26db3941f5a', 328, 159, 159) on conflict (hymnal_id, number) do nothing;
insert into public.hymns (id, title, lyrics) values (E'9ca830ae-299e-5f4e-a400-1a4c9e350be4', E'JESUS ESTÁ AQUI', E'Eu sinto que Jesus Cristo está neste lugar
Também o Espírito Santo e quer nos visitar
E a hora, pode ser agora, abra o coração
Deus paí há de responder nossa oração

O gozo e a alegria que estamos sentindo
Emanam da fonte santa que vem lá do céu
Com fé continue orando, Deus está ouvindo
Não falha e em suas promessas Ele é fiel.

duvidar, Deus está em glória

«o há como em nosso meio, não fique calado

- = Vitória
passando na com fervor por pn

e .
Insista € Espírito Santo e seja ba
ba O

Rect

FIM,

Motçõõs') on conflict (id) do nothing;
insert into public.hymnal_hymns (hymnal_id, hymn_id, number, page_start, page_end) values (E'inspiracoes-9-2019', E'9ca830ae-299e-5f4e-a400-1a4c9e350be4', 329, 159, 160) on conflict (hymnal_id, number) do nothing;

-- Letra transcrita e conferida visualmente no PDF.
update public.hymns set title = E'I CORINTIOS 13', lyrics = E'Ainda que eu falasse a língua dos homens e dos anjos também
Ainda que eu profetizasse e conhecesse a ciência e os mistérios também
Ainda que eu tivesse tal fé de maneira que os montes pudessem transportar
Ainda que eu desse meu corpo para ser queimado até se acabar
Seria tudo inútil, sem nenhum valor, se acima de tudo não tivesse amor.

Amor na vida do crente é a pura semente recebida dos céus
Amor é o dom soberano que o Espírito Santo concede ao fiel
O amor está acima de tudo, ele muda o mundo e o homem tão pecador.
O amor é a grande virtude em um homem tão rude, mas que tem amor.

Quem ama espera bastante, espera confiante e sofre sem reclamar
Que ama não se ensoberbece e nem com indecência é o seu caminhar
Que ama não usa de inveja, nem leviandade, nem pode se irritar
Que ama só diz a verdade e o seu interesse não está em primeiro lugar.', reviewed_at = now(), review_status = 'published' where id = E'e2de0d3d-bafc-5d45-84be-942ad521c5a6' and review_status = 'draft';

-- Letra transcrita e conferida visualmente no PDF.
update public.hymns set title = E'AO SALVADOR AMADO', lyrics = E'Ao Salvador Amado louvores entoarei
A sua majestade eu sempre honrarei
Não tenho outro motivo que me inspira cantar
O seu amor infindo pra mim é singular

Eu quero na minha vida honrar servir a Jesus
No meu falar, no meu andar, levar aos outros luz
No meu comportamento por onde eu passar
Que eu possa a todo momento o seu santo nome honrar

Eu te agradeço, ó Cristo, a minha transformação
A nova vida que vivo, a paz no coração
Eu quero ao mundo perdido do seu amor falar
O céu está garantido a Cristo quem aceitar', reviewed_at = now(), review_status = 'published' where id = E'5f05ef69-2f80-5303-a5be-aa30c7d3f846' and review_status = 'draft';

-- Letra transcrita e conferida visualmente no PDF.
update public.hymns set title = E'AO SENHOR O DOMÍNIO', lyrics = E'Ao Senhor o domínio
Ao Senhor seja a glória para sempre
Seja a Ele meu louvor
Minha vida tudo que preciso
Só dependo de ti

Quero dar-te, ó Deus
Sempre meu louvor
E viver a minha vida te servindo
E aos homens vou do seu amor falar
E sempre quero mais de ti. (3 vezes)', reviewed_at = now(), review_status = 'published' where id = E'b600850f-a101-5e80-a22c-2eca0c2db83e' and review_status = 'draft';

-- Letra transcrita e conferida visualmente no PDF.
update public.hymns set title = E'A DEUS TODA GLÓRIA', lyrics = E'A Deus toda glória
A Ele seja o louvor
Criou a mais linda história
Que eleva a alma
Que enche de amor
Sou feliz, alegre e vivo contente
Minha vida Jesus transformou
Tenho paz sei que sou diferente
Habita agora em mim o Senhor
Gente, escuta a voz de Cristo
Não sofra mais porque não há razão
Olhe, escute e acredite nisso
Só Jesus é a solução.', reviewed_at = now(), review_status = 'published' where id = E'16674fcf-1f77-5529-8582-234de6036e00' and review_status = 'draft';

-- Letra transcrita e conferida visualmente no PDF.
update public.hymns set title = E'A VISÃO DO PROFETA EZEQUIEL', lyrics = E'Como um furacão que do norte surgiu
Vi a glória de Deus e no solo caí
Entre nuvens de fogo eis que surge em fulgor
Quatro seres viventes cheios de esplendor

Filho do homem, põe-te em pé
Esta era a ordem da voz que ouvi
Entre sarças e espinhos e entre escorpiões
Falarás porque eu te envio
E quer ouçam ou deixem de ouvir
Eis que entra em ti o meu espírito
Profetiza o que há de vir.

Quatro rodas surgiram nesta minha visão
Como brilha o berilo tal a sua feição
Cheias eram de olhos, era o seu parecer
Sem virar quando olhavam tudo podiam ver

Semelhante a um homem como fogo eu vi
Assentado num trono de uma glória sem fim
Era a glória de Deus, poderoso Senhor
E caído ouvi o que a voz me falou.', reviewed_at = now(), review_status = 'published' where id = E'87040753-badf-5a14-aa4f-1e5ef93ae5dc' and review_status = 'draft';

-- Letra transcrita e conferida visualmente no PDF.
update public.hymns set title = E'COM CRISTO VOU', lyrics = E'Com Cristo vou seguro na marcha pra Sião
Na luta contra o mundo vou vencendo a tentação
Orando e vigiando, andando com temor
Em tudo obedecendo, servindo ao Senhor

Com Cristo vou (alcançar)
Vitória (sei que virá)
E quero me consagrar para o servir
E nada vai (separar)
Se nele confiar
Servindo a Cristo, chorando ou sorrindo
Pra Ele vou trabalhar

A minha juventude está nas mãos de Deus
A Ele eu dedico a força que me deu
Honrando-o em minha vida, a mim Ele escolheu
Sou jovem para Cristo, pra glória de Deus.', reviewed_at = now(), review_status = 'published' where id = E'40ce07e7-83a7-5559-9a99-e3dbb9091f6a' and review_status = 'draft';

-- Letra transcrita e conferida visualmente no PDF.
update public.hymns set title = E'MEU AMADO DEUS', lyrics = E'Cantarei ao meu amado Deus
Louvarei teu nome, ó Senhor
Não demorarei em ti buscar
Sei que tens prazer em me abençoar
Já te entreguei o meu coração
Quero ter contigo mais comunhão
Te ofereço, ó Deus, este meu louvor
Como gratidão pelo teu amor

Vem Senhor, meu coração aberto está
Quero mais de ti, quero te buscar
Te obedecer é o meu prazer
Te servir melhor enquanto viver
Dá-me mais poder e receba meu louvor.', reviewed_at = now(), review_status = 'published' where id = E'1ccb2cd5-b27d-5c90-b5da-b4a8ad832615' and review_status = 'draft';

-- Letra transcrita e conferida visualmente no PDF.
update public.hymns set title = E'COM CRISTO COMIGO', lyrics = E'Com Cristo comigo nada temerei
Meu forte abrigo, não recearei
E Cristo comigo eu forte serei
Me sinto seguro, vencedor serei

E quando o perigo me sobrevier
Então Jesus Cristo sustém minha fé
Sinto-me seguro não tenho temor
Pois ele comigo eu sou vencedor

E quando Jesus nas nuvens voltar
Então para sempre irei descansar
E nenhum perigo e tribulação
É o fim da tristeza, nossa redenção.', reviewed_at = now(), review_status = 'published' where id = E'4a0e149f-c359-5edd-bda5-a03df437fd30' and review_status = 'draft';

-- Letra transcrita e conferida visualmente no PDF.
update public.hymns set title = E'CRISTO É REAL', lyrics = E'Cristo é real, Ele vive em mim
Oh! Eu canto sempre assim
O seu amor inundou meu ser
Não há razão para tristeza
Não há razão para ser infeliz

Aleluia cantarei (aleluia eu cantarei)
Grande foi o seu amor
Cristo Jesus, eu te amo
Pois por mim sofreste tanto
Ao teu nome sempre, sempre honrarei.', reviewed_at = now(), review_status = 'published' where id = E'b2a8493a-da85-570a-9af4-833473b21fc1' and review_status = 'draft';

-- Letra transcrita e conferida visualmente no PDF.
update public.hymns set title = E'CRISTO ME FAZ DESCANSAR', lyrics = E'Com Cristo comigo não hei de temer
A sua presença me faz descansar
Me inspira, me ajuda, me faz reviver
Com Cristo comigo eu vou caminhar

É tão gloriosa e sem comparação
A tua presença no meu coração
Me torna alegre, me enche de luz
A tua presença, querido Jesus', reviewed_at = now(), review_status = 'published' where id = E'7207d1f7-a2c8-54bf-a852-1beb91002fb6' and review_status = 'draft';

update public.hymnals set published = true where id = E'inspiracoes-9-2019';
commit;

-- Resultado esperado em banco vazio: 325 vínculos, 10 publicados, 315 rascunhos.
select h.title, h.published, v.review_status, count(*) as quantidade
from public.hymnals h join public.hymnal_hymns hh on hh.hymnal_id = h.id
join public.hymns v on v.id = hh.hymn_id
where h.id = E'inspiracoes-9-2019' group by h.id, h.title, h.published, v.review_status;
