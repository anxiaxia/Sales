<?php

class RankForm extends CFormModel
{
	public $id;
	public $season;
	public $city;
	public $date;
	public $visit=array();
    public $ia=array();
    public $pyx=array();
    public $cp=array();
    public $jq=array();
    public $lhcity=array();
    public $lhsum=array();
    public $lhmoney=array();
    public $sales=array();
    public $food=array();
    public $fjl;
    public $now_all;
    public $now;
    public $rank;
    public $rank_name;


	
	public function attributeLabels()
	{
		return array(
            'sale_day'=>Yii::t('code','Sale_day'),
            'employee_name'=>Yii::t('sales','Employee_name'),
		);
	}

	public function rules()
	{
        return array(
            array('','required'),
            array('id,sale_day,','safe'),
        );
	}

    public function init() {
        $this->city =Yii::app()->user->city();
        $this->season="";
//        $this->month=date("m");
//        $this->year=date("Y");
//        $this->staffs_desc = Yii::t('misc','All');
    }


	public function retrieveData($index)
	{
		$suffix = Yii::app()->params['envSuffix'];
        $sql="select * from sales$suffix.sal_rank where id='$index'";
		$rows = Yii::app()->db->createCommand($sql)->queryRow();
        $city = Yii::app()->user->city();
        $cityname=$this->cityname($city);
        $year = date("Y", strtotime($rows['month']));//当前赛季时间年
        $month = date("m", strtotime($rows['month']));//当前赛季时间月
        $star_time=date("Y-m-01", strtotime($rows['month']));//当前赛季開始时间
        $end_time=date("Y-m-31", strtotime($rows['month']));//当前赛季結束时间
        //上赛季分数
        $this->rank=$rows['rank'];
        // 銷售每月签单得分
        //IAIB
        $sql_ia="select a.* from swoper$suffix.swo_service a
                  left outer join  hr$suffix.hr_employee b on  concat(b.name, ' (', b.code, ')')=a.salesman
                  left outer join  hr$suffix.hr_binding c on  c.employee_id=b.id
                  where a.status_dt>='$star_time' and a.status_dt<='$end_time' and a.status='N' and (a.cust_type='1' or a.cust_type='2') and c.user_id='".$rows['username']."' and a.city='$city'
                  ";
        $rows_ia = Yii::app()->db->createCommand($sql_ia)->queryAll();
        $ia=0;
        foreach ($rows_ia as $row){
            if($row['paid_type']=='M'){
                $amt_paid_year_a=$row['amt_paid']*$row['ctrt_period'];
            }elseif ($row['paid_type']=='Y'){
                $amt_paid_year_a= $row['amt_paid'];
            }else{
                $amt_paid_year_a=  $row['amt_paid'];
            }
            $ia+=$amt_paid_year_a;
        }
        $ia_A=count($rows);
        $amount_ia=$this->getAmount('1',$star_time,$ia);//本单产品提成比例
        $score_ia= $ia * $amount_ia['coefficient'] * (1+0.01*($ia_A-1));
        $this->ia['sum']=$ia_A;
        $this->ia['money']=$ia;
        $this->ia['score']=round($score_ia,2);
        //飘盈香
        $sql_pyx="select a.* from swoper$suffix.swo_service a
                  left outer join  hr$suffix.hr_employee b on  concat(b.name, ' (', b.code, ')')=a.salesman
                 left outer join  hr$suffix.hr_binding c on  c.employee_id=b.id
                  where a.status_dt>='$star_time' and a.status_dt<='$end_time' and a.status='N' and (a.cust_type='5' or a.cust_type_name='24') and c.user_id='".$rows['username']."' and a.city='$city'
                  ";
        $rows_pyx = Yii::app()->db->createCommand($sql_pyx)->queryAll();
        $pyx=0;
        foreach ($rows_pyx as $row_pyx){
            if($row_pyx['paid_type']=='M'){
                $amt_paid_year_a=$row_pyx['amt_paid']*$row_pyx['ctrt_period'];
            }elseif ($row_pyx['paid_type']=='Y'){
                $amt_paid_year_a= $row_pyx['amt_paid'];
            }else{
                $amt_paid_year_a=$row_pyx['amt_paid'];
            }
            $pyx+=$amt_paid_year_a;

        }
        $pyx_A=count($rows_pyx);
        $amount_ia=$this->getAmount('2',$star_time,$pyx);//本单产品提成比例
        $score_pyx= $pyx * $amount_ia['coefficient'] * (1+0.02*($pyx_A-1));
        $this->pyx['sum']=$pyx_A;
        $this->pyx['money']=$pyx;
        $this->pyx['score']=round($score_pyx,2);
        //产品
        $sql_cp = "select b.log_dt,b.company_name,a.money,a.qty,c.description,c.sales_products,c.id from swoper$suffix.swo_logistic_dtl a
                left outer join swoper$suffix.swo_logistic b on b.id=a.log_id		
               	left outer join swoper$suffix.swo_task c on a.task=c.	id
               	  left outer join  hr$suffix.hr_employee d on  concat(d.name, ' (', d.code, ')')=b.salesman
                  left outer join  hr$suffix.hr_binding e on  e.employee_id=d.id
                where b.log_dt<='$end_time' and  b.log_dt>='$star_time' and e.user_id='".$rows['username']."' and b.city ='$city' and a.money>0  and c.sales_products!='chemical'";
        $rows_cp = Yii::app()->db->createCommand($sql_cp)->queryAll();
        $cp=0;
        foreach ($rows_cp as $row_cp){
            $cp+=$row_cp['money']*$row_cp['qty'];
        }
        $cp_A=count($rows_cp);
        $amount_cp=$this->getAmount('3',$star_time,$cp);//本单产品提成比例
        $score_cp=$cp * $amount_cp['coefficient'] * (1+0.005*(($cp_A)-1));
        $this->cp['sum']=$cp_A;
        $this->cp['money']=$cp;
        $this->cp['score']=round($score_cp,2);
        //洗涤易
        $sql_xdy = "select b.log_dt,b.company_name,a.money,a.qty,c.description,c.sales_products,c.id from swoper$suffix.swo_logistic_dtl a
                left outer join swoper$suffix.swo_logistic b on b.id=a.log_id		
               	left outer join swoper$suffix.swo_task c on a.task=c.	id
               	  left outer join  hr$suffix.hr_employee d on  concat(d.name, ' (', d.code, ')')=b.salesman
                  left outer join  hr$suffix.hr_binding e on  e.employee_id=d.id
                where b.log_dt<='$end_time' and  b.log_dt>='$star_time' and e.user_id='".$rows['username']."' and b.city ='$city' and a.money>0  and c.sales_products='chemical'";
        $rows_xdy = Yii::app()->db->createCommand($sql_xdy)->queryAll();
        $xdy=0;
        foreach ($rows_xdy as $row_xdy){
            $xdy+=$row_xdy['money']*$row_xdy['qty'];
        }
        $xdy_A=count($rows_xdy);
        $amount_xdy=$this->getAmount('4',$star_time,$xdy);//本单产品提成比例
        $score_xdy=$xdy * $amount_xdy['coefficient'] * (1+0.02*(($xdy_A)-1));
        //甲醛
        $sql_jq="select a.* from swoper$suffix.swo_service a
                  left outer join  hr$suffix.hr_employee b on  concat(b.name, ' (', b.code, ')')=a.salesman
                 left outer join  hr$suffix.hr_binding c on  c.employee_id=b.id
                  where a.status_dt>='$star_time' and a.status_dt<='$end_time' and a.status='N' and (a.cust_type='6' or a.cust_type_name='28') and c.user_id='".$rows['username']."' and a.city='$city'
                  ";
        $rows_jq = Yii::app()->db->createCommand($sql_jq)->queryAll();
        $jq=0;
        foreach ($rows_jq as $row_jq){
            if($row_jq['paid_type']=='M'){
                $amt_paid_year_a=$row_jq['amt_paid']*$row_jq['ctrt_period'];
            }elseif ($row_jq['paid_type']=='Y'){
                $amt_paid_year_a= $row_jq['amt_paid'];
            }else{
                $amt_paid_year_a=$row_jq['amt_paid'];
            }
            $jq+=$amt_paid_year_a;

        }
        $jq_A=count($rows_jq);
        $amount_jq=$this->getAmount('4',$star_time,$jq);//本单产品提成比例
        $score_jq= $jq * $amount_jq['coefficient'] * (1+0.02*($jq_A-1));
        $this->jq['sum']=$jq_A+$xdy_A;
        $this->jq['money']=$jq+$xdy;
        $this->jq['score']=round($score_jq+$score_xdy,2);
        //每月销售龙虎榜城市人均签单量排名
        $sales=ReportRankinglistForm::salelist($star_time,$end_time);
        $sales_copy=$sales;
        foreach ($sales as $k=>$v){
            if($v['city']==$cityname){
                $this->lhcity['sum']=$k+1;
            }
        }
        if(empty($this->lhcity['sum'])){
            $this->lhcity['sum']='无';
        }
        $sales_one=array_pop($sales_copy);
        $sales_two=array_pop($sales_copy);
        $score_sales_one=$sales_one['city']==$cityname?-3000:0;
        $score_sales_two=$sales_two['city']==$cityname?-2000:0;
        $this->lhcity['score']=$score_sales_one+$score_sales_two;
        //每月销售龙虎榜城市人均签单金额排名
        $salemoney=ReportRankinglistForm::salelists($star_time,$end_time);
        $salemoney_copy=$salemoney;
        foreach ($salemoney as $k=>$v){
            if($v['city']==$cityname){
                $this->lhsum['sum']=$k+1;
            }
        }
        if(empty($this->lhsum['sum'])){
            $this->lhsum['sum']='无';
        }
        $salemoney_one=array_pop($salemoney_copy);
        $salemoney_two=array_pop($salemoney_copy);
        $score_salemoney_one=$salemoney_one['city']==$cityname?-3000:0;
        $score_salemoney_two=$salemoney_two['city']==$cityname?-2000:0;
        $this->lhsum['score']=$score_salemoney_one+$score_salemoney_two;
        //每月销售龙虎榜销售排名
        $salepeople=ReportRankinglistForm::salepeople($star_time,$end_time);
        foreach ($salepeople as $k=>$v){
            if($v['user']==$rows['username']){
                $this->lhmoney['sum']=$k+1;
            }
        }
        if(empty($this->lhmoney['sum'])){
            $this->lhmoney['sum']='无';
        }
        if(!empty($salepeople)){
            for ($a=0;$a<count($salepeople);$a++){
                if($a==0&&$salepeople[$a]['user']==$rows['username']){
                    $salepeople_money=5000;
                }elseif ($a==1&&$salepeople[$a]['user']==$rows['username']){
                    $salepeople_money=3000;
                }elseif ($a==2&&$salepeople[$a]['user']==$rows['username']){
                    $salepeople_money=1500;
                }elseif ($a>2&&$a<10&&$salepeople[$a]['user']==$rows['username']){
                    $salepeople_money=500;
                }elseif ($a>=10&&$a<15&&$salepeople[$a]['user']==$rows['username']){
                    $salepeople_money=300;
                }elseif ($a>=15&&$a<20&&$salepeople[$a]['user']==$rows['username']){
                    $salepeople_money=100;
                }elseif ($a>=15&&$a<20&&$salepeople[$a]['user']==$rows['username']){
                    $salepeople_money=100;
                }elseif ($a>=(count($salepeople)-10)&&$a<count($salepeople)&&$salepeople[$a]['user']==$rows['username']){
                    $salepeople_money=-500;
                }else{
                    $salepeople_money=0;
                }
            }
        }else{
            $salepeople_money=0;
        }
        $this->lhmoney['score']=$salepeople_money;
        //五部曲分数
        $sql_entry="select entry_time from hr$suffix.hr_employee a
                    left outer join hr$suffix.hr_binding b  on a.id=b.employee_id 
                    where b.user_id= '".$rows['username']."'
                    ";
        $entry_time= Yii::app()->db->createCommand($sql_entry)->queryScalar();
        $five_time1 = date("m-d", strtotime($entry_time));//計算分數时间月
        $five_time2 = date("m-d", strtotime("$entry_time +6 month" ));//計算分數时间月
        $five_time1=$year."-".$five_time1;
        $five_time2=$year."-".$five_time2;
        if($month==date("m", strtotime($five_time1))){
            //洗手間分數
            $score_xsj=$this->getFive($five_time1,$rows['username'],1);
            //滅蟲分數
            $score_mc=$this->getFive($five_time1,$rows['username'],0);
            //第三部曲分數
            $five_time_end = date("m-d", strtotime("$five_time1 +15 day" ));
            $sql_five="select * from sal_fivestep where username='".$rows['username']."' and rec_dt>=$five_time1 and rec_dt<=$five_time_end and five_type='2'";
            $retern= Yii::app()->db->createCommand($sql_five)->queryAll();
            if(empty($retern)){
                $score_3bq=0;
            }else{
                $score_3bq=1500;
            }
            $score_five=$score_xsj+$score_mc+$score_3bq;
        }elseif($month==date("m", strtotime($five_time2))){
            //洗手間分數
            $score_xsj=$this->getFive($five_time1,$rows['username'],1);
            //滅蟲分數
            $score_mc=$this->getFive($five_time1,$rows['username'],0);
            //第三部曲分數
            $five_time_end = date("m-d", strtotime("$five_time1 +15 day" ));
            $sql_five="select * from sal_fivestep where username='".$rows['username']."' and rec_dt>=$five_time1 and rec_dt<=$five_time_end and five_type='2'";
            $retern= Yii::app()->db->createCommand($sql_five)->queryAll();
            if(empty($retern)){
                $score_3bq=0;
            }else{
                $score_3bq=1500;
            }
            $score_five=$score_xsj+$score_mc+$score_3bq;
        }else{
            $score_five=0;
        }
        //总分数
        $score_all=$score_ia+$score_pyx+$score_cp+$score_xdy+$score_jq+$score_sales_one+$score_sales_two+$score_salemoney_one+$score_salemoney_two+$salepeople_money+$score_five;
        $this->now=round($score_all,2);
        //销售每月平均每天拜访记录  比例
        $sql_visit="select count(id) as sums from sal_visit where username='".$rows['username']."' and visit_dt>='$star_time'  and visit_dt<='$end_time'";
        $visit= Yii::app()->db->createCommand($sql_visit)->queryScalar();
        $sql_day="select sale_day from sal_integral  where username='".$rows['username']."' and year='$year' and month='$month'";
        $day= Yii::app()->db->createCommand($sql_day)->queryScalar();
        $sales_visit=$visit/$day;
        $amount_visit=$this->getAmount('5',$star_time,$sales_visit);//本单产品提成比例
        $score_all=($score_all+$amount_visit['bonus'])*$amount_visit['coefficient'];
        $this->visit['sum']=round($sales_visit,0);
        $this->visit['score']=$amount_visit['bonus'];
        $this->visit['coefficient']=round($amount_visit['coefficient'],2);;
//        print_r($sales_visit);exit();

        //地方销售人员/整体区比例
        $sql_sales = "select count(a.username)	
				from security$suffix.sec_user a 
				left outer join security$suffix.sec_city b on a.city=b.code 			  
				left outer join security$suffix.sec_user_access c on a.username=c.username 			
				where a.city='$city'  and c.system_id='sal'  and c.a_read_write like '%HK01%'  and a.status='A'
			";
        $sales_people= Yii::app()->db->createCommand($sql_sales)->queryScalar();
        $sql_city="select count(id) from sales$suffix.sal_cust_district where city='$city'";
        $sales_city= Yii::app()->db->createCommand($sql_city)->queryScalar();
        $people=$sales_people/$sales_city;
        $this->sales['sum']=round($people,2);
        if($people<0.25){
            $score_all=$score_all*0.4;
            $this->sales['score']=0.4;
        }elseif ($people>=0.25&&$people<0.5){
            $score_all=$score_all*0.7;
            $this->sales['score']=0.7;
        }elseif ($people>=0.5&&$people<0.75){
            $score_all=$score_all*1;
            $this->sales['score']=1;
        }elseif ($people>=0.75&&$people<1){
            $score_all=$score_all*1.1;
            $this->sales['score']=1.1;
        }

        //销售组别类型（餐饮组/商业组）
        $sql_food="select a.group_type from hr$suffix.hr_employee a
                   left outer join hr$suffix.hr_binding b  on a.id=b.employee_id
                   where b.user_id='".$rows['username']."'  and a.city='$city'
                 ";
        $food= Yii::app()->db->createCommand($sql_food)->queryScalar();
        if($food==0||$food==2){
            $score_all=$score_all*1;//餐饮组（或没分）
            $this->food['name']='餐饮组（或没分）';
            $this->food['score']=1;
        }else{
            $score_all=$score_all*1.3;
            $this->food['name']='商业组';
            $this->food['score']=1.3;
        }
        //销售岗位级别
        $sql_jl="select * from hr$suffix.hr_employee a
                 left outer join hr$suffix.hr_binding b  on a.id=b.employee_id
                 left outer join hr$suffix.hr_dept c  on a.position=c.id
                 where b.user_id='".$rows['username']."'  and a.city='$city' and c.dept_class='Sales' and c.name like '%经理%'
                 ";
        $jl= Yii::app()->db->createCommand($sql_jl)->queryAll();
        $sql_fjl="select * from hr$suffix.hr_employee a
                 left outer join hr$suffix.hr_binding b  on a.id=b.employee_id
                 left outer join hr$suffix.hr_dept c  on a.position=c.id
                 where b.user_id='".$rows['username']."'  and a.city='$city' and c.dept_class='Sales' and c.name not like '%经理%'
                 ";
        $fjl= Yii::app()->db->createCommand($sql_fjl)->queryAll();
        if(!empty($jl)){
            $score_all=$score_all*0.8;
            $this->fjl=0.8;
        }elseif (!empty($fjl)){
            $score_all=$score_all*1.2;
            $this->fjl=1.2;
        }else{
            $score_all=$score_all*1.2;
            $this->fjl=1.2;
        }
        //当前赛季总分（继承后）
        $this->now_all=round($score_all+$this->rank,2);
        //上赛季段位
        $sql_rank_name="select * from sal_level where start_fraction <='".$this->now_all."' and end_fraction >='".$this->now_all."'";
        $rank_name= Yii::app()->db->createCommand($sql_rank_name)->queryRow();
        $this->rank_name=$rank_name['level'];
		return true;
	}

