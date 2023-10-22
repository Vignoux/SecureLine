select 
'<h5><center><B>ALERTAS DE INUNDAÇÃO</B></center><h5>
		 <div class="card text-white '||DECODE(SEVERIDADE,1,'bg-danger',DECODE(SEVERIDADE,2,'bg-warning','bg-info'))||'">
            <div class="card-body">
                <h5 class="card-title">'||upper(nome)||'</h5>
                <H6>'||'('||substr(celular,1,2)||')'||substr(celular,3,5)||'-'||substr(celular,8,4)||'</H6>
                <div class="row">
                    <div>
                        <img src="img\alertas\'||ALE.ID||'.jpg" class="img-fluid">
                    </div>
                    <div>
                        <p class="card-text text-sm">
							<font size =2>
								DATA:'||TO_CHAR(DATA,'DD/MM/YYYY HH24:MI:SS') ||'<BR> lOCALIDADE: '||LOCALIDADE ||'<BR>Alerta:'||DESCRICAO||'
							</font>
						</p>
					</div>
				</div>				
			</div>
        </div>'
from tb_alertas ale
,    tb_usuarios usu
where ale.id_usuario = usu.id
  and id_categoria = 10
  and ale.data+1 >= sysdate;
  