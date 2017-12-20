<?php

return array(
	'Personal'=>array(
		'access'=>'T',
		'items'=>array(
			'Sales order'=>array(
				'access'=>'T01',
				'url'=>'/sales/index',
			),
			'Sales visit'=>array(
				'access'=>'T02',
				'url'=>'/visit/index',
			),
			'Ciustomer Enqury'=>array(
				'access'=>'T03',
				'url'=>'/enqury/index',
			),
		),
	),
	'Sales Admin'=>array(
		'access'=>'TB',
		'items'=>array(
			'Staff list'=>array(
				'access'=>'TB01',
				'url'=>'/staff/index',
			),
			'Visit list'=>array(
				'access'=>'TB02',
				'url'=>'/visits/index',
			),
			'Ciustomer Enqury list'=>array(
				'access'=>'TB03',
				'url'=>'/ciustomer/index',
			),
		),
	),
);