    public function getFive($five_time1,$username,$five_type){//獲得五部曲分數
        $five_time_end = date("m-d", strtotime("$five_time1 +3 day" ));
        $sql_five="select * from sal_fivestep where username='".$username."' and rec_dt>=$five_time1 and rec_dt<=$five_time_end and five_type='$five_type'";
        $retern= Yii::app()->db->createCommand($sql_five)->queryAll();
        if(!empty($retern)){
            $score_five_xishouj=1500;
        }else{
            $five_time_end = date("m-d", strtotime("$five_time1 +7 day" ));
            $sql_five="select * from sal_fivestep where username='".$username."' and rec_dt>=$five_time1 and rec_dt<=$five_time_end and five_type='$five_type'";
            $retern= Yii::app()->db->createCommand($sql_five)->queryAll();
            if(!empty($retern)){
                $score_five_xishouj=1000;
            }else{
                $five_time_end = date("m-d", strtotime("$five_time1 +30 day" ));
                $sql_five="select * from sal_fivestep where username='".$username."' and rec_dt>=$five_time1 and rec_dt<=$five_time_end and five_type='$five_type'";
                $retern= Yii::app()->db->createCommand($sql_five)->queryAll();
                if(!empty($retern)){
                    $score_five_xishouj=500;
                }else{
                    $score_five_xishouj=0;
                }
            }
        }
        return $score_five_xishouj;
    }

