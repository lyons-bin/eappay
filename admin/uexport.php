<?php
include("../includes/common.php");
$title='导出用户';
include './head.php';
if($islogin==1){}else exit("<script language='javascript'>window.location.href='./login.php';</script>");

$select = '<option value="">全部用户组</option>';
$rs = $DB->getAll("SELECT * FROM pre_group");
foreach($rs as $row){
	$select .= '<option value="'.$row['gid'].'">'.$row['name'].'</option>';
}
unset($rs);
?>
<link href="../assets/css/datepicker.css" rel="stylesheet">
  <div class="container" style="padding-top:70px;">
    <div class="col-xs-12 col-sm-10 col-lg-8 center-block" style="float: none;">
<div class="panel panel-primary">
<div class="panel-heading"><h3 class="panel-title">导出用户</h3></div>
<div class="panel-body">
		<form action="" method="POST" onsubmit="return exportUser()" role="form">
			<div class="form-group">
				<div class="input-group"><div class="input-group-addon">用户组</div>
				<select name="gid" class="form-control"><?php echo $select?></select>
			</div></div>
			<div class="form-group">
				<div class="input-group input-daterange"><div class="input-group-addon">注册时间</div>
				<input type="text" id="starttime" name="starttime" class="form-control" placeholder="开始日期" autocomplete="off">
				<span class="input-group-addon"><i class="fa fa-chevron-right"></i></span>
				<input type="text" id="endtime" name="endtime" class="form-control" placeholder="结束日期" autocomplete="off">
			</div></div>
			<div class="form-group">
				<div class="input-group"><div class="input-group-addon">用户状态</div>
				<select name="dstatus" class="form-control"><option value="">全部状态</option><option value="1">正常状态</option></select>
			</div></div>
            <p><input type="submit" name="submit" value="导出" class="btn btn-primary form-control"/></p>
        </form>
</div>
</div>
 </div>
</div>
<script src="<?php echo $cdnpublic?>layer/3.1.1/layer.min.js"></script>
<script src="<?php echo $cdnpublic?>bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="<?php echo $cdnpublic?>bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.zh-CN.min.js"></script>
<script>
function exportUser(){
	var starttime = $("input[name='starttime']").val();
	var endtime = $("input[name='endtime']").val();
	var gid = $("select[name='gid']").val();
	var dstatus = $("select[name='dstatus']").val();
	window.location.href='./download.php?act=user&starttime='+starttime+'&endtime='+endtime+'&gid='+gid+'&dstatus='+dstatus;
	return false;
}
$(document).ready(function(){
	$('.input-datepicker, .input-daterange').datepicker({
        format: 'yyyy-mm-dd',
		autoclose: true,
        clearBtn: true,
        language: 'zh-CN'
    });
})
</script>