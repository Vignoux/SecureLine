select id,
'<div class="card text-white '||DECODE(SEVERIDADE,1,'bg-danger',DECODE(SEVERIDADE,2,'bg-warning','bg-info'))||'">
            <div class="card-body">
                <h5 class="card-title">'||upper(categoria)||'</h5>
                <div class="row">
                    <div class="col-md-6">
                        <img src="img\alerta\'||ID||'.jpg" class="img-fluid" alt="Imagem 2">
                    </div>
                    <div class="col-md-6">
                        <p class="card-text text-sm">
							<font size =2>
								De:'||nome||'<BR>Alerta:'||DESCRICAO||'
							</font>
						</p>
					</div>
				</div>
				<div class="col-md-6">
					<div class="d-flex">
						<button class="btn btn-link text-white background-color: #03A9F4;">
							<i class="fas fa-thumbs-up"></i> '||aprovado||'
						</button>
						<button class="btn btn-link text-white background-color: #03A9F4;">
							<i class="fas fa-thumbs-down"></i>'||reprovado||'
						</button>
						<strong style="margin-left: 150px; font-size:10px"> Qtd:'||qtd_alerta||'</font></strong>
					</div>
				</div>
			</div>
        </div>
        &nbsp'
from(
    select a.categoria
         , A.ID
         , descri.nome
         , descri.descricao
         , a.data
         , a.ranking
         , DESCRI.SEVERIDADE
         , count(ale2.id)qtd_alerta
         , a.aprovado
         , a.reprovado
      from 
         tb_alertas ale2
        , (select b.descricao, id_categoria, e.nome, B.SEVERIDADE
             from tb_alertas b,
                  tb_usuarios e,
                 (select  min(c.id) id
                   from tb_alertas c
                   group by c.id_categoria)d
           where b.id = d.id
             and b.id_usuario = e.id) descri 
        ,( Select  cat.id 
                 , cat.categoria
                 , ale.data+1 data
                 , nvl(sum(ava.aprovado)- sum(ava.reprovado),0) ranking
                 , sum(nvl(ava.aprovado,0))aprovado
                 , sum(nvl(ava.reprovado,0))reprovado
              from tb_alertas ale
               ,   tb_categorias cat
               ,   tb_avaliacoes ava 
             where ale.id_categoria = cat.id 
               and ale.id_categoria = ava.id_alerta(+)
             group by cat.id
                 , ale.data+1
                 ,cat.categoria) a
         where a.id = ale2.id_categoria
           and ale2.id_categoria = descri.id_categoria
           and a.data+1 >= sysdate 
         group by a.categoria
         , a.data
         , a.ranking
         , descri.descricao 
         , descri.nome
         , A.ID
         , DESCRI.SEVERIDADE
         , a.aprovado
         , a.reprovado)
order by ranking desc;
         