    public  function getAmount( $cust_type, $start_dt, $sales_amt) {
        //城市，类别，时间，总金额
        $rtn = array();

        if (isset($cust_type) && !empty($start_dt) && isset($sales_amt)) {
            $suffix = Yii::app()->params['envSuffix'];
            //客户类别
            //  $sql = "select rpt_cat from swoper$suffix.swo_customer_type where id=$cust_type";
            //   $row = Yii::app()->db->createCommand($sql)->queryRow();
            //   if ($row!==false) {
            //  $type = $row['rpt_cat'];
            $sdate = General::toMyDate($start_dt);
            $sql = "select id from sal_coefficient_hdr where  start_dt<'$sdate'   order by start_dt desc limit 1";
            $row = Yii::app()->db->createCommand($sql)->queryRow();
            if ($row!==false) {
                $id = $row['id'];
                $sql = "select * from sal_coefficient_dtl
                        where hdr_id='$id' and name='$cust_type' and ((criterion>=$sales_amt and operator='LE')
                        or (criterion<$sales_amt and operator='GT'))
                        order by criterion limit 1
                    ";
                $row = Yii::app()->db->createCommand($sql)->queryRow();
                if ($row!==false) {
                    $rtn['bonus'] =$row['bonus'];
                    $rtn['coefficient'] =$row['coefficient'];
            }
            }
        }
        // }
//        print_r('<pre>');
//        print_r($rtn);exit();
        return $rtn;
    }

