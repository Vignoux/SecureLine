select a.*, rownum,qtd,
        ' <div class="card text-white bg-warning">
                <div class="card-body">
                    <h5 class="card-title">'||Nome||'</h5>
                    <img src="img\'||decode(rownum,1,'ouro',decode(rownum,2,'prata','bronze'))||'.jpg" width="50" height="50">
                    <div class="row">                        
                           Com invríveis '||qtd||' Alertas foi o vencedor dos ultimos 30 dias                                                
                    </div>
                </div>	
                <center><img src="img\pub\'||round(DBMS_RANDOM.VALUE(1,5))||'.jpg" width="280" height="280"></center>
            </div>
        ' 
  from
    (select usu.Nome, count(ale.id)qtd 
      from tb_usuarios usu
      ,    tb_alertas ale
     where usu.id = ale.id_usuario
     group by usu.nome
     order by  count(ale.id) desc, usu.nome)a
where rownum <= 3;
