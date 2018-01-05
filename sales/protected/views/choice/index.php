<?php
$this->pageTitle=Yii::app()->name . ' - choice';
?>

<?php $form=$this->beginWidget('TbActiveForm', array(
'id'=>'choice-list',
'enableClientValidation'=>true,
'clientOptions'=>array('validateOnSubmit'=>true,),
'layout'=>TbHtml::FORM_LAYOUT_INLINE,
)); ?>

<section class="content-header">
	<h1>
		<strong><?php echo Yii::t('choice','Choice List'); ?></strong>
	</h1>
<!--
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li><a href="#">Layout</a></li>
		<li class="active">Top Navigation</li>
	</ol>
-->
</section>


<section class="content">
	<div class="box"><div class="box-body">
	<div class="btn-group" role="group">
		<?php 
			if (Yii::app()->user->validRWFunction('T04'))
				echo TbHtml::button('<span class="fa fa-file-o"></span> '.Yii::t('choice','Add Type'), array(
					'submit'=>Yii::app()->createUrl('choice/new'),
				)); 
		?>
	</div>
	</div></div>
	<?php
		$search = array(

					);
		$this->widget('ext.layout.ListPageWidget', array(
			'title'=>Yii::t('choice','Choice List'),
			'model'=>$model,
				'viewhdr'=>'//choice/_listhdr',
				'viewdtl'=>'//choice/_listdtl',
				'gridsize'=>'24',
				'height'=>'600',
				'search'=>$search,
		));
	?>
</section>
<?php $this->endWidget(); ?>

<?php
	$js = Script::genTableRowClick();
	Yii::app()->clientScript->registerScript('rowClick',$js,CClientScript::POS_READY);
?>