	public function saveData()
	{
		$connection = Yii::app()->db;
		$transaction=$connection->beginTransaction();
		try {
			$this->saveTrans($connection);
			$transaction->commit();
		}
		catch(Exception $e) {
			$transaction->rollback();
			throw new CHttpException(404,'Cannot update.'.$e->getMessage());
		}
	}

	
	protected function saveTrans(&$connection) {
		$sql = '';
		switch ($this->scenario) {
//			case 'delete':
//				$sql = "update sal_integral set
//						sal_day = :sal_day,
//						luu = :luu
//						where id = :id and city = :city
//					";
//				break;
//			case 'new':
//				$sql = "insert into acc_trans(
//						trans_dt, trans_type_code, acct_id,	trans_desc, amount,	status, city, luu, lcu) values (
//						:trans_dt, :trans_type_code, :acct_id, :trans_desc, :amount, 'A', :city, :luu, :lcu)";
//				break;
			case 'edit':
				$sql = "update sal_integral set 
						sale_day = :sale_day	  				  
						where id = :id 
					";
				break;
		}

		$command=$connection->createCommand($sql);
		if (strpos($sql,':id')!==false)
			$command->bindParam(':id',$this->id,PDO::PARAM_INT);
		if (strpos($sql,':sale_day')!==false)
			$command->bindParam(':sale_day',$this->sale_day,PDO::PARAM_INT);
		$command->execute();
		return true;
	}

