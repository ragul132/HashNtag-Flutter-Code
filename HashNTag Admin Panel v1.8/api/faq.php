<?php 
require dirname( dirname(__FILE__) ).'/inc/Connection.php';
header('Content-type: text/json');
$data = json_decode(file_get_contents('php://input'), true);
if($data['uid'] == '')
{
    $returnArr = array("ResponseCode"=>"401","Result"=>"false","ResponseMsg"=>"Something Went Wrong!");
}
else
{
    $uid = strip_tags(mysqli_real_escape_string($dating,$data['uid']));
    
    
$language = isset($_GET['language']) ? $_GET['language'] : 'en';

$check = $dating->query("
SELECT *
FROM tbl_faq_translation
WHERE status = 1
AND language = '$language'
");
$op = array();
while($row = $check->fetch_assoc())
{
		$op[] = $row;
}
$returnArr = array("FaqData"=>$op,"ResponseCode"=>"200","Result"=>"true","ResponseMsg"=>"Faq List Get Successfully!!");
}
echo json_encode($returnArr);