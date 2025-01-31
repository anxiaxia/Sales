<div class="box box-primary" >
    <div class="box-header with-border">
        <h3 class="box-title"><?php echo Yii::t('report','Sales ranking');?>(<?php echo Yii::t('report',date('F', strtotime(date('Y-m-01') ))); ?>)</h3>


        <!--            <div class="box-tools pull-right">-->
        <!--                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>-->
        <!--            </div>-->
    </div>
    <!-- /.box-header -->

    <div class="box-body">
        <div id='ranklist' class="direct-chat-messages" style="height: 250px;">
            <div class="overlay">
              <i class="fa fa-refresh fa-spin"></i>
            </div>
        </div>
    </div>
    <!-- /.box-body -->

    <div class="box-footer">
        <small><?php echo Yii::t('report','Refresh data immediately when signing');?></small>
    </div>
    <!-- /.box-footer -->
</div>
<!-- /.box -->

<?php
$link = Yii::app()->createAbsoluteUrl("dashboard/ranklist");
$paiming= Yii::t('report','ranking');
$city= Yii::t('report','city');
$quyu= Yii::t('report','quyu');
$sum= Yii::t('report','name');
$jine= Yii::t('report','level');
$rank= Yii::t('report','rank');
$js = <<<EOF
	$.ajax({
		type: 'GET',
		url: '$link',
		success: function(data) {
			var line = '<table class="table table-bordered small">';
			line += '<tr><td><b>$paiming</b></td><td><b>$jine</b></td><td><b>$sum</b></td><td><b>$rank</b></td><td><b>$city</b></td><td><b>$quyu</b></td></tr>';
			if (data !== undefined && data.length != 0) {
			//console.log(data);
				for (var i=0; i < data.length; i++) {
					line += '<tr>';
					style = '';
					switch(i) {
						case 0: style = 'style="color:#FF0000"'; break;
						case 1: style = 'style="color:#871F78"'; break;
						case 2: style = 'style="color:#0000FF"'; break;
					}
					now_score = i+1;
					style1 = 'style="winth=20px;height=10px"';
					line += '<td '+style+'>'+now_score+'</td><td '+style+'><img src="images/'+data[i].level+'.png" width="20px;">'+data[i].level+'</td><td '+style+'>'+data[i].name+'</td><td '+style+'>'+data[i].rank+'</td><td '+style+'>'+data[i].city+'</td><td '+style+'>'+data[i].quyu+'</td>';
					line += '</tr>';
				}	
				
			}
			line += '</table>';
			$('#ranklist').html(line);
		},
		error: function(xhr, status, error) { // if error occured
			var err = eval("(" + xhr.responseText + ")");
			console.log(err.Message);
		},
		dataType:'json'
	});
EOF;
Yii::app()->clientScript->registerScript('ranklistDisplay',$js,CClientScript::POS_READY);

?>