	public function cityName($city){
        $suffix = Yii::app()->params['envSuffix'];
	    $sql="select name from security$suffix.sec_city  where code='$city'";
	    $name=Yii::app()->db->createCommand($sql)->queryScalar();
	    return $name;
    }

    public function city(){
        $suffix = Yii::app()->params['envSuffix'];
        $model = new City();
        $city=Yii::app()->user->city();
        $records=$model->getDescendant($city);
        array_unshift($records,$city);
        $cityname=array();
        foreach ($records as $k) {
            $sql = "select name from security$suffix.sec_city where code='" . $k . "'";
            $name = Yii::app()->db->createCommand($sql)->queryAll();
            $cityname[]=$name[0]['name'];
        }
        $city=array_combine($records,$cityname);
        return $city;
    }

    public function season(){
        $sql = "select season from sal_rank group by season";
        $row= Yii::app()->db->createCommand($sql)->queryAll();
        $season=array();
        foreach ($row as $a){
            $season[$a['season']]='第'.$this->numToWord($a['season']).'赛季';
        }
        return $season;
    }

    public function numToWord($num)
    {
        $chiNum = array('零', '一', '二', '三', '四', '五', '六', '七', '八', '九');
        $chiUni = array('','十', '百', '千', '万', '亿', '十', '百', '千');
        $chiStr = '';
        $num_str = (string)$num;
        $count = strlen($num_str);
        $last_flag = true; //上一个 是否为0
        $zero_flag = true; //是否第一个
        $temp_num = null; //临时数字
        $chiStr = '';//拼接结果
        if ($count == 2) {//两位数
            $temp_num = $num_str[0];
            $chiStr = $temp_num == 1 ? $chiUni[1] : $chiNum[$temp_num].$chiUni[1];
            $temp_num = $num_str[1];
            $chiStr .= $temp_num == 0 ? '' : $chiNum[$temp_num];
        }else if($count > 2){
            $index = 0;
            for ($i=$count-1; $i >= 0 ; $i--) {
                $temp_num = $num_str[$i];
                if ($temp_num == 0) {
                    if (!$zero_flag && !$last_flag ) {
                        $chiStr = $chiNum[$temp_num]. $chiStr;
                        $last_flag = true;
                    }
                }else{
                    $chiStr = $chiNum[$temp_num].$chiUni[$index%9] .$chiStr;
                    $zero_flag = false;
                    $last_flag = false;
                }
                $index ++;
            }
        }else{
            $chiStr = $chiNum[$num_str[0]];
        }
        return $chiStr;
    }


	public function adjustRight() {
		return Yii::app()->user->validFunction('HD01');
	}
	
	public function voidRight() {
		return Yii::app()->user->validFunction('HD01');
	}

	public function isReadOnly() {
//		return ($this->scenario=='view'||$this->status=='V'||$this->posted||!empty($this->req_ref_no)||!empty($this->t3_doc_no));
		return ($this->scenario!='new'||$this->status=='V'||$this->posted||!empty($this->req_ref_no)||!empty($this->t3_doc_no));
	}
}
