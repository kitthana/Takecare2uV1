<?php
header("Content-type:application/json; charset=utf-8");
require 'database.php';
//print_r($_POST);
if(isset($_POST['add_member'])){
	$user_id = $_POST['user_id'];
	$group_id = $_POST['group_id'];
	$current_coin = "";
	//check coin left
	$sql = "SELECT `current_coin` FROM `user` WHERE user_id = 'user_id'";
	$result = mysqli_query($conn,$sql);
	while ($coin = mysqli_fetch_assoc($result)) {
		$current_coin = $coin['current_coin'];
	}
	if ($current_coin >= 0) {
		//check QR code exist
		$sql = "SELECT `user_id` FROM `user` WHERE `user_id` = '$user_id' OR `user_tell` = '$user_id'"; 
		$result = mysqli_query($conn,$sql);
		
		if (mysqli_num_rows($result) == 1){
			$group_member = "";
			$sql = "SELECT `group_member` FROM `group` WHERE group_id = '$group_id'"; // SELECT Group_Member
			$result = mysqli_query($conn,$sql);
			$run = mysqli_fetch_assoc($result);
			$group_member = $run['group_member']; // store member data example:("123,456,789")
			$member = explode(",",$group_member); // string to array for check exist user in the group
			if (in_array($user_id,$member)) {
					header('HTTP/1.1 400 Bad Request', true, 200);
			    	$myObj->status = "fail";
					$myObj->message = "มีผู้ใช้นี้ในกลุ่มแล้ว";
				    $myJSON = json_encode($myObj);
				    echo $myJSON;
			}
			else{
				$new_member = $group_member.','.$user_id;
				$sql = "UPDATE `group` SET `group_member`='$new_member' WHERE group_id = '$group_id'";
				$result = mysqli_query($conn,$sql);
				$sql2 = "INSERT INTO `group_id`(`group_id`, `user_id`) VALUES ('$group_id','$user_id')";
				$result2 = mysqli_query($conn,$sql2);
				
				header('HTTP/1.1 200 OK', true, 200);
				$myObj->status = "success";
				$myObj->message = "เพิ่มผู้ใช้เรียบร้อยแล้ว";
			    $myJSON = json_encode($myObj);
			    echo $myJSON;
			}

	    }
	    else{
	    	header('HTTP/1.1 400 Bad Request', true, 200);
	    	$myObj->status = "fail";
			$myObj->message = "ไม่มีผู้ใช้นี้";
		    $myJSON = json_encode($myObj);
		    echo $myJSON;
	    }
    ////////////////////////
	}
	else{
		header('HTTP/1.1 400 Bad Request', true, 400);
	    $myObj->status = "Coin not enough,Please topup!";
	    $myJSON = json_encode($myObj);
	    echo $myJSON;
	}
	//////////////////
	
}
else {   
		header('HTTP/1.1 400 Bad Request', true, 200);
	    $myObj->status = "Name does not match";
	    $myJSON = json_encode($myObj);
	    echo $myJSON;
    
}
?>