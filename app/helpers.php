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
if(! function_exists('whereNotInMultipleColumn')){
    function whereNotInMultipleColumn(array $columns, $values){
		$values = array_map(function (array $value) {
            return "('".implode($value, "', '")."')"; 
		}, $values);
		
		
		$return =  '('.implode($columns, ', ').') not in ('.implode($values, ', ').')';
		return $return;
	}

}