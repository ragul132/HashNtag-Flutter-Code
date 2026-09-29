<?php
require "Connection.php";
class Gomeet
{
    private $dating;

    public function __construct($dating)
    {
        $this->dating = $dating;
    }
    
    
    
    
    public function datinglogin($username, $password, $tblname)
    {
        $licenseResult = $this->licensevalidate();
         if ($licenseResult == 1) {
            if($tblname == 'admin')
		{
            $q = "SELECT * FROM " . $tblname . " WHERE username='" . $username . "' AND password='" . $password . "'";
            return $this->dating->query($q)->num_rows;
        }
		else 
		{
			$q = "SELECT * FROM " . $tblname . " WHERE email='" . $username . "' AND password='" . $password . "'";
            return $this->dating->query($q)->num_rows;
		}
         }
         else 
         {
          return -1;   
         }
        
    }

   

    

    

}
?>
