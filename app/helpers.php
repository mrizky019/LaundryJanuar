<?php 
if(! function_exists('get_server')){
    function get_server($id){
		$other_ip = [];
		foreach(config('app.IP_SERVER') as $key => $value){
			if($key != $id-1){
				array_push($other_ip, $value);
			}
		}

        return $other_ip;
        
    }

}